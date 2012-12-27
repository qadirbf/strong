#encoding:utf-8
class ProjectsController < AdminBaseController

  layout :select_layout

  before_filter :init_menu
  protect_from_forgery :except => 'delete_projects'

  def select_layout
    ["show"].include?(params[:action]) ? "application" : "admin"
  end

  def edit
    unless params[:id].blank?
      @title = "修改项目"
      @project = Project.find(params[:id])
    else
      @title = "添加项目"
      @project = Project.new
    end
  end

  def update
    user = current_user
    unless params[:id].blank?
      @project = Project.find(params[:id])
      @project.update_attributes(params[:project].merge(:updated_by => user.id))
    else
      @project = Project.new(params[:project].merge(:updated_by => user.id, :created_by => user.id))
    end
    if @project.valid?
      upload_pics
      @project.save
      flash[:notice] = "成功保存！"
      redirect_to :action => "list", :format => "php"
    else
      @title = params[:id].blank? ? "添加项目" : "修改项目"
      render :action => "edit"
    end
  end

  def upload_pics
    unless params[:index_pic].blank?
      begin
        old_index_pic = @project.index_pic
        fm = FileManager.new({:root_folder_path => FileManager.expand_path("public/projects"), :file_max_size => 500.kilobytes, :file_exts => ['jpg', 'gif', 'jpeg']})
        @project.update_attributes(:index_pic => fm.upload_file(params[:index_pic]))
        fm.kill_file(old_index_pic)
      rescue RuntimeError => e
        flash[:notice] = e.to_s
      end
    end
    unless params[:pic_path].blank?
      begin
        old_pic_path = @project.pic_path
        fm = FileManager.new({:root_folder_path => FileManager.expand_path("public/projects"), :file_max_size => 500.kilobytes, :file_exts => ['jpg', 'gif', 'jpeg']})
        @project.update_attributes(:pic_path => fm.upload_file(params[:pic_path]))
        fm.kill_file(old_pic_path)
      rescue RuntimeError => e
        flash[:notice] = e.to_s
      end
    end
  end

  def show
    @project = Project.find(params[:id])
    @title = @project.name
  end

  def index

  end

  def list
    @title = "项目列表"
    @projects = Project.paginate :order => "id", :page => params[:page], :per_page => 30
  end

  def delete
    unless params[:id].blank?
      Project.delete(params[:id].to_i)
      redirect_to :action => :list
    end
  end

  # 批量删除项目
  def delete_projects
    unless params[:ids].blank?
      Project.delete(params[:ids].split(','))
      render :text => "删除成功"
    else
      render :text => ""
    end
  end

  protected

  def init_menu
    @sys_nav_menus = [['/projects/list', '项目列表']]
  end

end
