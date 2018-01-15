$(function () {
  var attribution = `
    <a href="https://mapzen.com/tangram" target="_blank">Tangram</a> |
    &copy; OSM contributors |
    <a href="https://mapzen.com/" target="_blank">Mapzen</a>
  `;

  function bindPopup(feature, layer) {
    if (feature.properties && feature.properties.popupContent) {
      layer.bindPopup(feature.properties.popupContent);
    }
  }

  function mapPostsToBounds(posts) {
    var coord_pairs = posts
      .map(feature => feature.geometry.coordinates.reverse())
      .filter(coords => coords[0] && coords[1]);

    var bounds = coord_pairs 
      .reduce((bounds, coords) => {
        return [
          [Math.min(bounds[0][0], coords[0]), Math.min(bounds[0][1], coords[1])],
          [Math.max(bounds[1][0], coords[0]), Math.max(bounds[1][1], coords[1])]
        ];
      }, [coord_pairs[0],coord_pairs[0]]);

    return bounds;
  }

  function initializeMap(data) {
    var posts = $.parseJSON(data);
    var map = L.map('map');
    var tangram = Tangram.leafletLayer({
      scene: '/scene.yaml',
      attribution: attribution
    });
    var geoJSON = L.geoJSON(posts, {onEachFeature: bindPopup})
    var bounds = mapPostsToBounds(posts);

    tangram.addTo(map);
    geoJSON.addTo(map);
    map.fitBounds(bounds, {padding: [30, 30]});
  }

  $.ajax({
    dataType: 'text',
    url: '/posts.json',
    success: initializeMap 
  });
});
