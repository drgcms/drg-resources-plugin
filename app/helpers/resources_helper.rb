module ResourcesHelper

#####################################################################
#
#####################################################################
def render_usages(resource_usages, date)
  html = ''
  return html if resource_usages.nil?
  resource_usages.each do |usage|
    if usage.time_from <= date.end_of_day and usage.time_to >= date.beginning_of_day
      time1 = usage.time_from < date.beginning_of_day ? '00:00' : usage.time_from.strftime('%H:%M')
      time2 = usage.time_to > date.end_of_day ? '24:00' : usage.time_to.strftime('%H:%M')
      next if time1 == time2
      url   = "/cms/#{usage.id}/edit?form_name=resource_usage_show&table=resource_usage"
      html << %Q[<div title="Click to view" data-url="#{url}"><b>#{time1} - #{time2}</b><br>#{usage.description}</div>]
    end
  end
  html.html_safe
end

end
