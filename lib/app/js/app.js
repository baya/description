'use strict';

/* App Module */

angular.module('table-description', ['tableFilters', 'tableServices']).
  config(['$routeProvider', function($routeProvider) {
  $routeProvider.
      when('/tables', {templateUrl: 'partials/table-list.html',   controller: TableListCtrl}).
      when('/phones/:phoneId', {templateUrl: 'partials/phone-detail.html', controller: PhoneDetailCtrl}).
      otherwise({redirectTo: '/tables'});
}]);
