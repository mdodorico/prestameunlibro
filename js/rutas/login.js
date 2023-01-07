angular.module('finalApp')
.component('login', {
	templateUrl	: 'templates/login.html',
	controller	: function ($auth, $location) {
		var ctrl = this;

		ctrl.ingresar = function () {
			$auth.login({"email": ctrl.login.email, "clave": ctrl.login.clave }) 
				.then(function(response) {
					$auth.setToken(response.data.jwt);
					$location.path('/libros');
				})
				.catch(function(response) {
					alert("Login incorrecto");
					ctrl.login = {};
				});
		}

		this.$onInit = function () {
			ctrl.login = {};
		}
	}
})
;