//= require jquery 
//= require jquery-ui
//= require tether
//= require moment 
//= require magnific-popup
//= require fullcalendar
//= require bootstrap
//= require rails-ujs
//= require creative
//= require powertask 
//= require turbolinks
//= require_tree .
//= require jquery.turbolinks
//= require scrollReveal

$(function() {
  window.scrollReveal = new scrollReveal();
});

function showEventDetails(event){
    jQuery.ajax({
        data: 'id=' + event.id,
        dataType: 'script',
        type: 'get',
        url: '/agendas/get_click'
    });
}
