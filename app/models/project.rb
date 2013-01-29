#encoding:utf-8
class Project < ActiveRecord::Base
  # attr_accessible :title, :body
  validates_presence_of :name, :message => "项目名称不能为空"
  validates_uniqueness_of :name, :message => "项目名称已经存在", :if => Proc.new{|p| p.name}
  validates_presence_of :project_date, :message => "项目时间不能为空"
  validates_presence_of :tech_info, :message => "请填写技术信息"
  validates_presence_of :description, :message => "请填写项目描述"
  validates_presence_of :system_config, :message => "请填写系统配置"

  belongs_to :category

end
