#--
# Copyright (c) 2018+ Damjan Rems
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++

module ResourcesHelper
#####################################################################
# Render single usage.
#####################################################################
def render_usages(resource_usages, date)
  html = ''
  return html if resource_usages.nil?
#
  resource_usages.each do |usage|
    if usage.time_from <= date.end_of_day and usage.time_to >= date.beginning_of_day
      time1 = usage.time_from < date.beginning_of_day ? '00:00' : usage.time_from.strftime('%H:%M')
      time2 = usage.time_to > date.end_of_day ? '24:00' : usage.time_to.strftime('%H:%M')
      next if time1 == time2
# url for displaying detail data      
      url   = "/cms/#{usage.id}/edit?form_name=resource_usage_show&table=resource_usage"
      html << %Q[<div class="resource-usage" title="Click to view" data-url="#{url}"><b>#{time1} - #{time2}</b><br>#{usage.description}</div>]
    end
  end
  html.html_safe
end

end
