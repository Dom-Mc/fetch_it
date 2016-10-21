module ApplicationHelper
  def current_year
    Time.now.year
  end

  # Returns site title or page title + site title
  def full_title(page_title = "")
    if page_title.blank?
      t(:site_name)
    else
      "#{page_title} | #{t(:site_name)}"
    end
  end

  def flash_class(flash_type)
    case flash_type
      when "notice" then "alert alert-dismissable alert-info"
      when "success" then "alert alert-dismissable alert-success"
      when "error" then "alert alert-dismissable alert-danger"
      when "alert" then "alert alert-dismissable alert-danger"
      else flash_type.to_s
    end
  end

end
