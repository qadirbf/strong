#encoding:utf-8
class MessagesController < AdminBaseController

  layout "admin", :except => :leave_message

  def leave_message
    Message.create({:name => params[:User], :email => params[:Email],
                    :message => params[:Message], :phone => params[:Phone],
                    :company => params[:Company], :status_id => 0})
    redirect_to "/#{params[:url]}.php"
  end

  def list
    @title = "留言列表"
    @messages = Message.paginate :conditions => Message.get_sql_by_hash(params), :order => "created_at desc",
                                 :per_page => 30, :page => params[:page]
  end

  def show
    @title = "查看留言"
    @message = Message.find(params[:id])
  end

  def destroy
    e = Message.find(params[:id])
    e.destroy
    flash[:notice] = "成功删除！"
    redirect_to :action => "list"
  end

  protected
  def init_menu
    @sys_title = "留言管理"
    @sys_nav_menus = []
    @sys_nav_menus << %W(/messages/list 留言列表)
  end

end
