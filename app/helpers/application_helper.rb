module ApplicationHelper
  def active_link_class(path)
    request.path == path ? 'text-blue-600 font-bold' : ''
  end
end
