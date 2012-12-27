#encoding:utf-8
class Car < ActiveRecord::Base

  has_many :car_registers

  validates_presence_of :name, :message => "车辆名不能为空"
  validates_presence_of :buy_time, :message => "购买时间不能为空"
  # attr_accessible :title, :body

  def using_status
    unless self.car_registers.where(["begin_time >= ?", Time.now.beginning_of_day]).blank?
      "使用中"
    else
      "当前空闲"
    end
  end


end
