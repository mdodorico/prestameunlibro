<!doctype html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Prestame un libro</title>
		
		<link rel="icon" type="image/x-icon" href="assets/book.ico" />
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w==" crossorigin="anonymous"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.5.0/font/bootstrap-icons.min.css" integrity="sha512-xnP2tOaCJnzp2d2IqKFcxuOiVCbuessxM6wuiolT9eeEJCyy0Vhcwa4zQvdrZNVqlqaxXhHqsSV1Ww7T2jSCUQ==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
        
		<script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.8.2/angular.min.js" integrity="sha512-7oYXeK0OxTFxndh0erL8FsjGvrl2VMDor6fVqzlLGfwOQQqTbYsGPv4ZZ15QHfSk80doyaM0ZJdvkyDcVO7KFA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-route/1.8.2/angular-route.min.js" integrity="sha512-5zOAub3cIpqklnKmM05spv4xttemFDlbBrmRexWiP0aWV8dlayEGciapAjBQWA7lgQsxPY6ay0oIUVtY/pivXA==" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/satellizer/0.14.1/satellizer.min.js" integrity="sha512-ZLAGfaREnf5hq51URaG84dBY6DhCVOxxwvhMEsPPRj5qTbN9NU2cp4hyaWzc9a0k1UrsLYWU5vbVPvme0d/n6A==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://cdn.jsdelivr.net/npm/ui-bootstrap4@3.0.7/dist/ui-bootstrap-tpls-3.0.7.min.js" integrity="sha256-96+Nb1OsO7ZKMVU4puySQLSKV3/y/ZcOuM1HMMhMliY=" crossorigin="anonymous"></script>
		
		<style>
            .form-signin {
              width: 100%;
              max-width: 330px;
              padding: 15px;
              margin: auto;
            }
            .bd-placeholder-img {
            font-size: 1.125rem;
            text-anchor: middle;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
            }
            @media (min-width: 768px) {
            .bd-placeholder-img-lg {
            font-size: 3.5rem;
            }
            }
            .container {
            max-width: 960px;
            }
            .lh-condensed {
            line-height: 1.25; 
			}
        </style>
    </head>
    <body background="assets/biblio.jpg" data-ng-app="finalApp">
        <navbar></navbar>
        <div class="container-md">
            <div class="py-5 text-center" style="color:White">
                <h2>Prestame un libro</h2>
                <p class="lead">Sitio de intercambio de libros entre usuarios</p>
            </div>
            <ng-view></ng-view>
        </div>
        <br>
        <script src="js/app.js"></script>
		<?php
            $d = dir("js/partes");
			while (false !== ($entry = $d->read())) {
			if(substr($entry, -3) == '.js'){
				print '<script src="js/partes/'.$entry.'"></script>' . PHP_EOL;
			    }
			}
            $d->close();
			$d = dir("js/rutas");
			while (false !== ($entry = $d->read())) {
			if(substr($entry, -3) == '.js'){
				print '<script src="js/rutas/'.$entry.'"></script>' . PHP_EOL;
			    }
			}
            $d->close();
        ?>
    </body>
</html>
