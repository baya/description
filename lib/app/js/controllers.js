'use strict';

/* Controllers */

function TableListCtrl($scope, Tables) {
    $scope.tables = Tables.query();
}


function TableDetailCtrl($scope, $routeParams, Table) {
    $scope.table = Table.get({tableName: $routeParams.tableName});
}

