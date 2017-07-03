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

  def ticket_number(agenda_item_id)
    ticket = Ticket.where('agenda_item_id = ?', agenda_item_id)[0]

    if ticket.present?
      return 'Gerado ticket n. '<<ticket.id.to_s
    else
      return ''
    end
  end

  def procedure_name(agenda_item_id)
    ticket = Ticket.where('agenda_item_id = ?', agenda_item_id)[0]

    if ticket.present?
      return ticket.procedure_id.present? ? ticket.procedure.procedure_type.name << ' - ' <<ticket.procedure.name : ''
    end
  end

end
