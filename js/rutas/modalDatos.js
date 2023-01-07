angular.module('finalApp')
.component('modalDatos', {
    templateUrl : 'templates/modal_datos.html',
    bindings: {
        resolve : '<',
        close : '&',
        dismiss : '&'
    },
    controller: function ($http, $window) {
        var ctrl = this;

        ctrl.cancel = function () {
            ctrl.dismiss({$value: 'cancel'});
        };
		
		ctrl.guardarPerfil = function () {
			$http.patch('api/perfil/'+ctrl.usuarioEditado.id, ctrl.usuarioEditado)
				.then(function (response) {
					ctrl.usuarioEditado = null;
					ctrl.close({$value: 'ok'});
				})
				.catch(function (response) {
					if (response.status==404) {
						alert('ERROR: No se encontró su perfil');
					} else {
						console.error(response);
					}
				}); 
		}
		
		var initLocalidades = function () {
			$http.get('api/localidades')
				.then(function (response) {
					ctrl.localidades = response.data;
				})
				.catch(function (response) {
					console.error(response);
				});
		}
		
        ctrl.$onInit = function () {
            $http.get('api/perfil')
                .then(function (response) {
                    ctrl.usuarioEditado = response.data;
                })
                .catch(function (response) {
                    if (response.status==404) {
                        alert('No se encontró el usuario con id ' + ctrl.resolve.idUser);
                    } else {
                    console.error(response);
                    }
                });
            };
			initLocalidades();
        }
});

