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

module DrgcmsControls::ResourceUsageControl

######################################################################
# Will check if new document can be added.
######################################################################
def dc_before_new()
  unless ( dc_user_has_role('resources-reservation') or dc_user_has_role('admin') )
    params[:return_to] = 'parent.reload'
    flash[:error] = 'No permission for adding reservations!'
    return false
  end
end

######################################################################
# Called when new reservation is created. Fill some default values in
# the form.
######################################################################
def dc_new_record()
  @record.resource_id = params[:resource_id]
  @record.dc_user_id  = session[:user_id]
  @record.time_from   = params[:current_date]
  @record.time_to     = params[:current_date]
end

######################################################################
# Check if it's OK to delete reservation document.
######################################################################
def can_delete_resource()
# reservation's time is up  
  if @record.time_to < Time.now
    flash[:error] = 'Time is up. Deleting is meaningless!'
    return false
  end
# not everyone can delete reservation
  unless (@record.dc_user_id == session[:user_id] or dc_user_has_role('admin') )
    flash[:error] = 'Only owner or administrator can delete reservation!'
    return false
  end  
end

end

