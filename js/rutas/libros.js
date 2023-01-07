angular.module('finalApp')
.component('libros', {
	templateUrl	: 'templates/libros.html',
	controller	: function ($http, $auth) {
		var ctrl = this;
		
		var initPerfil = function () {
			$http.get('api/perfil')
				.then(function (response) {
					ctrl.miPerfil = response.data;
				})
				.catch(function (response) {
					console.error(response);
				});
		}
		
		var initLibros = function () {
			$http.get('api/libros')
				.then(function (response) {
					ctrl.libros = response.data;
				})
				.catch(function (response) {
					console.error(response);
				});
		}
		
		this.$onInit = function () {
			initPerfil();
			initLibros();
		}
	}
})
;