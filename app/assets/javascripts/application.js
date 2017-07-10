//= require jquery3
//= require jquery_ujs
//= require jquery-ui
//= require tether
//= require moment 
//= require fullcalendar
//= require bootstrap
//= require rails-ujs
//= require scrollReveal
//= require magnific-popup
//= require creative
//= require powertask 
//= require turbolinks
//= require_tree .
//= require jquery.turbolinks

$(document).ready(function() {
	$(function() {
	  window.scrollReveal = new scrollReveal();
	});
});

function showEventDetails(event){
    jQuery.ajax({
        data: 'id=' + event.id,
        dataType: 'script',
        type: 'get',
        url: '/agendas/get_click'
    });
}
