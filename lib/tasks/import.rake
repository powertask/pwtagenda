namespace :import do

  desc "Send email next schedule "
  task :procedures => :environment do
    require 'csv'

    begin
      ActiveRecord::Base.transaction do

        CSV.foreach('lib/tasks/procedimentos_comodato.csv', headers: true) do |row|

          proc = Procedure.where('procedure_type_id = 1 and health_insurance_id = 3 and code = ?', row[1])[0]

          if proc.present?
            proc.name = row[2].squish!
            proc.cho = row[3].squish!
            proc.copart_value = row[4].squish!
            proc.health_insurance_value = row[5].squish!
          else            
            proc = Procedure.new
            proc.unit_id = 1
            proc.procedure_type_id = 1
            proc.health_insurance_id = 3
            proc.code = row[1].squish!
            proc.name = row[2].squish!
            proc.cho = row[3].squish!
            proc.copart_value = row[4].squish!
            proc.health_insurance_value = row[5].squish!
          end
          proc.save!
        end
      
      end
      rescue ActiveRecord::RecordInvalid => e
        puts e.record.errors.full_messages      
    end
  end
end

 