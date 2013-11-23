$(document).ready(function () {
  $("#coorbutton").click(function(e) {
    var x=document.getElementById("Locator");
    function getLocation()
      {
      x.innerHTML="Locating....";
      if (navigator.geolocation)
        {
        navigator.geolocation.getCurrentPosition(showPosition);
        }
      else{x.innerHTML="Geolocation is not supported by this browser.";}
      }
    function showPosition(position)
    {
      x.innerHTML="Success";
      $("#photo_lat").val(position.coords.latitude);
      $("#photo_lng").val(position.coords.longitude);
      $("#photos_lat").val(position.coords.latitude);
      $("#photos_lng").val(position.coords.longitude);
    }
    getLocation();
      
      
  });
});



