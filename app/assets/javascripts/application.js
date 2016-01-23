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
//= require js/jquery-migrate-1.2.1.min.js
//= require js/slick.min.js


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

//slick slider on homepage
$(document).ready(function() {
    var slider = $('.slide-image');
    if (slider != undefined && slider != null) {
        slider.slick({
            slidesToShow: 3,
            slidesToScroll: 1,
            autoplay: true,
            autoplaySpeed: 3000,
            adaptiveHeight: true,
            mobileFirst: true,
            variableWidth: true,
            centerMode: true,
            nextArrow: '<a class="right noback-carousel-control" role="button" data-slide="next" style="display:block; z-index:99999;"><span aria-hidden="true" class="glyphicon glyphicon-chevron-right"></span></a>',
            prevArrow: '<a class="left noback-carousel-control" role="button" data-slide="prev" style="display:block; z-index:99999;"><span aria-hidden="true" class="glyphicon glyphicon-chevron-left"></span></a>',
        });
    }
});