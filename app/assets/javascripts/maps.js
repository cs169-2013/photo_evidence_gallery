var map;
var geocoder;

function make_map(pins) //pins is a list of pins, a pin is the list [lat, lng, name]
{
	geocoder = new google.maps.Geocoder();
	var mapOptions = {
		center: new google.maps.LatLng(pins[0][0], pins[0][1]),
		zoom: 8,
		disableDefaultUI: false,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	};
	map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
	var infowindow = new google.maps.InfoWindow();
	if (pins != null)
		for (var i = 0; i < pins.length; i++){
		  marker = new google.maps.Marker({
			  position: new google.maps.LatLng(pins[i][0], pins[i][1]),
			  map: map
			});

			google.maps.event.addListener(marker, 'click', (function(marker, i) {
			  return function() {
			    infowindow.setContent(pins[i][2]);
			    infowindow.open(map, marker);
			  }
			})(marker, i));
		}
}
