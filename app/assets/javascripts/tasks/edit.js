Gapnix.views.tasksIndex = (function () {

  function show_time() {
    var time_field = $(".js-hours-field");
    var hidden_time_field = $(".js-hours-hidden-field");

    time_field.val(Gapnix.helpers.changeHourFormat(hidden_time_field.val()));
  }

  function on_changed_time() {
    var time_field = $(".js-hours-field");
    var hidden_time_field = $(".js-hours-hidden-field");

    time_field.on("change", function () {
      hidden_time_field.val(filterTimeFormat(time_field.val()));
      time_field.val(Gapnix.helpers.changeHourFormat(hidden_time_field.val()));
    });
  }

  function init() {
    show_time();
    on_changed_time();
  }

  return {
    init: init
  }

})();

(function () {
  Gapnix.views.tasksIndex.init();
})();