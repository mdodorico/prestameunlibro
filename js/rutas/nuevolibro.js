angular.module('finalApp')
.component('nuevolibro', {
	templateUrl	: 'templates/nuevolibro.html',
	controller	: function ($http, $auth, $location) {
		var ctrl = this;

		var initAutores = function () {
			$http.get('api/autores')
				.then(function (response) {
					ctrl.autores = response.data;
				})
				.catch(function (response) {
					console.error(response);
				});
		}
		
		var initGeneros = function () {
			$http.get('api/generos')
				.then(function (response) {
					ctrl.generos = response.data;
				})
				.catch(function (response) {
					console.error(response);
				});
		}
		
		ctrl.guardar = function () {
			$http.post('api/libros', ctrl.nuevoLibro)
				.then(function (response) {
					ctrl.nuevoLibro = null;
					$location.path('/libros');
				})
				.catch(function (response) {
					console.error(response);
				});
		}
		
		this.$onInit = function () {
			initAutores();
			initGeneros();
			ctrl.nuevoLibro = null;
		}
	}
})
;