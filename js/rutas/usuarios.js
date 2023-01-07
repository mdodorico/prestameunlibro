angular.module('finalApp')
.component('usuarios', {
	templateUrl	: 'templates/usuarios.html',
	controller	: function ($http, $auth, $uibModal) {
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
		
		ctrl.mostrar = function(id) {
            var modalInstance = $uibModal.open({
                animation: true,
                component: 'modalPerfil',
                resolve: {
                    idUsuario: function () {
                        return id;
                    },
                },
            });
			
			modalInstance.result
                .then(function (response) {
                })
                .catch(function (response) {
                });
        }

		this.$onInit = function () {
			initUsuarios();
			ctrl.unUsuario = null;
		}
	}
})
;