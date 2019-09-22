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

########################################################################
# Resources usage renderer.
########################################################################
class ResourcesRenderer < DcRenderer
include DcApplicationHelper
  
########################################################################
# Render resources usage table.
########################################################################
def resources_usage
# define currently selected week 
  time = Date.parse(@parent.params[:selected_date]) rescue DateTime.now
  date_from = time.beginning_of_week
  date_to   = time.end_of_week
# scoupe selected resources and usage documents  
  resources = Resource.where(category: @parent.params[:category], active: true).order_by(name: 1).to_a
  ids = resources.inject([]) { |r,e| r << e.id }
  usages = ResourceUsage.where(:resource_id.in => ids)
           .and(:time_from.lt => date_to, :time_to.gt => date_from)
           .order_by(resource_id: 1, time_from: 1).group_by(&:resource_id)
# render rails usage views
  @parent.render(partial: 'resources/usage', formats: [:html], 
                 locals: { date_from: date_from, date_to: date_to, 
                           resources: resources, usages: usages }) 
end

########################################################################
# default renderer method will render application menu and usage table.
########################################################################
def default
  html = @parent.render(partial: 'resources/menu', formats: [:html], locals: { parent: @parent })
# render error messages and usage table
  html << dc_flash_messages << resources_usage
end

end
