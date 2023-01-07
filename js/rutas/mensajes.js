angular.module('finalApp')
.component('mensajes', {
	templateUrl	: 'templates/mensajes.html',
	controller	: function ($http, $auth, $location) {
		var ctrl = this;
		
		var initUsuarios = function () {
			$http.get('api/usuarios')
				.then(function (response) {
					ctrl.usuarios = response.data;
				})
				.catch(function (response) {
					console.error(response);
				});
		}

		ctrl.enviar = function() {
			$http.post('api/mensajes', ctrl.nuevoMensaje)
				.then(function (response) {
					alert('Su mensaje fue enviado.');
					ctrl.nuevoMensaje = null;
					$location.path('/mensajes');
					initUsuarios();
				})
				.catch(function (response) {
				    console.error(response);
				});
		}
		
		this.$onInit = function () {
			initUsuarios();
			ctrl.nuevoMensaje = null;
		}
	}
})
;