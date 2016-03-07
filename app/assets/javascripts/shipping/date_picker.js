// $(".date-picker").click(function () {
//     var date = new Date();
//     var currentMonth = date.getMonth();
//     var currentDate = date.getDate();
//     var currentYear = date.getFullYear();
//     $('.date-picker').datetimepicker({
//         minDate: new Date(currentYear, currentMonth, currentDate),
//         daysOfWeekDisabled: [0, 6],
//         format: 'MM/DD/YYYY'
//     });
// });

$(function () {
    // var date = new Date();
    // var currentMonth = date.getMonth();
    // var currentDate = date.getDate();
    // var currentYear = date.getFullYear();
    // $('.date-picker').datetimepicker({
    //     minDate: new Date(currentYear, currentMonth, currentDate),
    //     daysOfWeekDisabled: [0, 6],
    //     format: 'MM/DD/YYYY'
    // });

  //Calculate Date Off from Backend

    var day = 1000 * 60 * 60 * 24;
    var dateOffs = [];
    $('.when-swing.clearfix').find("input[type='hidden'][name='h_dateoff']").each(function() {
        var start_at = new Date($(this).attr("start_at"));
        var end_at = new Date($(this).attr("end_at"));
        var diff = (end_at.getTime() - start_at.getTime()) / day;
        for (var i = 0; i <= diff; i ++) {
            var xx = start_at.getTime() + day * i;
            var yy = new Date(xx);
            dateOffs.push(yy.getFullYear() + "-" + (yy.getMonth() + 1) + "-" + yy.getDate());
        }
    });

    //Check if min date is included in the scope of min and max dates
    var minDay = (moment().add(1, 'days').startOf('isoDay'));
    var maxDay = (moment().add(20, 'days').startOf('isoDay'));
    var bChecked = false;

    for (var i = 0; i < 30; i ++) {
        bChecked = false;
        minDay = (moment().add(i + 1, 'days').startOf('isoDay'));
        var minDayTime = new Date(minDay).getTime();
        for (var j = 0; j < dateOffs.length; j ++) {
            var dateOff = new Date(dateOffs[j]).getTime(); //xxxx-xx-xx 00:00:00
            var dateOffMax = dateOff + day; //xxxx-xx-xx 23:59:59
            if (minDayTime >= dateOff && minDayTime < dateOffMax) {
                bChecked = true;
                break;
            }
        }
        if (bChecked)
            continue;
        else
            break;
    }

    //Create a DateTimePicker
    $('.date-picker').datetimepicker({
        //format: 'MM/DD/YYYY',
        format: 'DD.MM.YYYY',
        minDate: minDay,
        maxDate: maxDay,
        disabledDates: dateOffs
    });

    //Date change event on
    $('.date-picker').on('dp.change', function(e) {
        //alert($('#order_shipping_date').val());
        resetTimeSchedule($('.order_shipping_date').val());
    });

    //Reset Time option click event
    var resetEvent = function() {
        $('.time-picker li').each(function() {
            $(this).on("click", function(){
                $('.time-picker li').removeClass("cs-selected");
                $(this).addClass('cs-selected');
                var datavalue = $(this).children("span").text();
                $('#time_picker_value').attr('value',datavalue);
                $(".cs-options").toggle();
                $('#time_picker_value').change();
            });
        });
    }

    //Reset Time schedule
    var resetTimeSchedule = function(selDate) {
        $('.time-picker').find('.cs-options').remove();

        var dates = selDate.split('.');
        var dateObj = new Date(parseInt(dates[2]), parseInt(dates[1]) - 1, parseInt(dates[0]))
        var dayOfWeek = dateObj.getDay();

        if (dayOfWeek == 1) {
            $('#time_picker_value').attr('value', "NO DELIVERIES");
        }
        else if (dayOfWeek == 2) {
            $('.time-picker').append("<div class='cs-options'><ul></ul></div>");

            var ul =  $('.cs-options').find('ul');
            ul.append("<li><span>18.00 - 20.00</span></li>");
            ul.append("<li><span>20.00 - 22.00</span></li>");
            $('#time_picker_value').attr('value', "18.00 - 20.00");
        }
        else if (dayOfWeek == 3) {
            $('.time-picker').append("<div class='cs-options'><ul></ul></div>");

            var ul =  $(".cs-options").find('ul');
            ul.append("<li><span>18.00 - 20.00</span></li>");
            ul.append("<li><span>20.00 - 22.00</span></li>");
            $('#time_picker_value').attr('value', "18.00 - 20.00");
        }
        else if (dayOfWeek == 4) {
            $('.time-picker').append("<div class='cs-options'><ul></ul></div>");

            var ul =  $(".cs-options").find('ul');
            ul.append("<li><span>18.00 - 20.00</span></li>");
            ul.append("<li><span>20.00 - 22.00</span></li>");
            $('#time_picker_value').attr('value', "18.00 - 20.00");
        }
        else if (dayOfWeek == 5) {
            $('.time-picker').append("<div class='cs-options'><ul></ul></div>");

            var ul =  $(".cs-options").find('ul');
            ul.append("<li><span>18.00 - 20.00</span></li>");
            ul.append("<li><span>20.00 - 22.00</span></li>");
            $('#time_picker_value').attr('value', "18.00 - 20.00");
        }
        else if (dayOfWeek == 6) {
            $('.time-picker').append("<div class='cs-options'><ul></ul></div>");

            var ul =  $(".cs-options").find('ul');
            ul.append("<li><span>09.00 - 11.00</span></li>");
            ul.append("<li><span>11.00 - 13.00</span></li>");
            ul.append("<li><span>13.00 - 15.00</span></li>");
            ul.append("<li><span>16.00 - 18.00</span></li>");
            $('#time_picker_value').attr('value', "09.00 - 11.00");
        }
        else if (dayOfWeek == 0) {
            $('.time-picker').append("<div class='cs-options'><ul></ul></div>");

            var ul =  $(".cs-options").find('ul');
            ul.append("<li><span>09.00 - 11.00</span></li>");
            ul.append("<li><span>11.00 - 13.00</span></li>");
            ul.append("<li><span>13.00 - 15.00</span></li>");
            ul.append("<li><span>16.00 - 18.00</span></li>");
            $('#time_picker_value').attr('value', "09.00 - 11.00");
        }

        $('#time_picker_value').change();
        resetEvent();
    }

    if (date == null || date == undefined || date == '')
        resetTimeSchedule(minDay);
    else {
        $('.order_shipping_date').attr('value', date)
        resetTimeSchedule(date);
    }
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
$('.time-picker').find('.item-input').click(function() {
    $(".cs-options").toggle();
});


