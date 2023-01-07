angular.module('finalApp')
.component('miperfil', {
	templateUrl	: 'templates/miperfil.html',
	controller	: function ($auth, $http, $location, $uibModal) {
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
		
		ctrl.editarPerfil = function() {
			initPerfil();
			var modalInstance = $uibModal.open({
                animation: true,
                component: 'modalDatos',
                resolve: {
                    idUser: function () {
                        return ctrl.miPerfil.id;
                    },
                },
            });
			
			modalInstance.result
                .then(function (response) {
					initPerfil();
                })
                .catch(function (response) {
                });
		}
		
		ctrl.editarLibro = function(id) {
			var modalInstance = $uibModal.open({
                animation: true,
                component: 'modalEditables',
                resolve: {
                    idLibro: function () {
                        return id;
                    },
                },
            });
			
			modalInstance.result
                .then(function (response) {
					ctrl.mostrarLibros();
                })
                .catch(function (response) {
                });
		}
		
		ctrl.mostrarMensajes = function() {
			$http.get('api/mensajes')
				.then(function (response) {
					ctrl.nuevosMensajes = response.data;
				})
				.catch(function (response) {
					if (response.status==404) {
						alert('No se encontraron mensajes');
					} else {
						console.error(response);
					}
				});
		}
		
		ctrl.mostrarLibros = function() {
			$http.get('api/editables')
				.then(function (response) {
					ctrl.misEditables = response.data;
				})
				.catch(function (response) {
					if (response.status==404) {
						alert('No se encontraron libros asociados a tu perfil');
					} else {
						console.error(response);
					}
				});
		}
		
		ctrl.eliminarLibro = function (id) {
			if (confirm('¿Está seguro de querer borrar este libro?')) {
				$http.delete('api/libros/' + id)
					.then(function (response) {
						initPerfil();
						ctrl.mostrarLibros();
					})
					.catch(function (response) {
						if (response.status==404) {
							alert('ERROR: No se encontró el libro');
						} else {
							console.error(response);
						}
					});
			}
		}

		ctrl.eliminarPerfil = function () {
			if (confirm('ADVERTENCIA: ¿Está seguro que quiere eliminar su usuario? Esta acción no puede deshacerse.')) {
				$http.delete('api/perfil')
					.then(function (response) {
						$auth.logout();
						$location.path('/login');
					})
					.catch(function (response) {
						if (response.status==404) {
							alert('ERROR: No se pudo eliminar su usuario');
						} else {
							console.error(response);
						}
					});
			}
		}
		
		ctrl.eliminarMensaje = function(id) {
			if (confirm('¿Borrar este mensaje?')) {
				$http.delete('api/mensajes/' + id)
					.then(function (response) {
						ctrl.mostrarMensajes();
					    ctrl.nuevosMensajes = null;
					})
					.catch(function (response) {
						if (response.status==404) {
							alert('ERROR: No se encontró el mensaje');
						} else {
							console.error(response);
						}
					});
			}
		}
		
		this.$onInit = function () {
			initPerfil();
			ctrl.unLibro = null;
			ctrl.usuarioEditado = null;
			ctrl.nuevosMensajes = null;
			ctrl.misEditables = null;
		}
	}
})
;