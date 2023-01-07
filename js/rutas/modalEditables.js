angular.module('finalApp')
.component('modalEditables', {
    templateUrl : 'templates/modal_editables.html',
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
		
		ctrl.guardarLibro = function () {
			if (ctrl.nuevoLibro!=null) {
				if (ctrl.nuevoLibro.id!=null) { 
					$http.patch('api/libros/'+ctrl.nuevoLibro.id, ctrl.nuevoLibro)
						.then(function (response) {
							ctrl.nuevoLibro = null;
							ctrl.close({$value: 'ok'});
						})
						.catch(function (response) {
							if (response.status==404) {
								alert('ERROR: No se encontró el libro con id ' + ctrl.nuevoLibro.id);
							} else {
								console.error(response);
							}
						});
				} 
			}
		}
		
		var initAutores = function () {
			$http.get('api/autores')
				.then(function (response) {
					ctrl.autores = response.data;
				})
				.catch(function (response) {
					console.error(response);
				});
		}
		
		var initGeneros = function () {
			$http.get('api/generos')
				.then(function (response) {
					ctrl.generos = response.data;
				})
				.catch(function (response) {
					console.error(response);
				});
		}
		
        ctrl.$onInit = function () {
            $http.get('api/libros/' + ctrl.resolve.idLibro)
                .then(function (response) {
                    ctrl.nuevoLibro = response.data;
                })
                .catch(function (response) {
                    if (response.status==404) {
                        alert('No se encontró el libro con id ' + ctrl.resolve.idLibro);
                    } else {
                    console.error(response);
                    }
                });
            };
			initAutores();
			initGeneros();
        }
});

