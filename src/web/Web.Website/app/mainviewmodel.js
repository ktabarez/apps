/// <reference path="C:\projects\Applications\ITGov\Dev-ProjectManagement\ITGov.Project.Web\Scripts/angular.js" />
/// <reference path="app.js" />
/// <reference path="C:\projects\Applications\ITGov\Dev-ProjectManagement\ITGov.Project.Web\Scripts/angular-route.js" />

var MainViewModel = function ($window, projectRequestService) {
	var self = this

    self.header = {
    	title: 'Project Requests',
    	myProjectRequestStyle: '',
    	hideEditableButtonsClass: 'hide',
    	environment: 'DEV',
    }

    self.user = {
    	username: 'Kain Tabarez',
    	email: 'kaint@missionfed.com',
    }

    self.onViewShown = function () {
    	$.support.cors = true;
    }

    self.navigateHome = function () {
		$window.location.href = '/';
    }
};

app.controller('MainViewModel', [
	'$window',
	'projectRequestService',
	MainViewModel
]);