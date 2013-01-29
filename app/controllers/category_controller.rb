#encoding:utf-8
class CategoryController < AdminBaseController

  protect_from_forgery :except => [:get_sub_cats, :update, :get_sub_categories]

  layout "admin"

  def list
    @title = "分类列表"
    @categories = Category.where("").order("order_num desc")
  end

  def add
    @title = "添加业务一级类型"
    @category = Category.new
    if request.post?
      @category.update_attributes(params[:category])
      if @category.valid?
        @category.save
        redirect_to :action => :list
      else
        render :action => :add
      end
    end
  end

  def add_sub_category
    @title = "添加业务二级类型"
    @categories = Category.all.map { |c| [c.name, c.id] }
    @sub_category = SubCategory.new
    if request.post?
      @sub_category.attributes = params[:sub_category]
      if (@sub_category.valid? and @sub_category.name_valid?)
        @sub_category.save
        redirect_to :action => :list
      else
        render :action => :add_sub_category
      end
    end
  end

  def edit
    @title = "编辑"
    if params[:type] == "cat"
      @obj = Category.where("id=?", params[:id]).first
    else
      @obj = SubCategory.where("id=?", params[:id]).first
    end
    if request.post?
      if params[:type] == "cat"
        @obj = Category.where("id=?", params[:id]).first
      else
        @obj = SubCategory.where("id=?", params[:id]).first
      end
      @obj.name = params[:obj][:name]
      @obj.order_num = params[:obj][:order_num]
      if @obj.save
        redirect_to :action => :list
      else
        render :action => :edit
      end
    end
  end

  def update
    type, id = params[:id].split('_')
    if type == "s"
      if SubCategory.exists?(id)
        SubCategory.update(id, :name => params[:name])
      end
    end
    if type == "c"
      if Category.exists?(id)
        Category.update(id, :name => params[:name])
      end
    end
    render :text => ""
  end

  def delete
    case params[:type]
      when "category"
        if SubCategory.exists?(:category_id => params[:id])
          flash[:notice] = "该业务类型下有子类型，需要先移除该分类下的子类型"
        else
          Category.delete(params[:id])
        end
      when "sub_category"
        SubCategory.delete(params[:id])
    end
    redirect_to :action => :list
  end

  def get_sub_cats
    @sub_categories = SubCategory.where("category_id = ?", params[:id])
    render :template => "/category/sub_categories", :layout => false
  end

  def get_sub_categories
    @sub_categories = SubCategory.where(["category_id = ?", params[:id]]).map { |c| [c.name, c.id] }
    render :template => "/common/get_sub_categories", :layout => false
  end

  def init_menu
    @sys_title = "业务分类"
    @sys_nav_menus = []
    @sys_nav_menus << ['/category/list', '业务分类一览']
  end

end
