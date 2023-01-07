angular.module('finalApp')
.component('ayuda', {
	templateUrl	: 'templates/ayuda.html',
	controller	: function ($http, $auth, $location) {
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
		
		ctrl.enviar = function() {
			$http.post('api/ayuda', ctrl.help)
				.then(function (response) {
					alert('Su mensaje fue enviado. Le responderemos a la brevedad.');
					$location.path('/libros');
					initPerfil();
					ctrl.help= null;
				})
				.catch(function (response) {
				    console.error(response);
				});
		}
		
		this.$onInit = function () {
			initPerfil();
			ctrl.help = null;
		}
	}
})
;