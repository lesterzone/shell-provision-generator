module ApplicationHelper
  def body_page_name
    [controller_name.classify.pluralize, action_name.classify].join
  end

  def owner(obj)
    return false unless current_user
    obj.user_id.to_i == current_user.id
  end
end
