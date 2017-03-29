Gapnix.views.tasksIndex = (function () {

  function changeTimeType() {
    var link_to = $(".js-link-hours");

    link_to.on("click", function () {
      var hidden = $(".js-hours-field");
      hidden.toggleClass("hidden");

      var autoTimeStr = link_to.data("link-auto");
      var manualTimeStr = link_to.data("link-manual");
      var submitInput = $("#submit-task");

      if (link_to.text() == manualTimeStr) {
        link_to.text(autoTimeStr);
        submitInput.html(link_to.data("submit-manual"));
        submitInput.val('manual');
      }
      else {
        link_to.text(manualTimeStr);
        submitInput.html(link_to.data("submit-auto"));
        submitInput.val('auto');
      }
    });
  }

  function onChangedTime() {
    var time_field = $(".js-hours-field");
    var hidden_time_field = $(".js-hours-hidden-field");

    time_field.on("change", function () {
      hidden_time_field.val(filterTimeFormat(time_field.val()));
      time_field.val(Gapnix.helpers.changeHourFormat(hidden_time_field.val()));
    });
  }

  function setTaskResumeDates() {
    var dateInputs = $(".js-start-date");
    $.each(dateInputs, function(index, element){
      element.value = Date.now()
    });
  }

  function setStopEvents() {
    $(".stop").on('click', function(){
      $(".js-end-date").val(Date.now())
    })
  }

  function setTaskFormEvents(){
    $('#submit-task').on('click', function(){
      $(".js-start-date").val(Date.now());
    });
  }

  function init() {
    changeTimeType();
    onChangedTime();
    setTaskResumeDates();
    setStopEvents();
    setTaskFormEvents();
  }

  return {
    init: init
  }

})();

Gapnix.views.tasksIndex.init();
