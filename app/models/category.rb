#encoding:utf-8
class Category < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :projects
end
