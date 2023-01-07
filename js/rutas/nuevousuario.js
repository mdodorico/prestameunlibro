angular.module('finalApp')
.component('nuevousuario', {
	templateUrl	: 'templates/nuevousuario.html',
	controller	: function ($http, $auth, $location) {
		var ctrl = this;
		var nuevoUsuario = {};
		
		var initLocalidades = function () {
			$http.get('api/localidades')
				.then(function (response) {
					ctrl.localidades = response.data;
				})
				.catch(function (response) {
					console.error(response);
				});
		}
		
		ctrl.guardar = function () {
			$http.post('api/usuarios', ctrl.nuevoUsuario)
				.then(function (response) {
					ctrl.nuevoUsuario = null;
					$location.path('/login');
				})
				.catch(function (response) {
					console.error(response);
				});
		}
		
		this.$onInit = function () {
			initLocalidades();
		}
	}
});