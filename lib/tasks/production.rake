namespace :production do

  desc "Send email next schedule "
  task :notify_next_schedule => :environment do
    _today_ini = Date.current
    _today_end = _today_ini + 1.day - 1.second

    _tomorrow_ini = Date.current + 1.day
    _tomorrow_end = _tomorrow_ini + 1.day - 1.second

    _after_tomorrow_ini = Date.current + 2.day
    _after_tomorrow_end = _after_tomorrow_ini + 1.day - 1.second

    units = Unit.all
    units.each do |unit|
      agenda_items = AgendaItem.list(unit.id).marked.where('scheduled_to between ? and ?', _today_ini, _today_end)
      agenda_items.each do |agenda_item|
        puts 'Email today sending!'
        PatientMailer.notify_next_schedule(agenda_item, 0).deliver_now
      end

      agenda_items = AgendaItem.list(unit.id).marked.where('scheduled_to between ? and ?', _tomorrow_ini, _tomorrow_end)
      agenda_items.each do |agenda_item|
        puts 'Email tomorrow sending!'
        PatientMailer.notify_next_schedule(agenda_item, 1).deliver_now
      end

      agenda_items = AgendaItem.list(unit.id).marked.where('scheduled_to between ? and ?', _after_tomorrow_ini, _after_tomorrow_end)
      agenda_items.each do |agenda_item|
        puts 'Email after tomorrow sending!'
        PatientMailer.notify_next_schedule(agenda_item, 2).deliver_now
      end
    end
  end
end

 
