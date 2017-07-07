$(function() {
  $( '#patient_birthday' ).datepicker({
    dateFormat: "dd/mm/yy",
    autoclose: true,
    showButtonPanel: true,
    numberOfMonths: 2,
    minDate: 0,
      changeMonth: true,
      changeYear: true,
    firstDay: 1
  });
});


$(function() {
  $( '#agenda_agenda_date' ).datepicker({
  dateFormat: "dd/mm/yy",
      autoclose: true,
      showButtonPanel: true,
      minDate: 0,
      numberOfMonths: 3,
      changeMonth: true,
      changeYear: true,
    firstDay: 1
  });
});


$(function() {
  $('#attended_event').click(function (event) {
    var targetUrl = $(this).attr("href");
    $.confirm({
        title: 'Compareceu?',
        content: 'Marcar comparecimemto na hora marcada',
      confirmButton: 'Sim',
      cancelButton: 'Cancelar',
      confirmButtonClass: 'btn-danger',
      theme: 'supervan',
        confirm: function(){
            window.location.href = targetUrl;
        },
        cancel: function(){

        }
    });
    return false;
  });
});

$(function() {
  $('#not_attended_event').click(function (event) {
    var targetUrl = $(this).attr("href");
    $.confirm({
        title: 'Faltou?',
        content: 'Deseja marcar a falta na hora marcada?',
      confirmButton: 'Sim',
      cancelButton: 'Cancelar',
      confirmButtonClass: 'btn-danger',
      theme: 'supervan',
        confirm: function(){
            window.location.href = targetUrl;
        },
        cancel: function(){

        }
    });
    return false;
  });
});

$(function() {
  $('#get_unmarked_event').click(function (event) {
    var targetUrl = $(this).attr("href");
    $.confirm({
        title: 'Desmarcar?',
        content: 'Deseja desmarcar a hora marcada?',
      confirmButton: 'Sim',
      cancelButton: 'Cancelar',
      confirmButtonClass: 'btn-danger',
      theme: 'supervan',
        confirm: function(){
            window.location.href = targetUrl;
        },
        cancel: function(){

        }
    });
    return false;
  });
});

$(function() {
  $('#delete_agenda').click(function (event) {
    var targetUrl = $(this).attr("href");
    $.confirm({
        title: 'Deletar agenda?',
        content: 'Deseja deletar a agenda criada?',
      confirmButton: 'Sim',
      cancelButton: 'Cancelar',
      confirmButtonClass: 'btn-danger',
      theme: 'supervan',
        confirm: function(){
            window.location.href = targetUrl;
        },
        cancel: function(){

        }
    });
    return false;
  });
});

