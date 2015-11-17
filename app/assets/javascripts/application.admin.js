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
//= require global/plugins/jquery.min
//= require global/plugins/jquery-migrate.min
//= require global/plugins/jquery-ui/jquery-ui.min
//= require global/plugins/bootstrap/js/bootstrap.min
//= require global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min
//= require global/plugins/jquery-slimscroll/jquery.slimscroll.min
//= require global/plugins/jquery.blockui.min
//= require global/plugins/jquery.cokie.min
//= require global/plugins/uniform/jquery.uniform.min
//= require global/plugins/bootstrap-switch/js/bootstrap-switch.min

/* BEGIN PAGE LEVEL PLUGINS */
//= require global/plugins/jqvmap/jqvmap/jquery.vmap
//= require global/plugins/jqvmap/jqvmap/maps/jquery.vmap.russia
//= require global/plugins/jqvmap/jqvmap/maps/jquery.vmap.world
//= require global/plugins/jqvmap/jqvmap/maps/jquery.vmap.europe
//= require global/plugins/jqvmap/jqvmap/maps/jquery.vmap.germany
//= require global/plugins/jqvmap/jqvmap/maps/jquery.vmap.usa
//= require global/plugins/jqvmap/jqvmap/data/jquery.vmap.sampledata
//= require global/plugins/flot/jquery.flot.min
//= require global/plugins/flot/jquery.flot.resize.min
//= require global/plugins/flot/jquery.flot.categories.min
//= require global/plugins/jquery.pulsate.min
//= require global/plugins/bootstrap-daterangepicker/moment.min
//= require global/plugins/bootstrap-daterangepicker/daterangepicker
//= require global/plugins/fullcalendar/fullcalendar.min
//= require global/plugins/jquery-easypiechart/jquery.easypiechart.min
//= require global/plugins/jquery.sparkline.min
//= require global/plugins/bootstrap-toastr/toastr

/* BEGIN PAGE LEVEL SCRIPTS */
//= require global/scripts/metronic
//= require admin/layout/scripts/layout
//= require admin/layout/scripts/quick-sidebar
//= require admin/layout/scripts/demo
//= require admin/pages/scripts/index
//= require admin/pages/scripts/tasks


/* OTHER  */
//= require jquery_ujs
/* CK Editor*/
//= require ckeditor/init

function ActiveSideBarMenu(options) {
  var module = this;
  var defaults = {
    url: window.location.pathname,
    menu: $('.page-sidebar-menu'),
  };

  module.settings = $.extend({}, defaults, options);
  module.activeAbsolute = function() {
    var found = module.settings.menu.find('a[href="'+ module.settings.url +'"]');
    if (found.length == 1) {
      var current_tab = found[0];
      var all_tabs = $(current_tab).parents('li');
      for (i = 0; i < all_tabs.length; i++) {
        var $li = $(all_tabs[i]);
        var has_sub_menu = $li.has("ul.sub-menu");
        if (has_sub_menu) {
          $li.addClass('active open');
          $li.children('a').children('span.arrow').addClass('open');
        } else {
          $li.addClass('active');
        }
      }
      return true;
    }
    return false;
  }

  module.activeRelation = function() {
    return false;
  }

  module.activeDefault = function() {
    
  }
  module.init = function() {
    var isActiveAbsolue = module.activeAbsolute();
    if (!isActiveAbsolue) {
      var isActiveReation = module.activeRelation();
      if (!isActiveReation) {
        module.activeDefault();
      }
    }
  }
}

jQuery(document).ready(function() {
  Metronic.init(); // init metronic core componets
  Layout.init(); // init layout
  QuickSidebar.init(); // init quick sidebar
  Demo.init(); // init demo features
  Index.init();
  Index.initDashboardDaterange();
  // Index.initJQVMAP(); // init index page's custom scripts
  Index.initCalendar(); // init index page's custom scripts
  Index.initCharts(); // init index page's custom scripts
  Index.initChat();
  Index.initMiniCharts();
  Tasks.initDashboardWidget();

  var activeSideBarMenu = new ActiveSideBarMenu();
  activeSideBarMenu.init();


  $( "#header_notification_bar" ).on( "click", function() {
    // alert("/v1/notification");
    var ids_val = $('#ids_notification').val()
    // console.log(ids_val)
    $.ajax({
      method: "POST",
      url: "/v1/notification",
      data: { ids: ids_val }
    })
      .done(function( msg ) {
        console.log(msg.code)
        // $('.num_notification').html("0");
      });
  });
});