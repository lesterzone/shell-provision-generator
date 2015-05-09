module ApplicationHelper
  def body_page_name
    [controller_name.classify.pluralize, action_name.classify].join
  end
end
