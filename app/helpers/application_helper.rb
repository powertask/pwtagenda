module ApplicationHelper

  def flash_class(level)
    case level
      when 'success' then "alert alert-success alert-dismissable fade in"
      when 'notice' then "alert alert-success alert-dismissable fade in"
      when 'info' then "alert alert-info alert-dismissable fade in"
      when 'warning' then "alert alert-warning alert-dismissable fade in"
      when 'danger' then "alert alert-danger alert-dismissable fade in"
    end
  end
end
