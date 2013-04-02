#encoding:utf-8
class CarsController < AdminBaseController

  layout "admin"

  def list
    @title = "车辆一览"
    @cars = Car.all
  end

  def edit
    unless params[:id].blank?
      @title = "修改车辆信息"
      @car = Car.find(params[:id])
    else
      @title = "添加车辆"
      @car = Car.new
    end
  end

  def update
    user = current_user
    unless params[:id].blank?
      @car = Car.find(params[:id])
      @car.update_attributes(params[:car].merge(:updated_by => user.id))
    else
      @car = Car.new(params[:car].merge(:updated_by => user.id, :created_by => user.id))
    end
    if @car.valid?
      @car.save
      flash[:notice] = "成功保存！"
      redirect_to :action => "list", :format => "php"
    else
      @title = params[:id].blank? ? "添加车辆" : "修改车辆信息"
      render :action => "edit"
    end
  end

  def show
    @car = Car.find(params[:id])
    @title = @car.name
  end

  def destroy
    c = Car.find(params[:id])
    c.destroy
    flash[:notice] = "成功删除！"
    redirect_to :action => "list"
  end

  def register_list
    @title = "车辆使用情况"
    @users = User.all.map { |u| [u.username, u.id] }
    @cars = Car.all.map { |c| [c.name, c.id] }
    @registers = CarRegister.paginate :conditions => CarRegister.get_sql_by_hash(params), :order => "created_at desc",
                                      :per_page => 30, :page => params[:page]
  end

  # 登记使用车辆
  def register_use
    unless params[:id].blank?
      @title = "修改登记信息"
      @register = CarRegister.find(params[:id])
    else
      @title = "登记"
      @register = CarRegister.new
    end
    @users = User.all.map { |u| [u.username, u.id] }
    @cars = Car.all.map { |c| [c.name, c.id] }
  end

  def register_update
    @register = CarRegister.new(params[:register])
    if @register.valid?
      @register.save
      flash[:notice] = "成功保存！"
      redirect_to :action => "register_show", :id => @register.id
    else
      @title = params[:id].blank? ? "登记" : "修改登记信息"
      @users = User.all.map { |u| [u.username, u.id] }
      @cars = Car.all.map { |c| [c.name, c.id] }
      render :action => "register_use"
    end
  end

  def register_show
    @register = CarRegister.find(params[:id])
    @title = "车辆使用登记信息"
  end


  def init_menu
    @sys_title = "车辆管理"
    @sys_nav_menus = []
    @sys_nav_menus << %W(/admin 首页)
    @sys_nav_menus << %W(/cars/list 车辆一览)
    @sys_nav_menus << %W(/cars/register_list 车辆使用情况)
  end

end
