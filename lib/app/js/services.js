'use strict';

/* Services */

angular.module('tablesIndex', ['ngResource']).
  factory('Tables', function($resource){
      return $resource('tables.json');
  });

angular.module('tableShow', ['ngResource']).
  factory('Table', function($resource){
      return $resource('tables/:tableName.json');
  });
