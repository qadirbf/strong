#encoding:utf-8
class CarRegister < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :car
  belongs_to :user

  validates_presence_of :user_id, :message => "登记人不能为空"
  validates_presence_of :begin_time, :message => "起始使用时间不能为空"

  def using_status
    if self.begin_time.beginning_of_day > Time.now
      "未使用"
    elsif self.begin_time <= Time.now and Time.now <= self.end_time.end_of_day
      "使用中"
    elsif Time.now > self.end_time.end_of_day
      "已结束"
    end
  end

end
