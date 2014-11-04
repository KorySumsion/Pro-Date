angular.module("google-maps.directives.api.models.parent".ns())
.factory "CircleParentModel".ns(),
['Logger'.ns(), '$timeout',"GmapUtil".ns(),
"EventsHelper".ns(), "CircleOptionsBuilder".ns(),
($log, $timeout, GmapUtil, EventsHelper, Builder) ->
  class CircleParentModel extends Builder
    @include GmapUtil
    @include EventsHelper
    constructor: (@scope, element, @attrs, @map, @DEFAULTS) ->
      circle =
        new google.maps.Circle(@buildOpts(GmapUtil.getCoords(scope.center), scope.radius))

      @setMyOptions = (newVals, oldVals) =>
        unless _.isEqual newVals,oldVals
          circle.setOptions @buildOpts(GmapUtil.getCoords(scope.center), scope.radius)

      @props = @props.concat [
        {prop: 'center',isColl: true}
        {prop: 'fill',isColl: true}
        'radius'
      ]
      @watchProps()

      listeners = @setEvents circle, scope, scope

      google.maps.event.addListener circle, 'radius_changed', ->
        scope.radius = circle.getRadius()
        $timeout ->
          scope.$apply()

      google.maps.event.addListener circle, 'center_changed', ->
        if angular.isDefined(scope.center.type)
          scope.center.coordinates[1] = circle.getCenter().lat()
          scope.center.coordinates[0] = circle.getCenter().lng()
        else
          scope.center.latitude = circle.getCenter().lat()
          scope.center.longitude = circle.getCenter().lng()

        $timeout ->
          scope.$apply()

      # Remove circle on scope $destroy
      scope.$on "$destroy", =>
        @removeEvents listeners
        circle.setMap null

      $log.info @
]
