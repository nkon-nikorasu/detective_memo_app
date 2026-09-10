module ApplicationHelper
  def page_title(title = "")
    base_title = "DetectiveMemo"
    title.present? ? "#{title} | #{base_title}" : base_title
  end

  def show_incident_sidebar?
    return true if controller_name == "incidents" &&
                 action_name.in?(%w[show edit update])

    return true if controller_name == "memos" &&
                 action_name.in?(%w[index edit update])

    return true if controller_name == "characters" &&
                 action_name.in?(%w[index edit update])

    return true if controller_name == "incident_times" &&
                 action_name.in?(%w[index edit update])

    false
  end
end
