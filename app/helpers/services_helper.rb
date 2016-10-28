module ServicesHelper
  def show_time(string)
    Time.zone.parse(string).strftime('%l:%M%p').squish unless string.blank?
  end
end
