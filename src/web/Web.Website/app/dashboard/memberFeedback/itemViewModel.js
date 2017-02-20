
var MemberFeedbackItemViewModel = function ($scope, $interval, $routeParams, ConfigurationService, MemberFeedbackService) {
    var self = this;

    self.widgetName = 'Member Feedback Home';
    self.name = arguments.callee.name;
    self.feedback = {};

    self.refresh = function () {
        MemberFeedbackService.searchFeedbacks($routeParams.feedbackCode).then(_onGetFeedbackItem, _onGetFeedbackItemFailed);
    };

    var _cacheRefreshTimeout = $interval(self.refresh, ConfigurationService.apiRefreshIntervalInSeconds * 1000);

    var _onGetFeedbackItem = function (response) {
        if (self.feedback && self.feedback.modified_dt == response.data.modified_dt)
            return;

        self.feedback = response.data;

        self.feedback.htmlUrl = ConfigurationService.urls.website.baseUrl + '/' + self.feedback.htmlUrl;
    };

    var _onGetFeedbackItemFailed = function () {

    }

    self.onViewShown = function () {
        self.feedback = {};

        console.log({
            msg: 'controller.' + self.name + '.onviewshown',
            scope: $scope
        });

        MemberFeedbackService.searchFeedbacks($routeParams.feedbackCode).then(_onGetFeedbackItem, _onGetFeedbackItemFailed);
    };
}

app.controller('MemberFeedbackItemViewModel', ['$scope',
    '$interval',
    '$routeParams',
    'ConfigurationService',
    'MemberFeedbackService',
    MemberFeedbackItemViewModel]);