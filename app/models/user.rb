#encoding:utf-8
class User < ActiveRecord::Base
  # attr_accessible :title, :body
  validates_presence_of :username, :message => "请填写用户名！"
  validates_presence_of :password, :message => "请填写密码！"
  #validates_presence_of :department_id, :message => "请选择部门！"
  #validates_presence_of :active, :message => "请选择是否允许登录！"
  validates_uniqueness_of :username, :message => "用户名已经存在！"
  belongs_to :department
  has_many   :car_registers

  include StrongLib::Security
  scope :active_user, where(:active => 1)

  def is_admin?
    self.id==1
  end

  def to_s
    self.username
  end

  def active_label
    self.active==1 ? '是' : '否'
  end

end
