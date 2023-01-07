angular.module('finalApp')
.component('nuevoautor', {
	templateUrl	: 'templates/nuevoautor.html',
	controller	: function ($http, $auth, $location) {
		var ctrl = this;
		var nuevoAutor = {};
		
		var initAutores = function () {
			$http.get('api/autores')
				.then(function (response) {
					ctrl.autores = response.data;
				})
				.catch(function (response) {
					console.error(response);
				});
		}

		ctrl.guardar = function () {
			$http.post('api/autores', ctrl.nuevoAutor)
				.then(function (response) {
					ctrl.nuevoAutor = null;
					$location.path('/autores');
				})
				.catch(function (response) {
					console.error(response);
				});
			}
	}
});