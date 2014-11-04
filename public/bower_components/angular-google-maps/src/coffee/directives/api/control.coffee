angular.module("google-maps.directives.api".ns())
.factory "Control".ns(), ["IControl".ns(), "$http", "$templateCache", "$compile", "$controller",'GoogleMapApi'.ns(),
  (IControl, $http, $templateCache, $compile, $controller, GoogleMapApi) ->
    class Control extends IControl
      constructor: ->
        super()

      link: (scope, element, attrs, ctrl) =>
        GoogleMapApi.then (maps) =>
          # Validate attributes
          if angular.isUndefined scope.template
            @$log.error 'mapControl: could not find a valid template property'
            return

          index = if angular.isDefined scope.index and not isNaN(parseInt scope.index) then parseInt scope.index else undefined

          position = if angular.isDefined scope.position then scope.position.toUpperCase().replace /-/g, '_' else 'TOP_CENTER'
          if not maps.ControlPosition[position]
            @$log.error 'mapControl: invalid position property'
            return

          # Wrap control initialization inside a $timeout() call to make sure the map is created already
          IControl.mapPromise(scope, ctrl).then (map) =>
            control = undefined
            controlDiv = angular.element '<div></div>'
            $http.get(scope.template, { cache: $templateCache })
            .success (template) =>
              templateScope = scope.$new()
              controlDiv.append template

              # add index if defined
              if index then controlDiv[0].index = index

              # if a controller is defined on the directive then add it to the template
              if angular.isDefined scope.controller
                templateCtrl = $controller scope.controller, {$scope: templateScope}
                controlDiv.children().data '$ngControllerController', templateCtrl

              control = $compile(controlDiv.contents())(templateScope)
            .error (error) =>
              @$log.error 'mapControl: template could not be found'
            .then =>
              map.controls[google.maps.ControlPosition[position]].push control[0]
]
