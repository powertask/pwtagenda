module ApplicationHelper

  def flash_class(level)
    case level
      when 'success' then "alert alert-success alert-dismissable fade in"
      when 'notice' then "alert alert-success alert-dismissable fade in"
      when 'info' then "alert alert-info alert-dismissable fade in"
      when 'warning' then "alert alert-warning alert-dismissable fade in"
      when 'danger' then "alert alert-danger alert-dismissable fade in"
      when 'alert' then "alert alert-danger alert-dismissable fade in"
    end
  end

  def ticket_id(agenda_item_id)
    ticket_id = Ticket.select(:id).where('agenda_item_id = ?', agenda_item_id)[0][:id]
  end


  def ticket_number(agenda_item_id)
    ticket = Ticket.where('agenda_item_id = ?', agenda_item_id)[0]

    if ticket.present?
      return 'Gerado ticket n. '<<ticket.id.to_s
    else
      return ''
    end
  end


  def agenda_item_attended_description(ticket_id, proc)
    ticket = Ticket.find(ticket_id)

    if proc == 1
      if ticket
        if ticket.procedure_id.present?
          text = ticket.procedure.procedure_type.name + ' - ' + ticket.procedure.name
          if ticket.procedure_description.present?
           text = text + ' - ' + ticket.procedure_description
          end
        end
      end
    end

    if proc == 2
      if ticket.present?
        if ticket.procedure_2_id.present?
          text = ticket.procedure_2.procedure_type.name + ' - ' + ticket.procedure_2.name
          if ticket.procedure_description_2.present?
           text = text + ' - ' + ticket.procedure_description_2
          end
        end
      end
    end

    if proc == 3
      if ticket.present?
        if ticket.procedure_3_id.present?
          text = ticket.procedure_3.procedure_type.name + ' - ' + ticket.procedure_3.name
          if ticket.procedure_description_3.present?
           text = text + ' - ' + ticket.procedure_description_3
          end
        end
      end
    end

    return text
  end

  def agenda_item_unmarked_description(agenda_item)
    if agenda_item.unmarked?
      text = 'Consulta desmarcada ' 

      if agenda_item.unmarked_by_patient
        text << 'pelo PACIENTE '
      else
        text << 'pela CLÍNICA '
      end

      if agenda_item.unmarked_datetime.present?
        text << 'em ' << agenda_item.unmarked_datetime.to_s_br
      end

      if agenda_item.unmarked_description.present?
        text << ' - Motivo: '<<agenda_item.unmarked_description
      end
    end
  end

end
