'use strict';

/* App Module */

angular.module('table-description', ['tableFilters', 'tablesIndex', 'tableShow']).
  config(['$routeProvider', function($routeProvider) {
  $routeProvider.
      when('/tables', {templateUrl: 'partials/table-list.html',   controller: TableListCtrl}).
      when('/tables/:tableName', {templateUrl: 'partials/table-detail.html', controller: TableDetailCtrl}).
      otherwise({redirectTo: '/tables'});
}]);
