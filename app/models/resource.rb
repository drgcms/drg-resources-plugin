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
# Resources declaration collection
# 
# == Schema information
#
# Collection name: resource : Available resources 
#
#  _id                  BSON::ObjectId       _id
#  created_at           Time                 Created at time
#  updated_at           Time                 Last updated at time
#  name                 String               Resource name
#  description          String               Description of the resource
#  category             BSON::ObjectId       Resource category
#  active               Boolean              Resource is active
##########################################################################
class Resource
  include Mongoid::Document
  include Mongoid::Timestamps

  field   :name,        type: String
  field   :description, type: String
  field   :category,    type: BSON::ObjectId
  field   :active,      type: Boolean, default: true
  
  field   :created_by,  type: BSON::ObjectId
  field   :updated_by,  type: BSON::ObjectId
  
  index category: 1
   
  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true
  
  has_many :resource_usages
end
