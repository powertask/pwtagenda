class HourInput < SimpleForm::Inputs::Base
  def input
    @builder.select(attribute_name, hour_options, { :selected => selected_value }, { :class => "form-control" })
  end

  private

  # The "Selecione..." string could also be translated with something like: I18n.t("helpers.select.prompt')
  def hour_options
    hour = []
    (7..22).each do |h|
      %w(00 15 30 45).each do |m|
        hour.push ["#{h}h#{m}", "#{"%02d" % h}:#{m}:00"]
      end
    end
    hour
  end

  def selected_value
    value = object.send(attribute_name)
    value && value.strftime("%H:%M:%S")
  end
end