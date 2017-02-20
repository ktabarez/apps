app.run(['$templateCache', '$http', '$rootScope', 'MemberFeedbackService', 'AuthenticationService', function ($templateCache, $http, $rootScope, MemberFeedbackService, AuthenticationService) {
    MemberFeedbackService.init();
    AuthenticationService.init();

    $rootScope.$on("$includeContentLoaded", function (event) {
        console.log({
            msg: '$includeContentLoaded',
            data: {
                event: event,
                templateName: templateName,
            }
        });
    });
}]);