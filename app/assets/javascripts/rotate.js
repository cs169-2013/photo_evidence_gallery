$(document).ready(function () {
	var angle=0;
  
  $("#right").click(function(e) {
  	angle += 90;
  	$('#picture').rotate(angle % 360);
    $('#photo_rotation').val(angle % 360);
  });
  $("#left").click(function(e) {
  	angle -= 90;
  	$('#picture').rotate(angle % 360);
    $('#photo_rotation').val(angle % 360);
  });
});
