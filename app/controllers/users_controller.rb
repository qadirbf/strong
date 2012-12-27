#encoding:utf-8
class UsersController < AdminBaseController

  layout "admin"

  def list
    @title = "员工列表"
    @users = User.paginate :conditions => User.get_sql_by_hash(params), :order => "username",
                           :per_page => 30, :page => params[:page]
  end

  def show
    @title = "员工信息"
    @user = User.find(params[:id])
  end

  def destroy
    e = User.find(params[:id])
    e.destroy
    flash[:notice] = "成功删除！"
    redirect_to :action => "list"
  end

  def edit
    unless params[:id].blank?
      @title = "修改员工"
      @user = User.find(params[:id])
    else
      @title = "添加员工"
      @user = User.new
    end
  end

  def update
    user = current_user
    unless params[:id].blank?
      @user = User.find(params[:id])
      @user.update_attributes(params[:user].merge(:updated_by => user.id))
    else
      @user = User.create(params[:user].merge(:updated_by => user.id, :created_by => user.id))
    end
    if @user.errors.empty?
      flash[:notice] = "成功保存！"
      redirect_to :action => "show", :id => @user.id
    else
      @title = params[:id].blank? ? "添加员工" : "修改员工"
      render :action => "edit"
    end
  end

  def login
    @title = "请登录"
    if request.post?
      user = User.active_user.authenticate(params[:username], params[:password])
      if user
        UserSession.user_login_check(request.session_options[:id], user, request.remote_ip())

        session[:user_id] = user.id
        Strong.user = user

        flash[:notice] = "成功登录！"
        flash[:last_url] = flash[:last_url] if flash[:last_url]
        redirect_to admin_path
        return false
      else
        raise AppError, "用户名或密码错误！"
      end
    end
    render :layout => "sign"
  rescue AppError => e
    flash[:notice] = "用户名或密码错误！"
    redirect_to :action => "login"
  end

  def sign

  end

  def logout
    reset_session
    flash[:notice] = "成功退出系统！"
    redirect_to :action => "login"
  end

  protected
  def init_menu
    unless logged_in?
      @sys_nav_menus = [['/users/login','登录']]
    else
      @sys_nav_menus = [['/users/list','员工列表']]
    end
  end

end
