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