$(".date-picker").click(function () {
    var date = new Date();
    var currentMonth = date.getMonth();
    var currentDate = date.getDate();
    var currentYear = date.getFullYear();
    $('.date-picker').datetimepicker({
        minDate: new Date(currentYear, currentMonth, currentDate),
        daysOfWeekDisabled: [0, 6],
        format: 'MM/DD/YYYY'
    });
});
$('html').click(function() {
    $(".cs-options").hide();
});
$('.time-picker').click(function(e){
     e.stopPropagation();
});
$(".time-picker figure img").click(function(){
  $(".cs-options").toggle();
});
$('.time-picker li').each(function() {
  $(this).on("click", function(){
    $('.time-picker li').removeClass("cs-selected");
    $(this).addClass('cs-selected');
    var datavalue = $(this).children("span").text();
    $('#time_picker_value').attr('value',datavalue);
    $(".cs-options").toggle();
  });
})
