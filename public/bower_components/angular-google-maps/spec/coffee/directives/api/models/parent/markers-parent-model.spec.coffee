# TODO: These tests are failing because something is not mocked correctly
# in the clusterermanager. Likely google.maps.overlayview.
describe "MarkersParentModel - Clusterer Event Extensions", ->
  afterEach ->
    self.markerModelsCluster = undefined
  beforeEach ->
    @clusterTest =
      getMarkers: ->
        values: () -> [
          {key: 1}
          {key: 2}
        ]
    @index = 0
    @clicked = false
    self = @
    @scope =
      icon: 'icon.png'
      coords:
        latitude: 90
        longitude: 90
      events:
        click: (marker, eventName, args) ->
          self.clicked = true
          self.gMarkerSetEvent = marker
      clusterOptions: {}
      clusterEvents:
        click: (cluster, markerModelsCluster) ->
          self.markerModelsCluster = markerModelsCluster
        mouseout: (cluster, markerModelsCluster) ->
          self.markerModelsCluster = markerModelsCluster
        mouseover: (cluster, markerModelsCluster) ->
          self.markerModelsCluster = markerModelsCluster
        crap: ->
          self.markerModelsCluster = "crap"
      doCluster: "true"
      models: []

    #define / inject values into the item we are testing... not a controller but it allows us to inject
    angular.module('mockModule', ["google-maps".ns(),"google-maps.mocks"])
    .value('map', document.gMap)
    .value('element', {})
    .value('attrs', click: true)
    .value('model', {})
    .value('scope', @scope)

    module "mockModule"
    window["Initiator".ns()].initMock()

    inject ['$rootScope', 'element', 'attrs', 'map',
      'MarkersParentModel'.ns(), 'GoogleMapsUtilV3'.ns(),'ExtendMarkerClusterer'.ns(),
      ($rootScope, element, attrs, map, MarkersParentModel, GoogleMapsUtilV3,ExtendMarkerClusterer) =>
        GoogleMapsUtilV3.init()
        ExtendMarkerClusterer.init()
        scope = $rootScope.$new()

        @scope = _.extend @scope, scope
        @scope.options =
          animation: google.maps.Animation.BOUNCE
        @testCtor = MarkersParentModel

        @subject = new @testCtor(@scope, element, attrs, map)
        @subject
    ]

  it 'constructor exist', ->
    expect(@testCtor).toBeDefined()

  it 'can be created', ->
    expect(@subject?).toBeDefined()

  describe "clusterEvents", ->
    describe "basic event handling", ->
      describe "is fired", ->
        describe "mapped extension", ->
          it 'click - ', ->
            @subject.scope.markerModels.put 1, model: "test1"
            @subject.scope.markerModels.put 2, model: "test2"
            @subject.clusterInternalOptions.click @clusterTest
            expect(_.all(@markerModelsCluster, (entity, i)=>
              entity == @subject.scope.markerModels[i+1].model
            )).toBeTruthy()
          it 'mouseout - ', ->
            @subject.scope.markerModels.put 1, model: "test1"
            @subject.scope.markerModels.put 2, model: "test2"
            @subject.clusterInternalOptions.mouseout @clusterTest
            expect(_.all(@markerModelsCluster, (entity, i)=>
              entity == @subject.scope.markerModels[i+1].model
            )).toBeTruthy()
          it 'mouseover - ', ->
            @subject.scope.markerModels.put 1, model: "test1"
            @subject.scope.markerModels.put 2, model: "test2"
            @subject.clusterInternalOptions.mouseover @clusterTest
            expect(_.all(@markerModelsCluster, (entity, i)=>
              entity == @subject.scope.markerModels[i+1].model
            )).toBeTruthy()
        describe "some legacy event", =>
          it 'crap - ', -> #not a real event but shows that any existing function can be fired
            @subject.gMarkerManager.opt_events.crap()
            expect(@markerModelsCluster).toBe("crap")
      describe "not fired", ->
        it 'click - ', ->
