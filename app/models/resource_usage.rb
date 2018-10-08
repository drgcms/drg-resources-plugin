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

##########################################################################
# Resources usage (reservation) collection
# 
# == Schema information
#
# Collection name: resource : Available resources 
#
#  _id                  BSON::ObjectId       _id
#  created_at           Time                 Created at time
#  updated_at           Time                 Last updated at time
#  time_from            DateTime             Reservation start time
#  time_to              DateTime             Reservation end time
#  description          String               Description of the reservation
#  resource_id          BSON::ObjectId       Resource id
#  dc_user_id           BSON::ObjectId       Reservation was created by
#  active               Boolean              Resource is active
##########################################################################
class ResourceUsage
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :time_from,   type: DateTime
  field :time_to,     type: DateTime
  field :description, type: String
  
  field :created_by,  type: BSON::ObjectId
  field :updated_by,  type: BSON::ObjectId
  
  belongs_to :resource
  belongs_to :dc_user
  
  index resource_id: 1, time_from: 1
   
  validates :time_from,   presence: true
  validates :time_to,     presence: true
  validates :description, presence: true
  
  validate  :free_time_validations
  
######################################################################
# Validates if resource is available in specified time window.
######################################################################
def free_time_validations
  errors.add(:time_from, "should be less then end time!") if time_from >= time_to
  errors.add(:time_from, "is less then current time!") if time_from <= Time.now
  if ResourceUsage.where(resource_id: resource_id).and({"$or" => [ 
       {"$and" => [ {:time_from.lt  => time_from}, {:time_to.gt  => time_from} ] },
       {"$and" => [ {:time_from.lt  => time_to},   {:time_to.gt  => time_to} ] },
       {"$and" => [ {:time_from.gte => time_from}, {:time_to.lte => time_to} ] }
       ] }).exists?
     errors.add(:time_from, "Resource already taken!")
  end                                       
end

end
