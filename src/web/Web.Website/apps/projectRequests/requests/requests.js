/// <reference path="C:\projects\Applications\ITGov\Dev-ProjectManagement\ITGov.Project.Web\Scripts/angular.js" />
/// <reference path="C:\projects\Applications\ITGov\Dev-ProjectManagement\ITGov.Project.Web\Scripts/angular-route.js" />
/// <reference path="../app.js" />

var RequestsViewModel = function ($timeout, $scope, $compile, projectRequestService, authenticationService) {
	var self = this;

	self.projectRequests = null;

	self.needsMyApprovalRowStyle = '';
	self.myProjectRequestsRowStyle = '';
	self.needsMyApprovalColumnStyle = '';

	var _myProjectRequestsDataTable = null;

	var _needsMyApprovalApprovalDataTable = null;

	var _onProjectRequestDataTableRowCreated = function(row, data, dataIndex){
		

		var rowData = _myProjectRequestsDataTable.fnGetData(row);
		var rowTds = $('>td', row);

		var statusHtml = _getMyRequestStatusHtml(rowData);
		var actionsHtml = _getMyRequestActionsHtml(rowData);

		rowTds[0].innerHTML = '<a href="/' + rowData[0] + '">' + rowData[1] + '</a>';
		rowTds[1].innerHTML = statusHtml;
		rowTds[2].innerHTML = actionsHtml;



		//_myProjectRequestsDataTable.fnUpdate('')
		//var alert = data[0];
		//if (alert=='1')
		//{
		//	$(rightopportunitiestable.cell(row,8).node()).addClass('expired');
		//}
	}

	var _onNeedsYourApprovalDataTableRowCreated = function(row, data, dataIndex){
		var rowData = _needsMyApprovalApprovalDataTable.fnGetData(row);
		var rowTds = $('>td', row);

		rowTds[0].innerHTML = '<a href="/' + rowData[0] + '">' + rowData[1] + '</a>';

		rowTds[1].innerHTML = '<div class="btn-group">' +
								'<button ng-click="rsvm.onApprove()" type="button" class="approve btn btn-default btn-sm shiny icon-only">' +
									'<i class="fa fa-thumbs-o-up success"></i></button>' +
								'<button ng-click="rsvm.onDeny()" type="button" class="deny btn btn-default btn-sm shiny icon-only">' +
									'<i class="fa fa-thumbs-o-down warning"></i></button>' +
								'<button ng-click="rsvm.onNeedMoreInformation()" type="button" class="request-more-information btn btn-default btn-sm shiny icon-only">' +
									'<i class="fa fa-reply danger"></i></button>' +
								'<button ng-click="rsvm.onCancel()" type="button" class="cancel btn btn-default btn-sm shiny icon-only">' +
									'<i class="fa fa-hand-stop-o danger"></i></button>' +
							'</div>';
	}

	var _getMyRequestStatusHtml = function (rowData) {
		var labelColorStyle = '';
		var statusDescription = rowData[2];
		var statusId = rowData[3];
		

		switch (statusId){
			case "1": //Draft
				labelColorStyle = 'label-palegreen';
				break;
			case "2": //NextLevelApproval
				labelColorStyle = 'label-orange';
				break;
			case "3": //SmtApproval
				labelColorStyle = 'label-orange';
				break;
			case "4": //SubmittedToEit
				labelColorStyle = 'label-success';
				break;
			case "5": //Cancelled
				labelColorStyle = 'label-danger';
				break;
			case "6": //Denied
				labelColorStyle = 'label-red';
				break;
			default:
				break;
		}

		return '<span class="label ' + labelColorStyle + '">' + statusDescription + '</span>'
	}

	var _getMyRequestActionsHtml = function (rowData) {
		var statusId = rowData[3];
		var isSubmitForApprovalEnabled = false;
		var isCancelRequestEnabled = false;

		switch (statusId){
			case "1": //Draft
				isSubmitForApprovalEnabled = false;
				isCancelRequestEnabled = true;
				break;
			case "2": //NextLevelApproval
				isSubmitForApprovalEnabled = true;
				isCancelRequestEnabled = true;
				break;
			case "3": //SmtApproval
				isSubmitForApprovalEnabled = true;
				isCancelRequestEnabled = true;
				break;
			case "4": //SubmittedToEit
				isSubmitForApprovalEnabled = false;
				isCancelRequestEnabled = false;
				break;
			case "5": //Cancelled
				isSubmitForApprovalEnabled = false;
				isCancelRequestEnabled = false;
				break;
			case "5": //Denied
				isSubmitForApprovalEnabled = false;
				isCancelRequestEnabled = false;
				break;
			default:
				break;
		}

		var submittedForApprovalStyle = 'disabled';
		var cancelReqeustStyle = 'disabled';

		if (isSubmitForApprovalEnabled)
			submittedForApprovalStyle = '';

		if (isCancelRequestEnabled)
			cancelReqeustStyle = '';

		return '<div class="btn-group">' +
					'<button type="button" class="btn btn-default btn-sm shiny success ' +  submittedForApprovalStyle +'">' +
						'<i class="fa fa-thumbs-o-up"></i>Submit for Approval</button>	' +
					'<button type="button" class="btn btn-default btn-sm shiny danger ' +  cancelReqeustStyle +'">' +
						'<i class="fa fa-times"></i>Cancel</button>' +
				'</div>';
	}

	var _initializeDataTables = function () {
		var initNeedsYourApprovalDataTable = function () {
			var queryString = getNeedsYourApprovalQueryString();

			_needsMyApprovalApprovalDataTable = $('#needs-my-approval-table').dataTable({
				"ajax": {
					url: projectRequestService.urls.base
						+ projectRequestService.urls.datatables.projectrequests + '/'
						+ authenticationService.user.domainLogin
						+ '?' + queryString,
					type: 'GET',
					headers: {
						'Authorization': 'Bearer ' + authenticationService.user['access_token'],
					}
				},
				"sDom": "Tflt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
				"aaSorting": [[1, 'asc']],
				"aLengthMenu": [
					[5, 15, 20, -1],
					[5, 15, 20, "All"]
				],
				"iDisplayLength": 20,
				"language": {
					"search": "",
					sEmptyTable: "There are no requests that need your approval",
					sLoadingRecords: "Loading Project Requests...",
					"sLengthMenu": "_MENU_",
					"oPaginate": {
						"sPrevious": "Prev",
						"sNext": "Next"
					}
				},
				"createdRow": _onNeedsYourApprovalDataTableRowCreated,
			});

			$("#needs-my-approval-table input").keyup(function () {
				/* Filter on the column (the index) of this element */
				_needsMyApprovalApprovalDataTable.fnFilter(this.value, $("#needs-my-approval-table input").index(this));
			});

			$('#needs-my-approval-table').on('click', 'button.approve', self.onApprove);
			$('#needs-my-approval-table').on('click', 'button.deny', self.onDeny);
			$('#needs-my-approval-table').on('click', 'button.request-more-information', self.onNeedMoreInformation);
			$('#needs-my-approval-table').on('click', 'button.cancel', self.onCancel);
		}

		var initMyProjectsDataTable = function () {
			var queryString = getMyProjectsQueryString();

			_myProjectRequestsDataTable = $('#my-project-table').dataTable({
				"ajax": {
					url: projectRequestService.urls.base
						+ projectRequestService.urls.datatables.projectrequests + '/'
						+ authenticationService.user.domainLogin
						+ '?' + queryString,
					type: 'GET',
					headers: {
						'Authorization': 'Bearer ' + authenticationService.user['access_token'],
					}
				},
				"sDom": "Tflt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
				"aaSorting": [[2, 'asc']],
				"aLengthMenu": [
					[5, 15, 20, -1],
					[5, 15, 20, "All"]
				],
				"iDisplayLength": 20,
				"language": {
					"search": "",
					sEmptyTable: "No requests have been created",
					sLoadingRecords: "Loading Requests...",
					"sLengthMenu": "_MENU_",
					"oPaginate": {
						"sPrevious": "Prev",
						"sNext": "Next"
					}
				},
				"createdRow": _onProjectRequestDataTableRowCreated,
			});

			$("#my-project-table tfoot input").keyup(function () {
				/* Filter on the column (the index) of this element */
				_myProjectRequestsDataTable.fnFilter(this.value, $("#my-project-table tfoot input").index(this));
			});
		}

		var getMyProjectsQueryString = function () {
			var queryString = '';

			var includeStatuses = [];

			switch (authenticationService.user.role) {
				case authenticationService.appRoles.smt:
					includeStatuses.push(projectRequestService.statuses.draft,
										projectRequestService.statuses.submittedToEit,
										projectRequestService.statuses.cancelled,
										projectRequestService.statuses.denied)
					break;
				case authenticationService.appRoles.nlm:
					includeStatuses.push(projectRequestService.statuses.draft,
																projectRequestService.statuses.smtApproval,
																projectRequestService.statuses.submittedToEit,
																projectRequestService.statuses.cancelled,
																projectRequestService.statuses.denied);
					break;
				case authenticationService.appRoles.user:
					includeStatuses.push(projectRequestService.statuses.draft,
										projectRequestService.statuses.smtApproval,
										projectRequestService.statuses.nextLevelApproval,
										projectRequestService.statuses.submittedToEit,
										projectRequestService.statuses.cancelled,
										projectRequestService.statuses.denied);
					break;
				default:
					break;
			}

			includeStatuses.forEach(function (status, index) {
				queryString += 'statusid=' + status + '&';
			});

			return queryString;
		}

		var getNeedsYourApprovalQueryString = function () {
			var queryString = '';

			var includeStatuses = [];

			switch (authenticationService.user.role) {
				case authenticationService.appRoles.smt:
					includeStatuses.push(projectRequestService.statuses.smtApproval)
					break;
				case authenticationService.appRoles.nlm:
					includeStatuses.push(projectRequestService.statuses.nextLevelApproval)
					break;
				case authenticationService.appRoles.user:
					includeStatuses.push(-1);
					break;
				default:
					break;
			}

			includeStatuses.forEach(function (status, index) {
				queryString += 'statusid=' + status + '&';
			});

			return queryString;
		}

		if (authenticationService.user.role !== authenticationService.appRoles.user)
			initNeedsYourApprovalDataTable(); 

		initMyProjectsDataTable();
	}

	var _init = function () {
		/* 
			http://stackoverflow.com/questions/27129829/angularjs-viewcontentloaded-fired-before-partial-view-appears
			http://stackoverflow.com/questions/27776174/type-error-cannot-read-property-childnodes-of-undefined
		*/
		$scope.$on('projectRequestService:authenticateSucceeded', function () {
			if (authenticationService.user.role === authenticationService.appRoles.user)
			{
				self.needsMyApprovalRowStyle = 'hide';
				self.needsMyApprovalColumnStyle = 'col-lg-12 col-sm-12 col-xs-12';
			}
			else
			{
				self.needsMyApprovalRowStyle = '';
				self.needsMyApprovalColumnStyle = 'col-lg-8 col-sm-12 col-xs-12';
			}
				
			$timeout(function () {
				_initializeDataTables();
			}, 0);
		});
	}

	self.title = 'RequestsViewModel';

	/*
		For some reason I needed to go up two parents
		http://stackoverflow.com/questions/21453697/angularjs-access-parent-scope-from-child-controller
	 */
	self.myProjectRequestStyle = $scope.$parent.$parent.mvm.header.myProjectRequestStyle;

	self.onViewSown = function (e) {
		$scope.$parent.$parent.mvm.header.myProjectRequestStyle = 'hide';

		authenticationService.authenticate();
	}

	self.onApprove = function (e) {
		projectRequestService.updateRequest({});
	}

	self.onDeny = function (e) {
		console.log('on onDeny');

		e.preventDefault();

		var nRow = $(this).parents('tr')[0];

		_needsMyApprovalApprovalDataTable.fnDeleteRow(nRow);
	}

	self.onNeedMoreInformation = function () {
		console.log('on onNeedMoreInformation');
	}

	self.onCancel = function (e) {
		console.log('on onCancel');
	}

	_init();
}

app.controller('RequestsViewModel', [
	'$timeout',
	'$scope',
	'$compile',
	'projectRequestService',
	'authenticationService',
	RequestsViewModel
]);