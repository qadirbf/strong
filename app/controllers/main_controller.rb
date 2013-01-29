#encoding:utf-8
class MainController < ApplicationController

  before_filter :get_title

  def get_title
    @title
  end

  # 首页
  def index
    @projects = Project.find(:all, :select => "id, name, created_at", :limit => 3)
  end

  # 公司业务
  def services
    @title = "主营业务"
    @projects = Project.where("").order("order_num desc,created_at desc").paginate :per_page => 6, :page => params[:page]
  end

  # 成功案例
  def projects
    @title = "成功案例"
    #@projects = Project.find(:all, :limit => 12)
  end

  def recruitment

  end

  # 关于我们
  def about_us
    @title = "关于我们"
  end

  # 联系我们
  def contact

  end

  # 公司精神
  def spirit

  end

  def introduction
    @title = "公司简介"
  end

  def culture
    @title = "公司文化"
  end

  def organization
    @title = "组织机构"
  end

  def honor
    @title = "资质荣誉"
  end

  def ceo
    @title = "总经理致辞"
  end

end
