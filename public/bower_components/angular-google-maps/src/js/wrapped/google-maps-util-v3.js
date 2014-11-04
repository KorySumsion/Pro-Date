// wrap the utility libraries needed in ./lib
// http://google-maps-utility-library-v3.googlecode.com/svn/
angular.module('google-maps.wrapped'.ns()).service('GoogleMapsUtilV3'.ns(), function () {
  return {
    init: _.once(function () {
      //BEGIN REPLACE
      @@REPLACE_W_LIBS
      //END REPLACE
      window.InfoBox = InfoBox;
      window.Cluster = Cluster;
      window.ClusterIcon = ClusterIcon;
      window.MarkerClusterer = MarkerClusterer;
      window.MarkerLabel_ = MarkerLabel_;
      window.MarkerWithLabel = MarkerWithLabel;
    })
  };
});