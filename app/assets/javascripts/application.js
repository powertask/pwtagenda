//= require jquery 
//= require jquery-ui
//= require tether
//= require moment 
//= require magnific-popup
//= require fullcalendar
//= require bootstrap
//= require rails-ujs
//= require scrollReveal
//= require creative
//= require powertask 
//= require turbolinks
//= require_tree .
//= require jquery.turbolinks

function showEventDetails(event){
    jQuery.ajax({
        data: 'id=' + event.id,
        dataType: 'script',
        type: 'get',
        url: '/agendas/get_click'
    });
}
