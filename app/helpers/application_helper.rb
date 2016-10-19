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

end
