angular.module('finalApp')
.component('autores', {
	templateUrl	: 'templates/autores.html',
	controller	: function ($http, $auth) {
		var ctrl = this;

		var initAutores = function () {
			$http.get('api/autores')
				.then(function (response) {
					ctrl.autores = response.data;
				})
				.catch(function (response) {
					console.error(response);
				});
		}

		this.$onInit = function () {
			initAutores();
		}
	}
})
;