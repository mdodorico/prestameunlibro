angular.module('finalApp')
.component('navbar', {
	templateUrl	: 'templates/navbar.html',
	controller	: function ($auth, $location, $http) {
		var ctrl = this;
		
		ctrl.salir = function () {
			if (confirm ('¿Está seguro que quiere salir?')) {
				$http.post('api/logout')
					.then(function (response) {
						$auth.logout();
						$location.path('/login');
					})
					.catch(function (response) {
						alert('No se puede salir del sistema');
					})
			}
		}
		
		ctrl.actual = function (ruta) {
			return $location.path() == ruta;
		}

		this.$onInit = function () {
			ctrl.autenticado = $auth.isAuthenticated;
		}
		
	}
})
;