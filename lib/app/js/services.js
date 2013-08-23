'use strict';

/* Services */

angular.module('tableServices', ['ngResource']).
    factory('Table', function($resource){
  return $resource('phones/:phoneId.json', {}, {
    query: {method:'GET', params:{phoneId:'phones'}, isArray:true}
  });
});
