$(function() {
  if ($.support.localStorage) {
    $(window.applicationCache).bind("error", function() {
      console.log("There was an error when loading the cache manifest.");
    });
    if (!localStorage["pendingItems"]) {
      localStorage["pendingItems"] = [];
    }
    $("#submit_btn").submit(function(e) {
      if (params["photo"]["image"]) {
        localStorage["pendingItems"].push(params["photo"]);
        sendPending();
        e.preventDefault();
      }
    });
    function sendPending() {
      if (window.navigator.onLine) {
        var pendingItems = localStorage["pendingItems"];
        if (pendingItems.length > 0) {
          var item = pendingItems[0];
          $.post("/photos", item, function (data) {
            localStorage["pendingItems"].shift();
            setTimeout(sendPending, 100);
          });
        }
      }
    }
    sendPending();
    $(window).bind("online", sendPending);
  } else {
    alert("For offline uploads, try a different browser.");
  }
});
