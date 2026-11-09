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
    sidebar_actions = {
      "incidents" => %w[show edit update],
      "books" => %w[search],
      "memos" => %w[index edit update],
      "character_relationships" => %w[index create edit update],
      "characters" => %w[index edit update],
      "incident_times" => %w[index edit update]
    }

    # 現在のコントローラに対応するアクション一覧を取得
    actions = sidebar_actions.fetch(controller_name, [])

    # 現在のアクションが配列に含まれているか判定
    actions.include?(action_name)
  end

  def sidebar_active?(controller, action = nil)
    return false unless controller_name == controller

    action.nil? || action_name == action
  end
end
