/// <reference path="C:\projects\Applications\ITGov\Dev-ProjectManagement\ITGov.Project.Web\Scripts/angular.js" />
/// <reference path="C:\projects\Applications\ITGov\Dev-ProjectManagement\ITGov.Project.Web\Scripts/angular-route.js" />

var RequestViewModel = function ($routeParams, $scope, $timeout, $uibModal, authenticationService, documentService, projectRequestService) {
	var self = this;


	self.projectRequestId = $routeParams.projectRequestId;

	self.projectRequest = {
		title: '',
		requestedBy: [],
		deliveredBy: '',
		contacts: [],
		workInProgressContacts: [],
		benefit: '',
		description: '',
		workInProgressInfo: '',
		attachments: [],
		comments: [],
	}

	self.title = 'ProjectRequestViewModel';

	var _onUserAuthenticated = function () {
		projectRequestService.getProjectRequest(self.projectRequestId).then(function (response) {
			response.data
		});
	}

	self.onViewShown = function () {
		$scope.$parent.$parent.mvm.header.hideEditableButtonsClass = '';

		authenticationService.authenticate().then(_onUserAuthenticated);
	}

	self.editProjectRequest = function () {
		$uibModal.open({
			keyboard: true,
			templateUrl: 'app/projectRequests/requests/new-request-form.html',
			backdrop: 'static'
		});
	}

	_init = function () {
		$timeout(function () {

			$(window).scroll(function () {
				if ($(this).scrollTop() > 100)
					$('.scrollup').fadeIn();
				else
					$('.scrollup').fadeOut();
			});

			$('.scrollup').click(function () {
				$("html, body").animate({
					scrollTop: 0
				}, 100);

				return false;
			});
		});
	}

	_init();
};

app.controller('RequestViewModel', ['$routeParams', '$scope', '$timeout', '$uibModal', 'authenticationService', 'documentService', 'projectRequestService', RequestViewModel]);