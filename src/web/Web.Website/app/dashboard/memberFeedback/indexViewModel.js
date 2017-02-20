
var MemberFeedbackHomeViewModel = function ($scope, $interval, jQuery, DTOptionsBuilder, DTColumnDefBuilder, ConfigurationService, MemberFeedbackService) {
    var self = this;

    self.widgetName = 'Member Feedback Home';
    self.name = arguments.callee.name;
    self.feedbacks = {};

    self.refresh = function () {
        MemberFeedbackService.getFeedbacks().then(_onGetFeedbacks, _onGetFeedbacksFailed);
    };

    var _cacheRefreshTimeout = $interval(self.refresh, ConfigurationService.apiRefreshIntervalInSeconds * 1000);

    var _onGetFeedbacks = function (response) {
        jQuery.each(response.data, function (idx, feedback) {
            if (!self.feedbacks[feedback.memberFeedbackCode]) {
                self.feedbacks[feedback.memberFeedbackCode] = feedback;
                return;
            }

            if (self.feedbacks[feedback.memberFeedbackCode].modified_dt == feedback.modified_dt)
                return;

            feedback.url = ConfigurationService.urls.website.baseUrl + '/' + feedback.memberFeedbackCode;
            self.feedbacks[feedback.memberFeedbackCode] = feedback;
        });
    };

    var _onGetFeedbacksFailed = function () {

    }

    self.onViewShown = function () {
        console.log({
            msg: 'controller.' + self.name + '.onviewshown',
            scope: $scope
        });

        MemberFeedbackService.getFeedbacks().then(_onGetFeedbacks, _onGetFeedbacksFailed);
    };
}

app.controller('MemberFeedbackHomeViewModel', ['$scope',
    '$interval',
    'jQuery',
    'ConfigurationService',
    'MemberFeedbackService',
    MemberFeedbackHomeViewModel]);