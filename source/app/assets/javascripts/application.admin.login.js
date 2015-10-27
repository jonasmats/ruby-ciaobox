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
//= require global/plugins/bootstrap/js/bootstrap.min
//= require global/plugins/jquery.blockui.min
//= require global/plugins/jquery.cokie.min
//= require global/plugins/uniform/jquery.uniform.min

/* BEGIN PAGE LEVEL PLUGINS */
//= require global/plugins/jquery-validation/js/jquery.validate.min

/* BEGIN PAGE LEVEL SCRIPTS */
//= require global/scripts/metronic
//= require admin/layout/scripts/layout
//= require admin/layout/scripts/demo
//= require admin/pages/scripts/login

/* OTHER  */
//= require jquery_ujs

jQuery(document).ready(function() {
  Metronic.init(); // init metronic core componets
  Metronic.init(); // init metronic core components
  Layout.init(); // init current layout
  Login.init();
  Demo.init();
});