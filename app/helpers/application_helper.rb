module ApplicationHelper
  def page_title(title = "")
    base_title = "DetectiveMemo"
    title.present? ? "#{title} | #{base_title}" : base_title
  end

  def incident_menu_link(name, path, controller)
    active_class = if sidebar_active?(controller)
                    "bg-blue-500 font-bold text-white"
                  else
                    "bg-blue-200"
                  end

    link_to name, path,
            class: "flex flex-1 rounded-xl h-full py-3 mx-2 items-center justify-center box-border hover:bg-blue-400 active:text-white #{active_class}"
  end

  def show_incident_sidebar?
    return true if controller_name == "incidents" &&
                 action_name.in?(%w[show edit update])

    return true if controller_name == "books" &&
                 action_name.in?(%w[search])

    return true if controller_name == "memos" &&
                 action_name.in?(%w[index edit update])

    return true if controller_name == "character_relationships" &&
                 action_name.in?(%w[index create edit update])

    return true if controller_name == "characters" &&
                 action_name.in?(%w[index edit update])

    return true if controller_name == "incident_times" &&
                 action_name.in?(%w[index edit update])

    false
  end

  def sidebar_active?(controller, action = nil)
    return false unless controller_name == controller

    action.nil? || action_name == action
  end
end
