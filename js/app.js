angular.module('finalApp', ['ngRoute', 'satellizer', 'ui.bootstrap'])
.config(function($authProvider, $httpProvider) {
	var rutaRelativa = window.location.pathname.substr(0,window.location.pathname.lastIndexOf('/'))+'/'; 
	$authProvider.baseUrl = rutaRelativa;
	$authProvider.loginUrl = 'api/login';
	$authProvider.tokenName = 'jwt';
	$httpProvider.interceptors.push(function($q, $window, $rootScope) {
		return {
			'responseError': function (rejection) {
				if(rejection.status === 401) {
					$rootScope.logut();
					$window.location.href = rutaRelativa;
				}
				return $q.reject(rejection);
			}
		};
	});
})
.config(function($routeProvider) { 
	$routeProvider
		.when("/", {
			template: '<login></login>',
			resolve: {
				necesitaLogin: saltarSiLogueado
			},
		})
		.when("/login", {
			template: '<login></login>',
			resolve: {
				necesitaLogin: saltarSiLogueado
			},
		})
		.when("/nuevousuario", {
			template: '<nuevousuario></nuevousuario>',
			resolve: {
				necesitaLogin: saltarSiLogueado
			},
		})
		.when("/nuevogenero", {
			template: '<nuevogenero></nuevogenero>',
			resolve: {
				necesitaLogin: loginRequerido
			},
		})
		.when("/libros", {
			template: '<libros></libros>',
			resolve: {
				necesitaLogin: loginRequerido
			},
		})
		.when("/nuevolibro", {
			template: '<nuevolibro></nuevolibro>',
			resolve: {
				necesitaLogin: loginRequerido
			},
		})
		.when("/nuevoautor", {
			template: '<nuevoautor></nuevoautor>',
			resolve: {
				necesitaLogin: loginRequerido
			},
		})
		.when("/usuarios", {
			template: '<usuarios></usuarios>',
			resolve: {
				necesitaLogin: loginRequerido
			},
		})
		.when("/autores", {
			template: '<autores></autores>',
			resolve: {
				necesitaLogin: loginRequerido
			},
		})
		.when("/generos", {
			template: '<generos></generos>',
			resolve: {
				necesitaLogin: loginRequerido
			},
		})
		.when("/miperfil", {
			template: '<miperfil></miperfil>',
			resolve: {
				necesitaLogin: loginRequerido
			},
		})
		.when("/mensajes", {
			template: '<mensajes></mensajes>',
			resolve: {
				necesitaLogin: loginRequerido
			},
		})
		.when("/ayuda", {
			template: '<ayuda></ayuda>',
			resolve: {
				necesitaLogin: loginRequerido
			},
		})
		.when("/preguntas", {
			template: '<preguntas></preguntas>',
			resolve: {
				necesitaLogin: loginRequerido
			},
		})
		.when("/sobrenosotros", {
			template: '<sobrenosotros></sobrenosotros>',
			resolve: {
				necesitaLogin: loginRequerido
			},
		})
		.when("/404", {
			templateUrl: '404.html',
		})
		.otherwise('/404');
		;

		function saltarSiLogueado($q, $auth, $location) {
			var diferido = $q.defer();
			if ($auth.isAuthenticated()) {
				$location.path('/libros');
				diferido.reject();
			} else {
				diferido.resolve(); 
			}
			return diferido.promise; 
	    };

	    function loginRequerido($q, $auth, $location) {
			var diferido = $q.defer();
			if ($auth.isAuthenticated()) {
				diferido.resolve();
			} else {
				$location.path('/login');
				diferido.reject();
			}
			return diferido.promise;
		}
})
;