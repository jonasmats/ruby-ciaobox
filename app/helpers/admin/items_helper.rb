module Admin::ItemsHelper
  def sti_item_path(type = "item", item = nil, action = nil)
    send "admin_#{format_sti(action, type.underscore.gsub('/','_'), item)}_path", item
  end

  def format_sti(action, type, item)
    action || item ? "#{format_action(action)}#{type.underscore}" : "#{type.underscore.pluralize}"
  end

  def format_action(action)
    action ? "#{action}_admin" : ""
  end
end
