<?php

require_once '../config/jwt_helper.php';
require_once '../config/db.php';

define('ALGORITMO', 'HS512');
define('SECRET_KEY', 'AS..-.DJKLds·ak$dl%Ll!3kj12l3k1sa4_ÑÑ312ñ12LK3Jj4DK5A6LS7JDLK¿?asDqiwUEASDL,NMQWIEUIO');

if (!isset($_GET['accion'])) {
    outputError();
}

$metodo = strtolower($_SERVER['REQUEST_METHOD']);
$accion = explode('/', strtolower($_GET['accion']));
$funcionNombre = $metodo . ucfirst($accion[0]);
$parametros = array_slice($accion, 1);
if (count($parametros) >0 && $metodo == 'get') {
    $funcionNombre = $funcionNombre.'ConParametros';
}
if (function_exists($funcionNombre)) {
    call_user_func_array ($funcionNombre, $parametros);
} else {
    outputError(400);
}

function outputJson($data, $codigo = 200)
{
    header('', true, $codigo);
    header('Content-type: application/json');
    print json_encode($data);
}

function outputError($codigo = 500)
{
    switch ($codigo) {
        case 400:
            header($_SERVER["SERVER_PROTOCOL"] . " 400 Bad request", true, 400);
            die;
        case 404:
            header($_SERVER["SERVER_PROTOCOL"] . " 404 Not Found", true, 404);
            die;
        case 401:
            header($_SERVER["SERVER_PROTOCOL"] . " 401 Unauthorized", true, 401);
            die;
        default:
            header($_SERVER["SERVER_PROTOCOL"] . " 500 Internal Server Error", true, 500);
            die;
            break;
    }
}

function conectarBD()
{
    $link = mysqli_connect(DBHOST, DBUSER, DBPASS, DBBASE);
    if ($link === false) {
        print "Falló la conexión: " . mysqli_connect_error();
        outputError(500);
    }
    return $link;
}

function requireLogin() {
    $authHeader = getallheaders();
    try
    {
        list($jwt) = @sscanf( $authHeader['Authorization'], 'Bearer %s');
        $datos = JWT::decode($jwt, SECRET_KEY, ALGORITMO);
        if (time() > $datos->expira) {
            postLogout();
            throw new Exception("Token expirado", 1);
        }
        $link = conectarBD();
        $resultado = mysqli_query($link, "SELECT 1 FROM tokens WHERE token = '$jwt'");
        if (!($resultado && mysqli_num_rows($resultado)==1)) {
            throw new Exception("Token inválido", 1);
        }
        mysqli_close($link);
    } catch(Exception $e) {
        outputError(401);
    }
	return $datos;
}

function postLogin() {
    $loginData = json_decode(file_get_contents("php://input"), true);
    $link = conectarBD();

    $email = mysqli_real_escape_string($link, $loginData['email']);
    $clave = mysqli_real_escape_string($link, $loginData['clave']);

    $sql = "SELECT id FROM usuarios WHERE email='$email' AND clave='$clave'";
    $resultado = mysqli_query($link, $sql);
    if($resultado && mysqli_num_rows($resultado)==1) {
        $res = mysqli_fetch_assoc($resultado);
        $data = [
            'expira'    => time() + 3600,
            'id'        => $res['id']+0,
        ];
        $jwt = JWT::encode($data, SECRET_KEY, ALGORITMO);
        if (mysqli_query($link, "INSERT INTO tokens (token) VALUES ('$jwt')")) {
            outputJson(['jwt' => $jwt]);
            die;
        }
    }
    outputError(401);
}

function postLogout() {
    $link = conectarBD();
    $authHeader = getallheaders();
    list($jwt) = @sscanf( $authHeader['Authorization'], 'Bearer %s');
    if (!mysqli_query($link, "DELETE FROM tokens WHERE token = '$jwt'")) {
        throw new Exception("Token inválido", 1);
    }
    mysqli_close($link);
}

function getLibros()
{
	requireLogin();
    $link = conectarBD();
    $sql = "SELECT l.id AS id, l.titulo AS titulo, IFNULL(GROUP_CONCAT(DISTINCT a.nombre, ' ', a.apellido SEPARATOR ', '), '') AS autor, l.idioma AS idioma, l.ciudad AS ciudad, 
	               l.anio AS anio, l.sinopsis AS sinopsis, l.tapa AS tapa, us.alias AS usuario, IFNULL(GROUP_CONCAT(DISTINCT g.genero SEPARATOR ', '), '') AS genero 
            FROM libros AS l 
            LEFT JOIN usuario_libro AS ul ON l.id = ul.id_libro 
            LEFT JOIN usuarios AS us ON us.id = ul.id_usuario 
            LEFT JOIN libro_genero AS lg on l.id = lg.id_libro
            LEFT JOIN generos AS g ON g.id = lg.id_genero
			LEFT JOIN libro_autor AS la ON l.id = la.id_libro
			LEFT JOIN autores AS a ON a.id = la.id_autor
            GROUP BY l.id";
    $resultado = mysqli_query($link, $sql);
    if ($resultado === false) {
        outputError(500);
		die;
    }
	
    $ret = [];
    while ($fila = mysqli_fetch_assoc($resultado)) {
        settype($fila['id'], 'integer');
		$ret[] = $fila;
    }
    mysqli_free_result($resultado);
    mysqli_close($link);
    outputJson($ret);
}

function getLibrosConParametros($id)
{
	requireLogin();
	$link = conectarBD();
	settype($id, 'integer');
	
    $sql = "SELECT l.id AS id, l.titulo AS titulo, IFNULL(GROUP_CONCAT(DISTINCT a.id SEPARATOR ', '), '') AS autores, l.idioma AS idioma, l.ciudad AS ciudad,
                   l.anio AS anio, l.sinopsis AS sinopsis, l.tapa AS tapa, IFNULL(GROUP_CONCAT(DISTINCT g.id SEPARATOR ', '), '') AS generos
            FROM libros AS l
            LEFT JOIN libro_genero AS lg on l.id = lg.id_libro
            LEFT JOIN generos AS g ON g.id = lg.id_genero
            LEFT JOIN libro_autor AS la ON l.id = la.id_libro
            LEFT JOIN autores AS a ON a.id = la.id_autor
            WHERE l.id=$id
            GROUP BY l.id";
			
    $resultado = mysqli_query($link, $sql);
    if ($resultado === false) {
        outputError(500);
		die;
    }
    if (mysqli_num_rows($resultado) == 0) {
        outputError(404);
    }

    $fila = mysqli_fetch_assoc($resultado);
    settype($fila['id'], 'integer');
	
    $generos=[];
    foreach (explode(',', $fila['generos']) as $gid) {
        $generos[] = $gid + 0;
    }
    $fila['generos'] = $generos;
	
    $autores = [];
    foreach (explode(',', $fila['autores']) as $aid) {
        $autores[] = $aid + 0;
    }
    $fila['autores'] = $autores;

    mysqli_free_result($resultado);
    mysqli_close($link);
    outputJson($fila);
}

function getEditables()
{
    $info = requireLogin();
    $idUsuario = $info->id;
   
    $link = conectarBD();
    $sql = "SELECT l.id AS id, l.titulo AS titulo, IFNULL(GROUP_CONCAT(DISTINCT CONCAT(a.nombre, ' ', a.apellido) SEPARATOR ', '), '') AS autor, l.idioma AS idioma, l.ciudad AS ciudad,
                   l.anio AS anio, l.sinopsis AS sinopsis, l.tapa AS tapa, us.alias AS usuario, IFNULL(GROUP_CONCAT(DISTINCT g.genero SEPARATOR ', '), '') AS genero
            FROM libros AS l
            LEFT JOIN usuario_libro AS ul ON l.id = ul.id_libro
            LEFT JOIN usuarios AS us ON us.id = ul.id_usuario
            LEFT JOIN libro_genero AS lg on l.id = lg.id_libro
            LEFT JOIN generos AS g ON g.id = lg.id_genero
            LEFT JOIN libro_autor AS la ON l.id = la.id_libro
            LEFT JOIN autores AS a ON a.id = la.id_autor
            WHERE us.id=$idUsuario
            GROUP BY l.id";
           
    $resultado = mysqli_query($link, $sql);
    if ($resultado === false) {
        outputError(500);
        die;
    }
   
    $ret = [];
    while ($fila = mysqli_fetch_assoc($resultado)) {
        settype($fila['id'], 'integer');
        $generos = [];
        foreach (explode(',', $fila['genero']) as $gid) {
            $generos[] = $gid;
        }
        $fila['genero'] = $generos;
        $autores = [];
        foreach (explode(',', $fila['autor']) as $aid) {
            $autores[] = $aid;
        }
        $fila['autor'] = $autores;
        $ret[] = $fila;
    }
    mysqli_free_result($resultado);
    mysqli_close($link);
    outputJson($ret);
}

function getUsuarios()
{
	requireLogin();
    $link = conectarBD();
	
    $sql = "SELECT u.id, u.alias, u.url_foto, u.email, l.localidad 
	        FROM usuarios AS u
			INNER JOIN localidades AS l ON u.localidad = l.id";
    $resultado = mysqli_query($link, $sql);
	
    if ($resultado === false) {
        outputError(500);
		die;
    }
    $ret = [];
    while ($fila = mysqli_fetch_assoc($resultado)) {
        settype($fila['id'], 'integer');
		$ret[] = $fila;
    }
    mysqli_free_result($resultado);
    mysqli_close($link);
    outputJson($ret);
}

function getUsuariosConParametros($id)
{
	requireLogin();
    $link = conectarBD();
	settype($id, 'integer');
	
    $sql = "SELECT u.id, u.alias, u.url_foto, u.email, l.localidad 
	        FROM usuarios AS u
			INNER JOIN localidades AS l ON u.localidad = l.id
			WHERE u.id=$id";
    $resultado = mysqli_query($link, $sql);
    if ($resultado === false) {
        outputError(500);
		die;
    }
    if (mysqli_num_rows($resultado) == 0) {
        outputError(404);
    }

    $fila = mysqli_fetch_assoc($resultado);
	settype($fila['id'], 'integer');

    mysqli_free_result($resultado);
    mysqli_close($link);
    outputJson($fila);
}

function getGeneros()
{
	requireLogin();
    $link = conectarBD();
	
    $sql = "SELECT id, genero FROM generos";
    $resultado = mysqli_query($link, $sql);
	
    if ($resultado === false) {
        outputError(500);
		die;
    }
    $ret = [];
    while ($fila = mysqli_fetch_assoc($resultado)) {
        settype($fila['id'], 'integer');
		$ret[] = $fila;
    }
    mysqli_free_result($resultado);
    mysqli_close($link);
    outputJson($ret);
}

function getLocalidades()
{
	$link = conectarBD();
	
    $sql = "SELECT id, localidad FROM localidades";
    $resultado = mysqli_query($link, $sql);
	
    if ($resultado === false) {
        outputError(500);
		die;
    }
    $ret = [];
    while ($fila = mysqli_fetch_assoc($resultado)) {
        settype($fila['id'], 'integer');
		$ret[] = $fila;
    }
    mysqli_free_result($resultado);
    mysqli_close($link);
    outputJson($ret);
}

function getPerfil()
{
	$info = requireLogin();
    $idUsuario = $info->id;
   
    $link = conectarBD();
    settype($id, 'integer');
   
    $sql = "SELECT u.id, u.alias, u.email, u.url_foto, u.localidad as localidad_id, l.localidad as localidad
            FROM usuarios AS u
            INNER JOIN localidades AS l ON u.localidad = l.id
            WHERE u.id=$idUsuario";
    $resultado = mysqli_query($link, $sql);
    if ($resultado === false) {
        outputError(500);
        die;
    }
    if (mysqli_num_rows($resultado) == 0) {
        outputError(404);
    }

    $fila = mysqli_fetch_assoc($resultado);
    settype($fila['id'], 'integer');
    $fila['localidad'] = ['id' => $fila['localidad_id'], 'localidad' => $fila['localidad']];
    unset($fila['localidad_id']);

    mysqli_free_result($resultado);
    mysqli_close($link);
    outputJson($fila);
}

function getMensajes()
{
	$info = requireLogin();
	$idUsuario = $info->id;
	
	$link = conectarBD();
	settype($id, 'integer');
	
    $sql = "SELECT m.id, m.mensaje AS mensaje, u.alias AS remitente
	        FROM mensajes AS m 
			LEFT JOIN remitente_mensaje AS rm ON m.id = rm.id_mensaje
			LEFT JOIN usuarios AS u ON u.id = rm.id_remitente
			WHERE destinatario=$idUsuario";
    $resultado = mysqli_query($link, $sql);
    
	if ($resultado === false) {
        outputError(500);
		die;
    }
    if (mysqli_num_rows($resultado) == 0) {
        outputError(404);
    }

    $ret = [];
    while ($fila = mysqli_fetch_assoc($resultado)) {
        settype($fila['id'], 'integer');
		$ret[] = $fila;
    }

    mysqli_free_result($resultado);
    mysqli_close($link);
    outputJson($ret);
}

function getAutores()
{
	requireLogin();
    $link = conectarBD();
    $sql = "SELECT id, nombre, apellido, nacimiento, muerte FROM autores";
    $resultado = mysqli_query($link, $sql);
    if ($resultado === false) {
        outputError(500);
		die;
    }
	
    $ret = [];
    while ($fila = mysqli_fetch_assoc($resultado)) {
        settype($fila['id'], 'integer');
        $ret[] = $fila;
    }
	
    mysqli_free_result($resultado);
    mysqli_close($link);
    outputJson($ret);
}

function postLibros()
{
	$info = requireLogin();
	$idUsuario = $info->id;
	
    $link = conectarBD();
    $dato = json_decode(file_get_contents('php://input'), true);
	
    $titulo = mysqli_real_escape_string($link, $dato['titulo']);
    $idioma = mysqli_real_escape_string($link, $dato['idioma']);
	$ciudad = mysqli_real_escape_string($link, $dato['ciudad']);
	$anio = mysqli_real_escape_string($link, $dato['anio']);
	$sinopsis = mysqli_real_escape_string($link, $dato['sinopsis']);
	
	if (isset($dato['tapa']) && $dato['tapa']!='') {
		$tapa = mysqli_real_escape_string($link, $dato['tapa']);
		$sql = "INSERT INTO libros (titulo, idioma, ciudad, anio, sinopsis, tapa) VALUES ('$titulo', '$idioma', '$ciudad', $anio, '$sinopsis','$tapa')";
	} else {
		$sql = $sql = "INSERT INTO libros (titulo, idioma, ciudad, anio, sinopsis, tapa) VALUES ('$titulo', '$idioma', '$ciudad', $anio, '$sinopsis', null)";
	}
	
    $resultado = mysqli_query($link, $sql);
    if ($resultado === false) {
        outputError(500);
		die;
    }
	
	$lid = mysqli_insert_id($link);

	$sql = "INSERT INTO usuario_libro (id_libro, id_usuario) VALUES ($lid, $idUsuario)";
	$resultado = mysqli_query($link, $sql);
	if ($resultado === false) {
		print mysqli_error($link);
		outputError(500);
	}
	
	foreach ($dato['generos'] as $gid) {
		$sql = "INSERT INTO libro_genero (id_genero, id_libro) VALUES ($gid, $lid)";
		$resultado = mysqli_query($link, $sql);
		if ($resultado === false) {
			print mysqli_error($link);
			outputError(500);
		}
	}
	
	foreach ($dato['autores'] as $aid) {
		$sql = "INSERT INTO libro_autor (id_libro, id_autor) VALUES ($lid, $aid)";
		$resultado = mysqli_query($link, $sql);
		if ($resultado === false) {
			print mysqli_error($link);
			outputError(500);
		}
	}
	
	$ret = ['id'=>$lid]; 
    mysqli_close($link);
    outputJson($ret);
}

function postMensajes()
{
    $info = requireLogin();
	$idUsuario = $info->id;
	
	$link = conectarBD();
    $dato = json_decode(file_get_contents('php://input'), true);
	
	$destinatario = mysqli_real_escape_string($link, $dato['destinatario']);
	$mensaje = mysqli_real_escape_string($link, $dato['mensaje']);
	
	$sql = "INSERT INTO mensajes (destinatario, mensaje) VALUES ($destinatario, '$mensaje')";
    $resultado = mysqli_query($link, $sql);
    if ($resultado === false) {
        outputError(500);
		die;
    }
	
    $mid = mysqli_insert_id($link);

	$sql = "INSERT INTO remitente_mensaje (id_mensaje, id_remitente) VALUES ($mid, $idUsuario)";
	$resultado = mysqli_query($link, $sql);
	
	if ($resultado === false) {
		print mysqli_error($link);
		outputError(500);
	}
	
	$ret = ['id'=>$mid]; 
    mysqli_close($link);
    outputJson($ret);
}

function postAyuda()
{
    $info = requireLogin();
	$idUsuario = $info->id;
	
	$link = conectarBD();
    $dato = json_decode(file_get_contents('php://input'), true);
	
	$mensaje = mysqli_real_escape_string($link, $dato['mensaje']);
	
	$sql = "INSERT INTO mensajes (destinatario, mensaje) VALUES (1, '$mensaje')";
    $resultado = mysqli_query($link, $sql);
    if ($resultado === false) {
        outputError(500);
		die;
    }
	
    $mid = mysqli_insert_id($link);

	$sql = "INSERT INTO remitente_mensaje (id_mensaje, id_remitente) VALUES ($mid, $idUsuario)";
	$resultado = mysqli_query($link, $sql);
	
	if ($resultado === false) {
		print mysqli_error($link);
		outputError(500);
	}
	
	$ret = ['id'=>$mid]; 
    mysqli_close($link);
    outputJson($ret);
}

function postUsuarios()
{
    $link = conectarBD();
    $dato = json_decode(file_get_contents('php://input'), true);

    $alias = mysqli_real_escape_string($link, $dato['alias']);
    $email = mysqli_real_escape_string($link, $dato['email']);
    $clave = mysqli_real_escape_string($link, $dato['clave']);
	$localidad = mysqli_real_escape_string($link, $dato['localidad']);
	
	if (isset($dato['url_foto']) && $dato['url_foto']!='') {
		$url_foto = mysqli_real_escape_string($link, $dato['url_foto']);
		$sql = "INSERT INTO usuarios (alias, url_foto, email, clave, localidad) VALUES ('$alias', '$url_foto', '$email', '$clave', $localidad)";
	} else {
		$sql = "INSERT INTO usuarios (alias, url_foto, email, clave, localidad) VALUES ('$alias', null, '$email', '$clave', $localidad)";
	}
	
    $resultado = mysqli_query($link, $sql);
    if ($resultado === false) {
        outputError(500);
		die;
    }
	
	$ret = ['id' => mysqli_insert_id($link)];
    
    mysqli_close($link);
    outputJson($ret);
}

function postAutores()
{
	requireLogin();
    $link = conectarBD();
    $dato = json_decode(file_get_contents('php://input'), true);

    $nombre = mysqli_real_escape_string($link, $dato['nombre']);
	$apellido = mysqli_real_escape_string($link, $dato['apellido']);
	$nacimiento = mysqli_real_escape_string($link, $dato['nacimiento']);
	
	if (isset($dato['muerte']) && $dato['muerte']!='') {
		$muerte = mysqli_real_escape_string($link, $dato['muerte']);
		$sql = "INSERT INTO autores (nombre, apellido, nacimiento, muerte) VALUES ('$nombre', '$apellido', '$nacimiento', '$muerte')";
	} else {
		$sql = "INSERT INTO autores (nombre, apellido, nacimiento, muerte) VALUES ('$nombre', '$apellido', '$nacimiento', null)";
	}
   
    $resultado = mysqli_query($link, $sql);
    if ($resultado === false) {
        outputError(500);
		die;
    }
	
    $ret = ['id' => mysqli_insert_id($link)];
    mysqli_close($link);
    outputJson($ret);
}

function postGeneros()
{
	requireLogin();
    $link = conectarBD();
    $dato = json_decode(file_get_contents('php://input'), true);

    $genero = mysqli_real_escape_string($link, $dato['genero']);
   
	$sql = "INSERT INTO generos (genero) VALUES ('$genero')";
	
    $resultado = mysqli_query($link, $sql);
    if ($resultado === false) {
        outputError(500);
		die;
    }
	
    $ret = ['id' => mysqli_insert_id($link)];
    mysqli_close($link);
    outputJson($ret);
}

function patchLibros($id) 
{
	requireLogin();
    $link = conectarBD();
	
	settype($id, 'integer');
    $dato = json_decode(file_get_contents('php://input'), true);

    $titulo = mysqli_real_escape_string($link, $dato['titulo']);
    $idioma = mysqli_real_escape_string($link, $dato['idioma']);
	$ciudad = mysqli_real_escape_string($link, $dato['ciudad']);
	$anio = mysqli_real_escape_string($link, $dato['anio']);
	$sinopsis = mysqli_real_escape_string($link, $dato['sinopsis']);
	
	if (isset($dato['tapa']) && $dato['tapa']!='') {
		$tapa = mysqli_real_escape_string($link, $dato['tapa']);
		$sql = "UPDATE libros SET titulo='$titulo', idioma='$idioma', ciudad='$ciudad', anio='$anio', sinopsis='$sinopsis',tapa='$tapa' WHERE id=$id";
	} else {
		$sql = "UPDATE libros SET titulo='$titulo', idioma='$idioma', ciudad='$ciudad', anio='$anio', sinopsis='$sinopsis',tapa=null WHERE id=$id";
	}
	
	$resultado = mysqli_query($link, $sql);
    if ($resultado === false) {
        outputError(500);
		die;
    }
	
	$sql = "DELETE FROM libro_genero WHERE id_libro=$id";
	$resultado = mysqli_query($link, $sql);
	
	foreach ($dato['generos'] as $gid) {
		$sql = "INSERT INTO libro_genero (id_genero, id_libro) VALUES ($gid, $id)";
		$resultado = mysqli_query($link, $sql);
		if ($resultado === false) {
			print mysqli_error($link);
			outputError(500);
		}
	}
	
	$sql = "DELETE FROM libro_autor WHERE id_libro=$id";
	$resultado = mysqli_query($link, $sql);
	
	foreach ($dato['autores'] as $aid) {
		$sql = "INSERT INTO libro_autor (id_libro, id_autor) VALUES ($id, $aid)";
		$resultado = mysqli_query($link, $sql);
		if ($resultado === false) {
			print mysqli_error($link);
			outputError(500);
		}
	}
	
    $ret = [];
    mysqli_close($link);
    outputJson($ret);
}

function patchPerfil()
{
    $info = requireLogin();
    $idUsuario = $info->id;
   
    $link = conectarBD();
    $dato = json_decode(file_get_contents('php://input'), true);

    $alias = mysqli_real_escape_string($link, $dato['alias']);
    $email = mysqli_real_escape_string($link, $dato['email']);
    $clave = mysqli_real_escape_string($link, $dato['clave']);
    $localidad = mysqli_real_escape_string($link, $dato['localidad']['id']);
   
    if (isset($dato['url_foto']) && $dato['url_foto']!='') {
        $url_foto = mysqli_real_escape_string($link, $dato['url_foto']);
        $sql = "UPDATE usuarios SET alias='$alias', url_foto='$url_foto', email='$email', clave='$clave', localidad='$localidad' WHERE id=$idUsuario";
    } else {
        $sql = "UPDATE usuarios SET alias='$alias', url_foto=null, email='$email', clave='$clave', localidad='$localidad' WHERE id=$idUsuario";
    }
   
    $resultado = mysqli_query($link, $sql);
    if ($resultado === false) {
        outputError(500);
        die;
    }
   
    $ret = [];
    mysqli_close($link);
    outputJson($ret);
}

function deleteLibros($id)
{
	requireLogin();
    $link = conectarBD();
	settype($id, 'integer');
	
    $sql = "DELETE FROM Libros WHERE id=$id";
    $resultado = mysqli_query($link, $sql);
	
    if ($resultado === false) {
        outputError(500);
		die;
    }
    if (mysqli_affected_rows($link) == 0) {
        outputError(404);
        die;
    }
    mysqli_close($link);
    outputJson([]);
}

function deleteMensajes($id)
{
	requireLogin();
    $link = conectarBD();
	settype($id, 'integer');
	
    $sql = "DELETE FROM mensajes WHERE id=$id";
    $resultado = mysqli_query($link, $sql);
	
    if ($resultado === false) {
        outputError(500);
		die;
    }
    if (mysqli_affected_rows($link) == 0) {
        outputError(404);
        die;
    }
    mysqli_close($link);
    outputJson([]);
}

function deletePerfil()
{
	$info = requireLogin();
	$idUsuario = $info->id;
	
    $link = conectarBD();
	settype($id, 'integer');
	
    $sql = "DELETE FROM usuarios WHERE id=$idUsuario";
    $resultado = mysqli_query($link, $sql);
	
    if ($resultado === false) {
        outputError(500);
		die;
    }
   if (mysqli_affected_rows($link) == 0) {
        outputError(404);
        die;
    }
    mysqli_close($link);
    outputJson([]);
}

?>