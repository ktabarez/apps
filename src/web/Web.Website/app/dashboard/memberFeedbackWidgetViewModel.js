


var MemberFeedbackWidgetViewModel = function ($scope, $interval, $timeout, $compile, jQuery, DTOptionsBuilder, DTColumnDefBuilder, DTColumnBuilder, DTDefaultOptions, ConfigurationService, MemberFeedbackService) {
    var self = this;

    self.widgetName = 'Member Feedback';
    self.name = arguments.callee.name;
    self.feedbacks = {};

    var _init = function () {
        self.refresh();
    }

    var _onGetFeedbacksFailed = function () {

    }

    var _onGetFeedbacks = function (response) {
        jQuery.each(response.data, function (idx, feedback) {
            if (!self.feedbacks[feedback.memberFeedbackCode]) {
                feedback.htmlUrl = ConfigurationService.urls.website.baseUrl + '/' + feedback.htmlUrl;
                self.feedbacks[feedback.memberFeedbackCode] = feedback;
                return;
            }

            if (self.feedbacks[feedback.memberFeedbackCode].modified_dt == feedback.modified_dt)
                return;

            feedback.htmlUrl = ConfigurationService.urls.website.baseUrl + '/' + feedback.htmlUrl;
            self.feedbacks[feedback.memberFeedbackCode] = feedback;
        });
    };

    /*-----data table -----*/

    var _renderFeedbackCodeCell = function (data, type, row) {
        return '<a ng-href="{{\'' + ConfigurationService.urls.website.baseUrl + row.htmlUrl + '\'}}">' + row.memberFeedbackCode + '</a>';
    };

    var _renderFeedbackTypeCell = function (data, type, row) {
        return row.type.feedbackTypeDescr;
    };

    var _renderAccountNumberCell = function (data, type, row) {
        return row.accountNumber;
    };

    var _renderStatusDescrCell = function (data, type, row) {
        if (!row.status)
            return 'UNDEFINED';

        switch (row.status.statusDescr) {
            case 'Resolved':
                return '<span class="label label-success">' + row.status.statusDescr + '</span>';
            case 'No Action Required':
                return '<span class="label label-default">' + row.status.statusDescr + '</span>';
            case 'Not Reviewed':
                return '<span class="label label-warning">' + row.status.statusDescr + '</span>';
            case 'Action Required':
                return '<span class="label label-danger">' + row.status.statusDescr + '</span>';
            case 'Information Only':
                return '<span class="label label-primary">' + row.status.statusDescr + '</span>';
            default:
                return row.status.statusDescr
        }
    };

    var _renderActionCell = function (data, type, row) {
        if(row.assignedTo)
            return row.assignedTo.userName;

        return '';
    };

    var _renderCommentCell = function (data, type, row) {
        return row.comment;
    };

    self.disabled = false;
    self.searchEnabled = true;

    DTDefaultOptions.setLoadingTemplate('<h1>Loading feedbacks</h1> ...')

    self.dtOptions = DTOptionsBuilder.newOptions().withOption('ajax', {
        dataSrc: 'data',
        url: ConfigurationService.urls.api.baseUrl + '/api/someorgname/apps/memberfeedback/search/feedbacks',
        data: {
            username: ConfigurationService.username
        },
        xhrFields: {
            withCredentials: true
        },
        dataType: 'json',
        //contentType: 'application/json',
        type: 'POST'
    }).withOption('processing', true) //for show progress bar
      .withOption('serverSide', true) //for server side processing
      .withOption('aaSorting', [0, 'asc']) //default sorting on first column
      .withOption('fnRowCallback',
        function (nRow, aData, iDisplayIndex, iDisplayIndexFull) {
            $compile(nRow)($scope);
        })
      .withPaginationType('full_numbers')
      .withDisplayLength(10);
   
    self.dtColumns = [
        DTColumnBuilder.newColumn('memberFeedbackCode', 'Code').renderWith(_renderFeedbackCodeCell).withOption('name', 'memberFeedbackCode'),
        DTColumnBuilder.newColumn('accountNumber', 'Account #').renderWith(_renderAccountNumberCell).withOption('name', 'accountNumber'),

        DTColumnBuilder.newColumn('feedbackTypeDescr', 'Type').renderWith(_renderFeedbackTypeCell).withOption('name', 'feedbackTypeDescr'),
        DTColumnBuilder.newColumn('statusDescr', 'Status').renderWith(_renderStatusDescrCell).withOption('name', 'statusDescr'),
        DTColumnBuilder.newColumn('comment', 'Comment').renderWith(_renderCommentCell),
        DTColumnBuilder.newColumn('assignedTo', 'Assigned To').renderWith(_renderActionCell).withOption('responsivePriority', 6)
    ];

    self.refresh = function () {

    };

    /*-----view shown-----*/

    self.onViewShown = function () {
        console.log({
            msg: 'controller.' + self.name + '.onviewshown',
            scope: $scope
        });
    };

    /*-----init-----*/

    _init();
}

app.controller('MemberFeedbackWidgetViewModel', ['$scope',
    '$interval',
    '$timeout',
    '$compile',
    'jQuery',
     'DTOptionsBuilder',
     'DTColumnDefBuilder',
     'DTColumnBuilder',
     'DTDefaultOptions',
    'ConfigurationService',
    'MemberFeedbackService',
    MemberFeedbackWidgetViewModel]);