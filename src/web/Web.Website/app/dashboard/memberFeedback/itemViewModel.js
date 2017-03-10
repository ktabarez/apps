
var MemberFeedbackItemViewModel = function ($scope, $interval, $routeParams, $q, ConfigurationService, MemberFeedbackService) {
    var self = this;
    var _userDic = {};

    self.widgetName = 'Member Feedback Details';
    self.name = arguments.callee.name;
    $scope.$parent.$parent.$parent.mvm.pageTitle = 'Member Feedback Item# ' + $routeParams.feedbackCode;

    self.feedback = {};
    self.users = [];
    
    self.widgetBgColor = 'bg-default';

    //var _cacheRefreshTimeout = $interval(self.refresh, ConfigurationService.apiRefreshIntervalInSeconds * 1000);

    var _onGetUsers = function (response) {
        self.users = response.data;

        for (var i = 0; i < response.data.length; i++) {
            _userDic[response.data[i].systemUserId] = {
                user: response.data[i],
                idx: i
            };
        }
    };

    var _onGetFeedbackItem = function (response) {
        if (self.feedback && self.feedback.modified_dt == response.data.modified_dt)
            return;

        self.feedback = response.data;

        self.feedback.htmlUrl = ConfigurationService.urls.website.baseUrl + '/' + self.feedback.htmlUrl;

        if (self.feedback.assignedTo)
            self.selectedUser = self.users[_userDic[self.feedback.assignedTo.systemUserId].idx];

        switch (self.feedback.type.feedbackTypeDescr) {
            case 'Complaint':
                self.widgetBgColor = 'bg-danger';
                break;
            case 'Compliment':
                self.widgetBgColor = 'bg-success';
                break;
            case 'Suggestion':
                self.widgetBgColor = 'bg-warning';
                break;
            case 'Resolution':
                self.widgetBgColor = 'bg-success';
                break;
            case 'NCUA':
                self.widgetBgColor = 'bg-darkorange';
                break;
            case 'BBB':
                self.widgetBgColor = 'bg-darkorange';
                break;
            case 'Regulatory - Other':
                self.widgetBgColor = 'bg-danger';
                break;
            case 'Legal':
                self.widgetBgColor = 'bg-danger';
                break;
            case 'Compliance Issue':
                self.widgetBgColor = 'bg-danger';
                break;
            case 'Undefined':
                self.widgetBgColor = 'bg-sky';
                break;
            default:
                self.widgetBgColor = 'bg-Info';
                break;
        }
    };

    var _onGetFeedbackItemFailed = function () {

    };

    self.refresh = function () {
        //do a q all here to get the selected user after the feedback item is returns
        $q.all([MemberFeedbackService.searchFeedbacks($routeParams.feedbackCode),
               MemberFeedbackService.getUsers()]).then(function(responses){
                   _onGetUsers(responses[1]);
                   _onGetFeedbackItem(responses[0]);
               });
        //.then(_onGetFeedbackItem, _onGetFeedbackItemFailed);
        //.then(function (response) {
        //    for (var i = 0; i < response.data.length; i++) {
        //        _userDic[response.data[i].systemUserId] = {
        //            user: response.data[i],
        //            idx: i
        //        };
        //    }

        //    self.users = response.data;
        //});
    };

    self.save = function () {

        MemberFeedbackService.saveFeedbacks([{
            memberFeedbackID: self.feedback.memberFeedbackID,
            assignedToId: self.selectedUser ? self.selectedUser.systemUserId : -1,
            resolution: self.feedback.resolution
        }]);
    }

    self.onViewShown = function () {
        self.feedback = {};
        self.refresh();

        console.log({
            msg: 'controller.' + self.name + '.onviewshown',
            scope: $scope
        });
    };
}

app.controller('MemberFeedbackItemViewModel', ['$scope',
    '$interval',
    '$routeParams',
    '$q',
    'ConfigurationService',
    'MemberFeedbackService',
    MemberFeedbackItemViewModel]);