class PatientMailer < ApplicationMailer

  def notify_new_schedule(agenda_item)
    @agenda_item = agenda_item
    @agenda = Agenda.find(agenda_item.agenda_id)
    @patient = Patient.find(agenda_item.patient_id)
    @unit = Unit.find(agenda_item.unit_id)
    mail(to: @patient.email, subject: @unit.name + ' - Você tem uma nova consulta agendada conosco!')
  end

  def notify_next_schedule(agenda_item, status)
    @agenda_item = agenda_item
    @agenda = Agenda.find(agenda_item.agenda_id)
    @patient = Patient.find(agenda_item.patient_id)
    @unit = Unit.find(agenda_item.unit_id)
    @status = status

    subject = @unit.name + ' - Sua consulta é HOJE!' if status == 0
    subject = @unit.name + ' - Sua consulta é AMANHÃ!' if status == 1
    subject = @unit.name + ' - Sua consulta está próxima' if status == 2

    mail(to: @patient.email, subject: subject)
  end

end
