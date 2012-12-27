#encoding:utf-8
class MainController < ApplicationController

  # 首页
  def index

  end

  # 公司业务
  def services

  end

  # 成功案例
  def projects
    @title = "成功案例"
    @projects = Project.find(:all, :limit => 12)
  end

  def recruitment

  end

  # 关于我们
  def about_us

  end

  # 联系我们
  def contact

  end


end
