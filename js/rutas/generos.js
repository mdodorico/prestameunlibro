angular.module('finalApp')
.component('generos', {
	templateUrl	: 'templates/generos.html',
	controller	: function ($http, $auth) {
		var ctrl = this;

		var initGeneros = function () {
			$http.get('api/generos')
				.then(function (response) {
					ctrl.generos = response.data;
				})
				.catch(function (response) {
					console.error(response);
				});
		}

		this.$onInit = function () {
			initGeneros();
		}
	}
})
;