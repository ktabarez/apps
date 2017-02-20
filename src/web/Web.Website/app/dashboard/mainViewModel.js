
var DashboardMainViewModel = function ($scope) {
    var self = this;

    self.name = arguments.callee.name;

    $scope.$parent.mvm.pageTitle = 'Your items for the day!';
    //$scope.$parent.mvm.breadcrumbs.push({
    //    location: '/dashboard',
    //    name: 'Dashboard'
    //});

    self.onViewShown = function () {
        console.log({
            action: 'controller.' + self.name + '.onviewshown',
            scope: $scope
        });
    }
}

app.controller('DashboardMainViewModel', ['$scope', DashboardMainViewModel]);