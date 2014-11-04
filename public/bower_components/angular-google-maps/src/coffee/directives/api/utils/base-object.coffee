angular.module("google-maps.directives.api.utils".ns())
.factory "BaseObject".ns(), ->
  baseObjectKeywords = ['extended', 'included']
  class BaseObject
    @extend: (obj) ->
      for key, value of obj when key not in baseObjectKeywords
        @[key] = value
      obj.extended?.apply(@)
      this
    @include: (obj) ->
      for key, value of obj when key not in baseObjectKeywords
        #Assign properties to the prototype
        @::[key] = value
      obj.included?.apply(@)
      this

  BaseObject
