$(document).ready(function () {
  $("#rotate90").rotate(90);
  $("#rotate180").rotate(180);
  $("#rotate270").rotate(270);
  
  
  $("#rotate0").click(function(e) {
    $('#photo_rotation').val(0);
  });
  $("#rotate90").click(function(e) {
    $('#photo_rotation').val(90);
  });
  $("#rotate180").click(function(e) {
    $('#photo_rotation').val(180);
  });
  $("#rotate270").click(function(e) {
    $('#photo_rotation').val(270);
  });
});