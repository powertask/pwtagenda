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


