// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

/* BEGIN CORE PLUGINS */
//= require js/1.11.2jquery.min
//= require js/bootstrap.min
//= require js/owl.carousel.min
//= require js/slidebars.min
//= require js/custom
//= require js/jquery.placeholder.min
//= require underscore-min
//= require js/moment
//= require js/collapse
//= require js/transition
//= require js/bootstrap-datetimepicker.min
/* OTHER  */
//= require jquery_ujs


(function($) {
  $(document).ready(function() {
    $.slidebars();
  });
}) (jQuery);


(function (jQuery) {
    jQuery.support.placeholder = ('placeholder' in document.createElement('input'));
})(jQuery);

//fix for IE7 and IE8
$(function () {
    if (!jQuery.support.placeholder) {
        jQuery("[placeholder]").focus(function () {
            if (jQuery(this).val() == jQuery(this).attr("placeholder")) jQuery(this).val("");
        }).blur(function () {
            if (jQuery(this).val() == "") jQuery(this).val(jQuery(this).attr("placeholder"));
        }).blur();

        jQuery("[placeholder]").parents("form").submit(function () {
            jQuery(this).find('[placeholder]').each(function() {
                if (jQuery(this).val() == jQuery(this).attr("placeholder")) {
                    jQuery(this).val("");
                }
            });
        });
    }
});//

$(document).ready(function() {

  $("#owl-demo").owlCarousel({
    autoPlay: 3000, //Set AutoPlay to 3 seconds
    items : 4,
    loop:true,
    autoWidth:true,
    itemsDesktop : [1199,3],
    itemsDesktopSmall : [979,3]
  });
});

$(document).ready(function (n) {
    "use strict";
    n(".responsive-menu").click(function () {
        n(".responsive-menu-content").toggleClass("show-canvas")
    }), n(".responsive-menu-content ul li a").click(function () {
        n(".responsive-menu-content").removeClass("show-canvas")
    })
});

$(document).ready(function(n) {
    var opts = {
        zoom: 10,
        //center: new google.maps.LatLng(46.1420653, 8.9959221),
        center: new google.maps.LatLng(46.1046609262044,9.018402099609375),
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        zoomControl: true,
        mapTypeControl: false,
        scaleControl: false,
        streetViewControl: false,
        rotateControl: false
    };

    var gMap = new google.maps.Map(document.getElementById('map-container'), opts);

    var path = [];
    path.push(new google.maps.LatLng('46.19931964112396', '8.995742797851562'));
    path.push(new google.maps.LatLng('46.17935497410555', '8.949050903320312'));
    path.push(new google.maps.LatLng('46.176977744996925', '8.895492553710938'));
    path.push(new google.maps.LatLng('46.14511295910613','8.895492553710938'));
    path.push(new google.maps.LatLng('46.128459837044915','8.886566162109375'));
    path.push(new google.maps.LatLng('46.122273108999224','8.896865844726562'));
    path.push(new google.maps.LatLng('46.05703226870927','8.902359008789062'));
    path.push(new google.maps.LatLng('46.01603873833416','8.887252807617188'));
    path.push(new google.maps.LatLng('46.00411630923806','8.8824462890625'));
    path.push(new google.maps.LatLng('45.92870710966921','8.903732299804688'));
    path.push(new google.maps.LatLng('45.97262874820093','8.966217041015625'));
    path.push(new google.maps.LatLng('45.98837476770814','8.975830078125'));
    path.push(new google.maps.LatLng('46.00983939593243','8.98681640625'));
    path.push(new google.maps.LatLng('46.034155908665014','8.98956298828125'));
    path.push(new google.maps.LatLng('46.0536967228988','8.954544067382812'));
    path.push(new google.maps.LatLng('46.06751410107052','8.96209716796875'));
    path.push(new google.maps.LatLng('46.08370938230368','8.949737548828125'));
    path.push(new google.maps.LatLng('46.13702492883557','8.961410522460938'));
    path.push(new google.maps.LatLng('46.160809861457125','9.019088745117188'));
    //path.push(new google.maps.LatLng('46.14416148780093','9.06646728515625'));
    path.push(new google.maps.LatLng('46.20122065978112','9.065093994140625'));

    var polygon = new google.maps.Polygon({
        path: path,
        strokeColor: '#50b98e',
        strokeOpacity: 1,
        strokeWeight: 2,
        fillColor: '#50b98e',
        fillOpacity: 0.6,
        draggable: false
    });
    polygon.setMap(gMap);
});