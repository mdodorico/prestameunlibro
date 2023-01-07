angular.module('finalApp')
.component('modalPerfil', {
    templateUrl : 'templates/modal_perfil.html',
    bindings: {
        resolve : '<',
        close : '&',
        dismiss : '&'
    },
    controller: function ($http) {
        var ctrl = this;

        ctrl.cancel = function () {
            ctrl.dismiss({$value: 'cancel'});
        };

        ctrl.$onInit = function () {
            $http.get('api/usuarios/' + ctrl.resolve.idUsuario)
                .then(function (response) {
                    ctrl.unUsuario = response.data;
                })
                .catch(function (response) {
                    if (response.status==404) {
                        alert('No se encontró el usuario con id ' + ctrl.resolve.idUsuario);
                    } else {
                    console.error(response);
                    }
                });
            };
        }
});

