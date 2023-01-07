-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-07-2021 a las 22:39:33
-- Versión del servidor: 10.4.18-MariaDB
-- Versión de PHP: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `biblioteca`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `autores`
--

CREATE TABLE `autores` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `apellido` varchar(255) NOT NULL,
  `nacimiento` int(11) NOT NULL,
  `muerte` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `autores`
--

INSERT INTO `autores` (`id`, `nombre`, `apellido`, `nacimiento`, `muerte`) VALUES
(1, 'Adolfo', 'Bioy Casares', 1914, 1999),
(2, 'Arthur', 'Conan Doyle', 1859, 1930),
(3, 'Lewis', 'Carroll', 1832, 1898),
(4, 'Neil', 'Gaiman', 1960, NULL),
(5, 'Bram', 'Stoker', 1847, 1912),
(6, 'Max', 'Brooks', 1972, NULL),
(7, 'Dan', 'Brown', 1964, NULL),
(8, 'Miguel Angel', 'Ravina', 1958, NULL),
(9, 'Julio', 'Cortazar', 1914, 1984),
(10, 'Jorge Luis', 'Borges', 1899, 1986),
(11, 'Stephen', 'King', 1947, NULL),
(12, 'J. R. R.', 'Tolkien', 1892, 1973),
(13, 'Victoria', 'Ocampo', 1890, 1979),
(14, 'Ernesto', 'Sabato', 1911, 2011),
(15, 'Thomas', 'Harris', 1940, NULL),
(16, 'Roberto', 'Arlt', 1900, 1942),
(17, 'Louisa May', 'Alcott', 1832, 1888),
(18, 'Terry', 'Pratchett', 1948, 2015),
(19, 'Isaac', 'Asimov', 1920, 1992),
(20, 'Peter', 'Straub', 1943, NULL),
(21, 'Dante', 'Alighieri', 1265, 1321);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `generos`
--

CREATE TABLE `generos` (
  `id` int(11) NOT NULL,
  `genero` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `generos`
--

INSERT INTO `generos` (`id`, `genero`) VALUES
(1, 'Terror'),
(2, 'Comedia'),
(3, 'Romance'),
(4, 'Fantasia'),
(5, 'Ciencia Ficcion'),
(6, 'Historia'),
(7, 'Drama'),
(8, 'Poesia'),
(9, 'Policial'),
(10, 'Misterio'),
(11, 'Aventura'),
(12, 'Tragedia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libros`
--

CREATE TABLE `libros` (
  `id` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `idioma` varchar(255) NOT NULL,
  `ciudad` varchar(255) NOT NULL,
  `anio` int(4) NOT NULL,
  `sinopsis` varchar(255) NOT NULL,
  `tapa` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `libros`
--

INSERT INTO `libros` (`id`, `titulo`, `idioma`, `ciudad`, `anio`, `sinopsis`, `tapa`) VALUES
(1, 'Estudio en escarlata', 'Español', 'Buenos Aires', 2000, 'Es la primera historia del legendario detective Sherlock Holmes y de su amigo, el doctor Watson, un cirujano militar que regresa a Londres tras su participación en la guerra.', 'https://www.anayainfantilyjuvenil.com/images/libros/grande/9788420712659-estudio-en-escarlata-tus-libros-seleccion.jpg'),
(2, 'Alicia en el País de las Maravillas', 'Español', 'Buenos Aires', 1996, 'Una niña llamada Alicia cae por una madriguera de conejo, encontrándose en un mundo peculiar, poblado por humanos y criaturas sumamente peculiares.', 'https://images.cdn1.buscalibre.com/fit-in/360x360/42/7f/427f18ddc9cb21b5d943a63517df875a.jpg'),
(4, 'Good Omens', 'Ingles', 'Londres', 2005, 'El fin del mundo se acerca, lo que significa que Aziraphale, un ángel quisquilloso, y Crowley, un demonio de mala vida, que se han encariñado demasiado con la vida en la Tierra, se ven obligados a formar una extraña alianza para detener el Armagedón.', ' https://idolosolvidados.com/wp-content/uploads/2019/08/978844500669.jpg'),
(5, 'Dracula', 'Español', 'Madrid', 2011, 'Cuando Jonathan Harker viajó a Transilvania por negocios, nunca imaginó el peligro que corría. Su cliente, el conde Drácula, lo mantiene prisionero y Harker adivina sus oscuros propósitos: viajar a Londres para sembrar el terror y saciar su sed de sangre.', 'https://images.cdn3.buscalibre.com/fit-in/360x360/cc/ea/ccea8c19caed539d49d82b9d9b4481e4.jpg'),
(6, 'Guerra Mundial Z', 'Español', 'Madrid', 2006, 'Cuando una pandemia de zombis amenaza con destruir a la humanidad, un ex-investigador de Naciones Unidas es obligado a regresar al servicio para intentar descubrir la fuente de la infección.', 'https://images-na.ssl-images-amazon.com/images/I/51q+RmHMZmL._SX327_BO1,204,203,200_.jpg'),
(8, 'El código Da Vinci', 'Español', 'Buenos Aires', 2006, 'La mayor conspiración de los últimos 2000 años está a punto de ser desvelada. Robert Langdon recibe una llamada en mitad de la noche: el conservador del museo del Louvre ha sido asesinado en extrañas circunstancias.', 'https://planetadelibrosar0.cdnstatics.com/usuaris/libros/fotos/70/m_libros/69136_portada_el-codigo-da-vinci_dan-brown_201706061655.jpg'),
(10, 'Los 4 vientos y el arco iris', 'Español', 'Buenos Aires', 2002, 'Cuatro adolescentes viajan a los siete reinos del arco iris, que esta amenazado por las fuerzas oscuras, para cumplir una misión y poder liberar al rey blanco, quien unifica a los siete reinos.', 'https://images-na.ssl-images-amazon.com/images/I/61KqeHBfKKL.jpg'),
(18, 'It', 'Ingles', 'Nueva York', 1986, 'Un grupo de siete niños son aterrorizados por un monstruo -al que llaman «Eso»- que es capaz de cambiar de forma, alimentándose del terror que produce en sus víctimas.', 'https://http2.mlstatic.com/D_NQ_NP_923864-MLA26385008258_112017-O.jpg'),
(19, 'El Señor de los Anillos: La Comunidad del Anillo', 'Español', 'Madrid', 1999, 'En la adormecida e idílica Comarca, un joven hobbit llamado Frodo recibe un encargo: custodiar el Anillo Único y emprender el viaje para su destrucción en el Monte del Destino.', 'https://images.cdn1.buscalibre.com/fit-in/360x360/c6/78/c678ab2c90ed50d7d8849e30bc92b05a.jpg'),
(20, 'El resplandor', 'Español', 'Barcelona', 1989, 'Jack Torrance acepta una oferta de trabajo en un hotel de montaña que se encuentra a 65 kilómetros del pueblo más cercano. Pronto comenzarán a manifestarse espíritus y apariciones extrañas.', 'https://www.penguinlibros.com/cl/286197/el-resplandor.jpg'),
(21, 'Inferno', 'Ingles', 'Londres', 2013, 'El profesor Robert Langdon se despierta en un hospital en mitad de la noche, desorientado y con una herida en la cabeza. No recuerda nada de las últimas treinta y seis horas y desconoce el origen del extraño objeto encontrado en sus pertenencias.', 'https://images.cdn2.buscalibre.com/fit-in/360x360/d1/98/d19893d0a5aeac5f067a521176ba9d47.jpg'),
(23, 'El Señor de los Anillos: las dos torres', 'Español', 'Madrid', 1999, 'Continúa la narración de las aventuras de los protagonistas de La Comunidad del Anillo: la muerte de Boromir, el secuestro de Merry y Pippin por los orcos de Saruman y su posterior huida, las batallas de Aragorn, Legolas y Gimli en el Oeste en contra de l', 'https://2.bp.blogspot.com/-w64YOnpfvO0/VqUOikEAmaI/AAAAAAAAOr0/hmOfbOELYPw/s1600/las_dos_torres.jpg'),
(25, 'El Hobbit', 'Español', 'Barcelona', 2002, 'Narra la historia del hobbit Bilbo Bolsón, que junto con el mago Gandalf y un grupo de enanos, vive una aventura para buscar el tesoro custodiado por el dragón Smaug en la Montaña Solitaria.', 'https://images-na.ssl-images-amazon.com/images/I/51Xpx9sRT-L.jpg'),
(26, 'Involución', 'Ingles', 'Nueva York', 2020, 'Greenloop fue, hasta la inesperada erupción del Rainier, una selecta comunidad ecológica. Ubicada en los bosques del estado de Washington ofrecía una vida idílica gracias a unos avances tecnológicos que estaban en comunión con la naturaleza. Ahora, de ent', 'https://m.media-amazon.com/images/I/61aQTenYsCL.jpg'),
(35, 'Carrie', 'Español', 'Madrid', 2015, 'Cuenta la historia de una adolescente con problemas de socialización, depresiva y nerviosa, que solo quiere encajar y vivir su sueño de sentirse normal. La muchacha realiza una serie de descubrimientos hasta llegar al terrible momento de la venganza.', 'https://images.cdn1.buscalibre.com/fit-in/360x360/25/3b/253b35902bbebc059355fa26c19d9dc4.jpg'),
(36, 'El Señor de los Anillos: el retorno del Rey', 'Español', 'Madrid', 1999, 'Hombres, elfos y enanos unen sus fuerzas para presentar batalla a Sauron y sus huestes. Ajenos a estos preparativos, Frodo y Sam siguen adentrándose en el país de Mordor en su heroico viaje para destruir el Anillo de Poder en el Monte del Destino.', 'https://cloud10.todocoleccion.online/libros-segunda-mano-ciencia-ficcion-fantasia/tc/2015/09/19/16/51374059.jpg'),
(37, 'Alicia a través del espejo', 'Español', 'Madrid', 1997, 'Alicia se pregunta cómo debe de ser el Mundo a Través del Espejo y se sorprende al comprobar que puede pasar a través de él, y llega a un mundo de fantasía poblado por seres extraños. Allí, debe jugar una gran partida de ajedrez.', 'https://expreso.co.cr/alicia/wp-content/gallery/portadas3/libro01.jpg'),
(40, 'El signo de los 4', 'Ingles', 'Londres', 2005, 'El pedido de una mujer a Sherlock Holmes para acompañarla a visitar a un hombre lo lleva a descubrir, junto a Watson, el secreto que hay tras un tesoro encontrado en la India, un juramento entre tres indios, un blanco y una enloquecedora sed de venganza.', 'https://www.estudioenescarlata.com/media/img/portadas/9788415988700.jpg'),
(45, 'La caza del Snark', 'Español', 'Barcelona', 2000, 'El poema describe el viaje imposible de una tripulación improbable, para hallar a una criatura inconcebible. Toma elementos del poema Jabberwocky, de Alicia a través del espejo.', 'https://images-na.ssl-images-amazon.com/images/I/51vA95YRtkL._SX331_BO1,204,203,200_.jpg'),
(47, 'Mujercitas', 'Español', 'Madrid', 2017, 'La novela cuenta la historia de las hermanas March, cuatro jovencitas que vivían en un pueblo de Nueva Inglaterra mientras la guerra civil hacía estragos en toda América.', 'https://cdn.lavoz.com.ar/sites/default/files/file_attachments/nota_periodistica/mujercitas-louisa-may-alcott-tapa-dura-16407-MLA20119616874_062014-F_1574433716.jpg'),
(48, 'Hannibal', 'Ingles', 'Nueva York', 2002, 'El Dr. Hannibal Lecter todavía elude al FBI. La agente especial Clarice Starling, quien se entrevistó con Lecter durante su encarcelación buscando ayuda para capturar al asesino en serie Buffalo Bill, es la encargada de la búsqueda de Lecter.', 'https://images.cdn1.buscalibre.com/fit-in/360x360/d0/20/d020abe6344c9e73eefab23dbdbcfbc2.jpg'),
(51, 'El silencio de los inocentes', 'Ingles', 'Nueva York', 2002, 'A Clarice Starling, joven y ambiciosa estudiante de la academia del FBI, le encomiendan que entreviste a Hannibal Lecter, brillante psiquiatra y despiadado asesino, para conseguir su colaboración en la resolución de un caso de asesinatos en serie.', 'https://images.cdn1.buscalibre.com/fit-in/360x360/76/df/76df827235fe1c7c4ce2c1791b3dd16e.jpg'),
(53, 'Dragon Rojo', 'Ingles', 'Nueva York', 2002, 'Will Graham, investigador del FBI especializado en el comportamiento de los asesinos en serie, se ve obligado a recurrir a Hannibal Lecter para que lo ayude a atrapar a un asesino de familias conocido como \"el hada de los dientes\".', 'https://lelibros.online/uploads/2016/11/descargar-libro-el-dragon-rojo-hannibal-lecter-en-pdf-epub-mobi-o-leer-online.jpg'),
(54, 'El robot humano', 'Español', 'Buenos Aires', 1998, 'Su diferencia despertó pasiones encontradas entre los hombres. El NDR 113 adquirió celebridad como escultor, escritor y científico. Conquistó la libertad, se cambio de cuerpo y amasó una fortuna. Sólo una cosa le estuvo vedada: la condición de ser humano.', 'https://tercerafundacion.net/imagenes/portada/P-00015426.jpg'),
(55, 'El símbolo perdido', 'Español', 'Madrid', 2009, 'El experto en simbología Robert Langdon es convocado inesperadamente por Peter Solomon, su antiguo mentor, para dar una conferencia en el Capitolio. Pero el secuestro de Peter y el hallazgo de una mano tatuada con cinco enigmáticos símbolos cambian drásti', 'https://www.planetadelibros.com/usuaris/libros/fotos/254/m_libros/portada_el-simbolo-perdido_dan-brown_201706061659.jpg'),
(56, 'El talisman', 'Español', 'Barcelona', 2005, 'Jack Sawyer, de doce años, sabe que su madre está muriendo. O al menos lo sospecha. Sin embargo, su madre, una antigua actriz irónica y de lengua afilada, parece estar huyendo de alguien en particular, de alguien muy cercano, mientras ella y su hijo malga', 'https://images-na.ssl-images-amazon.com/images/I/51H99KoxNTL._SX324_BO1,204,203,200_.jpg'),
(57, 'La Divina Comedia', 'Español', 'Buenos Aires', 2003, 'Relata el viaje de Dante por el Infierno, el Purgatorio y el Paraíso, guiado por el poeta romano Virgilio.', 'https://images-na.ssl-images-amazon.com/images/I/71LJjyIgmNL.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libro_autor`
--

CREATE TABLE `libro_autor` (
  `id_libro` int(11) NOT NULL,
  `id_autor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `libro_autor`
--

INSERT INTO `libro_autor` (`id_libro`, `id_autor`) VALUES
(6, 6),
(8, 7),
(18, 11),
(20, 11),
(23, 12),
(26, 6),
(35, 11),
(36, 12),
(47, 17),
(48, 15),
(53, 15),
(51, 15),
(55, 7),
(19, 12),
(56, 11),
(56, 20),
(57, 21),
(54, 19),
(10, 8),
(4, 4),
(4, 18),
(25, 12),
(21, 7),
(5, 5),
(40, 2),
(45, 3),
(1, 2),
(37, 3),
(2, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libro_genero`
--

CREATE TABLE `libro_genero` (
  `id_genero` int(11) NOT NULL,
  `id_libro` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `libro_genero`
--

INSERT INTO `libro_genero` (`id_genero`, `id_libro`) VALUES
(1, 35),
(10, 35),
(9, 8),
(10, 8),
(1, 20),
(4, 36),
(4, 23),
(5, 6),
(1, 6),
(5, 26),
(1, 18),
(4, 18),
(3, 47),
(7, 47),
(9, 48),
(10, 48),
(9, 53),
(10, 53),
(9, 51),
(9, 55),
(10, 55),
(11, 55),
(4, 19),
(11, 19),
(1, 56),
(5, 56),
(8, 57),
(3, 57),
(5, 54),
(11, 10),
(4, 10),
(11, 4),
(2, 4),
(4, 4),
(4, 25),
(11, 25),
(9, 21),
(10, 21),
(1, 5),
(3, 5),
(10, 5),
(7, 40),
(9, 40),
(10, 40),
(11, 45),
(4, 45),
(8, 45),
(11, 1),
(10, 1),
(9, 1),
(4, 37),
(10, 37),
(11, 37),
(4, 2),
(11, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `localidades`
--

CREATE TABLE `localidades` (
  `id` int(11) NOT NULL,
  `localidad` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `localidades`
--

INSERT INTO `localidades` (`id`, `localidad`) VALUES
(1, 'Buenos Aires'),
(2, 'Ciudad Autónoma de Buenos Aires'),
(3, 'Catamarca'),
(4, 'Chaco'),
(5, 'Chubut'),
(6, 'Córdoba'),
(7, 'Corrientes'),
(8, 'Entre Ríos'),
(9, 'Formosa'),
(10, 'Jujuy'),
(11, 'La Pampa'),
(12, 'La Rioja'),
(13, 'Mendoza'),
(14, 'Misiones'),
(15, 'Neuquén'),
(16, 'Río Negro'),
(17, 'Salta'),
(18, 'San Juan'),
(19, 'San Luis'),
(20, 'Santa Cruz'),
(21, 'Santa Fe'),
(22, 'Santiago del Estero'),
(23, 'Tierra del Fuego'),
(24, 'Tucumán');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes`
--

CREATE TABLE `mensajes` (
  `id` int(11) NOT NULL,
  `destinatario` int(11) NOT NULL,
  `mensaje` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `mensajes`
--

INSERT INTO `mensajes` (`id`, `destinatario`, `mensaje`) VALUES
(2, 7, 'Como va? Avisame hasta cuando necesitas el libro porque me lo pidio otro usuario. Gracias! Saludos'),
(3, 6, 'Penny! Como va? Decime que día te queda más cómodo para devolverte el libro que me prestaste la semana pasada. Nos vemos!'),
(4, 5, 'Hola! Perdon que ayer al final no pude ir a buscar Involucion. Puedo pasar esta tarde? Saludos!'),
(5, 4, 'Buenos días; te puedo pedir prestado Alicia en el País de las Maravillas mañana? Mil gracias! Saludos'),
(6, 3, 'Heyy, como estas? Todo bien? Tenes de casualidad El Silencio de los Inocentes? Vi que no lo subiste, pero ante la duda consulto. Gracias!'),
(7, 2, 'Hola Bombita! Como estas tanto tiempo? Puedo pasar mañana por tu laburo a devolverte el libro? Gracias! Saludos'),
(9, 1, 'Buenas tardes! Queria coordinar con vos para ir a buscar el libro, puede ser? Quedo a la espera! Saludos'),
(10, 7, 'Como estas? Podemos coordinar para mañana asi voy a buscar el libro? Gracias!'),
(12, 10, 'Que bueno verte en esta pagina!!'),
(13, 9, 'Viste? Me encanto!'),
(14, 4, 'Que sorpresa encontrarte aca!'),
(15, 11, 'Bienvenido pirata!'),
(17, 11, 'Hola! tenes el Codigo de los Piratas? Gracias!'),
(18, 9, 'Existe el libro La Ciencia de la Deduccion? Gracias!'),
(19, 9, 'Finalmente me uni! Gracias por la recomendacion!'),
(22, 1, 'Buenas tardes: quería saber si no hay un error de ortografia en el autor Issac Asimov. No debería llevar dos s? Muchas gracias! Un saludo cordial.'),
(26, 1, 'Hola, necesito ayuda para cambiar la clave. Podrias enviarme una nueva? Gracias!'),
(33, 7, 'Hola, como estas? Avisame cuando tengas tiempo y arreglamos asi te devuelvo el libro. Muchas gracias!'),
(34, 1, 'Buenas tardes, necesito reiniciar mi clave por favor! Gracias!');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `remitente_mensaje`
--

CREATE TABLE `remitente_mensaje` (
  `id_mensaje` int(11) NOT NULL,
  `id_remitente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `remitente_mensaje`
--

INSERT INTO `remitente_mensaje` (`id_mensaje`, `id_remitente`) VALUES
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 7),
(7, 1),
(9, 5),
(10, 1),
(12, 9),
(13, 10),
(14, 11),
(15, 1),
(17, 2),
(18, 1),
(19, 14),
(22, 6),
(26, 3),
(33, 4),
(34, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tokens`
--

CREATE TABLE `tokens` (
  `token` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tokens`
--

INSERT INTO `tokens` (`token`) VALUES
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJleHBpcmEiOjE2MjUwNjgyNzYsImlkIjoxfQ.UMIzoaFXe3ZozIJwlLl0vKP5snx1uXk11Uy4NzF6KojYkLvOL7oLfUG56MHHDJHvrJMCWnYeJFUfONuFDAQApg'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJleHBpcmEiOjE2MjUwOTQzMDksImlkIjoyfQ.A-KUQoKiKJmoxijlrfUIU71NoCbVHZwumkFcnYq-ouLIjDtHKASdI197nsLPsxsOFEYAIP86XcUZnmgSRkg2pA'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJleHBpcmEiOjE2MjUwOTQ5NjUsImlkIjozfQ.AzQwjdmHuE5HRzsphwtsvLPMVqmgMbMrMxlVmVLguc3zaN8jnvYcamlU_v28NaXMcUflHAQmf10s3feRehrVXg'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJleHBpcmEiOjE2MjUwOTUzNzEsImlkIjozfQ.LupVqxvoP-LNwIgeG0EQiOSY8csHzEs3gJMi8VE0XLB-UcLG0nw9k1BLIadig6wTiYE-dO6NZEpsiyIIGPpnxg'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJleHBpcmEiOjE2MjUxODI0MDEsImlkIjozfQ.PnuZdfA6cEohcdiG-9zh_kD7S3YWvplmHZIQOIcNdWyLJBKTh049yyZWAhhtCLxP6IA-EKBfbS3tVeCMruZvQA'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJleHBpcmEiOjE2MjUzMjAzOTAsImlkIjo4fQ.XcQ1eTYj0h7XYW1nDzmdO_HWycJZDh9cq7BFMVIMdLSBVJgLOWohlKLnerRA2rQlDQsLgPabQhMeKG4uzqpBIw'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJleHBpcmEiOjE2MjU0OTI1MDMsImlkIjoxfQ.KJ9P_Zsf0dmffkuDsIPLQjl7d676k6fhBGSmWpfiPAjrHqHDdRGSCYv0qOygXtMZNXvS0xVgQ4VzIwSTlts1OA'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJleHBpcmEiOjE2MjczOTA2MjEsImlkIjoyNH0.PwFIUWvJGaJGhG1DuDNU5xEkuZBZOk4eLbTrKLV9c3EXyAIcjzIt4jBl-im6yDvuOBUXPLOq1LFnnhZZP43adA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `alias` varchar(255) NOT NULL,
  `url_foto` text DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `clave` varchar(255) NOT NULL,
  `localidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `alias`, `url_foto`, `email`, `clave`, `localidad`) VALUES
(1, 'Marian D\'Odorico', 'https://br.atsit.in/es/wp-content/uploads/2021/06/el-tiempo-de-ejecucion-de-suicide-squad-y-la-escena-posterior-a-los-creditos-confirmada-por-el-director-james-gunn-harley-quinn-en-the-suicide-squad.jpg', 'mariana8390@gmail.com', 'examenfinal', 2),
(2, 'Rachel Green', 'https://img2.rtve.es/im/5625961/?w=900', 'rachelgreen@outlook.com', 'ross', 2),
(3, 'Monica Geller', 'https://www.rockandpop.cl/wp-content/uploads/2020/03/Courtney-Cox-habla-sobre-la-reuni%C3%B3n-de-Friends-400x360.jpeg', 'monicageller@gmail.com', 'chandler', 1),
(4, 'Phoebe Buffay', 'https://3.bp.blogspot.com/-zcNo4Wy2Pdo/TzwpuGg6DiI/AAAAAAAABiU/_feQrJffmOA/s1600/phoebe+friends.jpg', 'phoebebuffay@outlook.com', 'myeyes', 10),
(5, 'Joey Tribbiani', 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/friends-joey-mejor-peor-personaje-1563950745.jpg', 'joeytribbiani@gmail.com', 'joey', 6),
(6, 'Chandler Bing', 'https://www.metro951.com/wp-content/uploads/2019/10/70cab067277a6ad55bd9dfe096a0d79a.jpg', 'chandlerbing@hotmail.com', 'monica', 17),
(7, 'Ross Geller', 'https://media.revistagq.com/photos/5cb725b0cd5468d970512e0c/master/pass/ross_geller_friends_1863.jpg', 'rossgeller@outlook.com', 'rachel', 20),
(9, 'Joan Watson', 'https://www.wovow.org/wp-content/uploads/2014/11/Elementary-wovow.org-01.png', 'joanwatson@outlook.com', 'sherlock', 15),
(10, 'Sherlock Holmes', 'https://i.pinimg.com/originals/2a/bf/74/2abf743d55fbddb041e60b5e97d46d06.jpg', 'sherlockholmes@gmail.com', 'watson', 16),
(11, 'Beth Harmon', 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/the-queen-s-gambit-077r-1603898589.jpg', 'bethharmon@gmail.com', 'ajedrez', 15),
(12, 'Sheldon Cooper', 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/the-big-bang-theory-final-sheldon-cooper-jim-parsons-1561048451.jpg', 'sheldoncooper@bigbang.com', 'spot', 13),
(14, 'Leonard Hofstadter', 'https://depor.com/resizer/mJ2MYlltQ_vToMTk9Pplpt774Rw=/1200x800/smart/filters:format(jpeg):quality(75)/cloudfront-us-east-1.images.arcpublishing.com/elcomercio/B3PY4IE2UZHG3IVPBRTFUQLR4M.jpg', 'leonardhofstadter@bigbang.com', 'penny', 19),
(16, 'Amy Farrah Fowler', 'https://as01.epimg.net/epik/imagenes/2019/10/05/portada/1570269550_256215_1570269718_noticia_normal_recorte1.jpg', 'amyfowler@bigbang.com', 'sheldon', 21);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_libro`
--

CREATE TABLE `usuario_libro` (
  `id_libro` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuario_libro`
--

INSERT INTO `usuario_libro` (`id_libro`, `id_usuario`) VALUES
(2, 1),
(5, 1),
(8, 3),
(20, 2),
(19, 3),
(1, 1),
(4, 1),
(6, 2),
(18, 2),
(10, 1),
(21, 1),
(23, 6),
(25, 1),
(26, 5),
(35, 2),
(36, 3),
(37, 1),
(40, 1),
(45, 1),
(47, 10),
(48, 9),
(51, 11),
(53, 10),
(54, 1),
(55, 11),
(56, 11),
(57, 16);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `autores`
--
ALTER TABLE `autores`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `generos`
--
ALTER TABLE `generos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `libros`
--
ALTER TABLE `libros`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `libro_autor`
--
ALTER TABLE `libro_autor`
  ADD KEY `id_libro` (`id_libro`),
  ADD KEY `id_autor` (`id_autor`);

--
-- Indices de la tabla `libro_genero`
--
ALTER TABLE `libro_genero`
  ADD KEY `id_genero` (`id_genero`),
  ADD KEY `id_libro` (`id_libro`);

--
-- Indices de la tabla `localidades`
--
ALTER TABLE `localidades`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `remitente_mensaje`
--
ALTER TABLE `remitente_mensaje`
  ADD KEY `deleteMensaje` (`id_mensaje`),
  ADD KEY `id_remitente` (`id_remitente`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `alias` (`alias`) USING BTREE;

--
-- Indices de la tabla `usuario_libro`
--
ALTER TABLE `usuario_libro`
  ADD KEY `deleteLibro` (`id_libro`),
  ADD KEY `deleteUsuario` (`id_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `autores`
--
ALTER TABLE `autores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de la tabla `generos`
--
ALTER TABLE `generos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `libros`
--
ALTER TABLE `libros`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT de la tabla `localidades`
--
ALTER TABLE `localidades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `libro_autor`
--
ALTER TABLE `libro_autor`
  ADD CONSTRAINT `libro_autor_ibfk_1` FOREIGN KEY (`id_libro`) REFERENCES `libros` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `libro_autor_ibfk_2` FOREIGN KEY (`id_autor`) REFERENCES `autores` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `libro_genero`
--
ALTER TABLE `libro_genero`
  ADD CONSTRAINT `libro_genero_ibfk_1` FOREIGN KEY (`id_genero`) REFERENCES `generos` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `libro_genero_ibfk_2` FOREIGN KEY (`id_libro`) REFERENCES `libros` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `remitente_mensaje`
--
ALTER TABLE `remitente_mensaje`
  ADD CONSTRAINT `deleteMensaje` FOREIGN KEY (`id_mensaje`) REFERENCES `mensajes` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `remitente_mensaje_ibfk_1` FOREIGN KEY (`id_remitente`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario_libro`
--
ALTER TABLE `usuario_libro`
  ADD CONSTRAINT `deleteLibro` FOREIGN KEY (`id_libro`) REFERENCES `libros` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `deleteUsuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
