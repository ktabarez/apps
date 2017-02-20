
var MemberFeedbackWidgetViewModel = function ($scope, $interval, jQuery, DTOptionsBuilder, DTColumnDefBuilder, ConfigurationService, MemberFeedbackService) {
    var self = this;

    self.widgetName = 'Member Feedback';
    self.name = arguments.callee.name;
    self.feedbacks = {};
    self.dtOptions = DTOptionsBuilder.newOptions().withPaginationType('full_numbers');
    self.dtColumnDefs = [
        //DTColumnDefBuilder.newColumnDef(0),
        //DTColumnDefBuilder.newColumnDef(1),
        //DTColumnDefBuilder.newColumnDef(2),
        //DTColumnDefBuilder.newColumnDef(3),
        //DTColumnDefBuilder.newColumnDef(4),
        //DTColumnDefBuilder.newColumnDef(5),
        //DTColumnDefBuilder.newColumnDef(6),
        //DTColumnDefBuilder.newColumnDef(7),
        //DTColumnDefBuilder.newColumnDef(8),
        //DTColumnDefBuilder.newColumnDef(9),
        //DTColumnDefBuilder.newColumnDef(10),
        //DTColumnDefBuilder.newColumnDef(11),
        //DTColumnDefBuilder.newColumnDef(12),
        //DTColumnDefBuilder.newColumnDef(13),
        //DTColumnDefBuilder.newColumnDef(14),
    ];

    self.refresh = function () {
        MemberFeedbackService.getFeedbacks().then(_onGetFeedbacks, _onGetFeedbacksFailed);
    };

    var _cacheRefreshTimeout = $interval(self.refresh, ConfigurationService.apiRefreshIntervalInSeconds * 1000);

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

    var _onGetFeedbacksFailed = function () {

    }

    self.onViewShown = function () {
        console.log({
            msg: 'controller.' + self.name + '.onviewshown',
            scope: $scope
        });

        MemberFeedbackService.getFeedbacks().then(_onGetFeedbacks, _onGetFeedbacksFailed);
    };

    self.buildPerson2Add = function (id) {
        return {
            id: id,
            firstName: 'Foo' + id,
            lastName: 'Bar' + id
        };
    };

    self.addPerson = function () {
        self.persons.push(angular.copy(self.person2Add));
        self.person2Add = _buildPerson2Add(self.person2Add.id + 1);
    };

    self.modifyPerson = function(index) {
        self.persons.splice(index, 1, angular.copy(self.person2Add));
        self.person2Add = _buildPerson2Add(self.person2Add.id + 1);
    }

    self.removePerson = function (index) {
        self.persons.splice(index, 1);
    }
}

app.controller('MemberFeedbackWidgetViewModel', ['$scope',
    '$interval',
    'jQuery',
     'DTOptionsBuilder',
     'DTColumnDefBuilder',
    'ConfigurationService',
    'MemberFeedbackService',
    MemberFeedbackWidgetViewModel]);