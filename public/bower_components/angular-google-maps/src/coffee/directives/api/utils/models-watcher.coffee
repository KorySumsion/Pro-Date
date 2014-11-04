angular.module("google-maps.directives.api.utils".ns())
.factory "ModelsWatcher".ns(), [
  "Logger".ns(), "_async".ns(),
  (Logger,_async) ->
    #putting a payload together in order to not have to flatten twice, and to not
    #have to flatten again later
    figureOutState: (idKey, scope, childObjects, comparison, callBack)->
      adds = [] #models to add or update
      mappedScopeModelIds = {}
      removals = [] #childModels to remove
      updates = []
      _async.each scope.models, (m) ->
        if m[idKey]?
          mappedScopeModelIds[m[idKey]] = {}
          unless childObjects[m[idKey]]?
            adds.push m
          else
            child = childObjects[m[idKey]]
            #we're UPDATE in this case
            unless comparison m, child.model
              updates.push
                model: m
                child: child
        else
          Logger.error """ id missing for model #{m.toString()},
            can not use do comparison/insertion"""
      .then =>
        _async.each childObjects.values(), (c) ->
          unless c?
            Logger.error("child undefined in ModelsWatcher.")
            return
          unless c.model?
            Logger.error("child.model undefined in ModelsWatcher.")
            return
          id = c.model[idKey]
          #if we do not have the object we can remove it,
          #this case is when it no longer exists and should be removed
          removals.push c unless mappedScopeModelIds[id]?
      .then  =>
        callBack
          adds: adds
          removals: removals
          updates: updates
]
