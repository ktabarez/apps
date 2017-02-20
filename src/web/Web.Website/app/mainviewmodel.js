/// <reference path="C:\projects\Applications\ITGov\Dev-ProjectManagement\ITGov.Project.Web\Scripts/angular.js" />
/// <reference path="app.js" />
/// <reference path="C:\projects\Applications\ITGov\Dev-ProjectManagement\ITGov.Project.Web\Scripts/angular-route.js" />

var MainViewModel = function ($window, $scope, $cookies) {
    var self = this

    var _type = arguments.callee.name;
    self.pageTitle = 'Welcome Home!';

    self.user = {};

    self.breadcrumbs = [{
            location: '/',
            name: 'Home'
        }];

    self.onViewShown = function () {
        $.support.cors = true;
    };

    self.navigateHome = function () {
        $window.location.href = '/';
    };

    self.onViewShown = function () {
        console.log({
            msg: 'controller.' + _type + '.onviewshown',
            scope: $scope
        });
    };

    $scope.$on('event:auth-loginConfirmed', function (event, data) {
        self.user.securityInfo = $cookies.getObject('userSecurityInfo');
    });
};

app.controller('MainViewModel', [
	'$window',
    '$scope',
    '$cookies',
	MainViewModel
]);