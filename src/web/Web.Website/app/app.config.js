app.config(['$routeProvider', '$locationProvider', '$httpProvider', function ($routeProvider, $locationProvider, $httpProvider) {
    /*------------interceptors------------*/
    //$httpProvider.interceptors.push(['$window', function ($window) {
    //    return {
    //        request: function(config) {
    //            console.log({
    //                msg: 'ajax.request.success',
    //                url: config.url,
    //                data: config
    //            });

    /*------------headers------------*/

    //initialize get if not there
    if (!$httpProvider.defaults.headers.get) {
        $httpProvider.defaults.headers.get = {};
    }

    // Answer edited to include suggestions from comments
    // because previous version of code introduced browser-related errors

    //disable IE ajax request caching
    $httpProvider.defaults.headers.get['If-Modified-Since'] = 'Mon, 26 Jul 1997 05:00:00 GMT';
    $httpProvider.defaults.headers.get['Cache-Control'] = 'no-cache';
    $httpProvider.defaults.headers.get['Pragma'] = 'no-cache';

    /*------------routes------------*/

    $routeProvider.when('/', {
        templateUrl: '/app/dashboard/index.html',
        cache: false,
    });
    $routeProvider.when('/memberfeedback', {
        templateUrl: '/app/dashboard/memberfeedback/index.html',
        cache: false,
    });
    $routeProvider.when('/memberfeedback/:feedbackCode', {
        templateUrl: '/app/dashboard/memberfeedback/item.html',
        cache: false,
    });

    $routeProvider.otherwise({ redirectTo: '/' });

    /*------------providers------------*/

    $locationProvider.html5Mode({
        enabled: true,
        requireBase: false
    });
}]);