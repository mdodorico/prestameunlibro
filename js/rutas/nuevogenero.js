angular.module('finalApp')
.component('nuevogenero', {
	templateUrl	: 'templates/nuevogenero.html',
	controller	: function ($http, $auth, $location) {
		var ctrl = this;
		var nuevoGenero = {};
		
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
			$http.post('api/generos', ctrl.nuevoGenero)
				.then(function (response) {
					ctrl.nuevoGenero = null;
					$location.path('/generos');
				})
				.catch(function (response) {
					console.error(response);
				});
			}
	}
});