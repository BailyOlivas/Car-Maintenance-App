module ApplicationHelper
def formatted_current_time
  Time.current.strftime("%B %d, %Y %I:%M %p")
end
end
