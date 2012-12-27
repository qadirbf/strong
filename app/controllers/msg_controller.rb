#encoding:utf-8
class MsgController < AdminBaseController

  layout "admin"

  def index
    @title = "消息首页"
    sql = "to_id = #{current_user.id} and folder_id = 0"
    @messages = get_message_by_folder(sql, params[:page])
    render :action => "inbox"
  end

  def inbox
    @title = "收件箱"
    sql = "to_id = #{current_user.id} and folder_id = 0"
    @messages = get_message_by_folder(sql, params[:page])
  end

  def outbox
    @title = "发件箱"
    sql = "from_id = #{current_user.id} and folder_id = 1"
    @messages = get_message_by_folder(sql, params[:page])
  end

  def unread
    @title = "未读消息"
    sql = "to_id = #{current_user.id} and folder_id = 0 and viewed=0"
    @messages = get_message_by_folder(sql, params[:page])
    render :action => "inbox"
  end

  def delete
    @message = EmpMsg.find(params[:id])
    if @message.folder_id == 0
      (render :text => "Error!"; return false) if @message.to_id != current_user.id
    elsif @message.folder_id == 1
      (render :text => "Error!"; return false) if @message.from_id != current_user.id
    end

    @message.folder_id = 9
    @message.save
    flash[:notice] = "成功删除！"
    redirect_to :action => 'inbox'
  end

  # 删除选择的消息
  def delete_all
    if params[:ids] and params[:ids].size > 0
      EmpMsg.update_all("folder_id = 9", ["id in (?)", params[:ids]])
    end
    flash[:notice] = "成功删除！"
    redirect_to :action => params[:r_url]
  end

  def new
    @message = EmpMsg.new
    @message.from_id = current_user.id
    if !params[:receiver_id].blank?
      @message.to_id = params[:receiver_id]
      @message.to_names = @message.to_user
    end
  end

  # 发送消息
  def send_now
    @message = EmpMsg.new(params[:message])
    @message.from_id = current_user.id

    if @message.valid? and  @message.send_now
      flash[:notice] = '成功发送！'
      redirect_to :action => 'read', :id => @message.id
    else
      render :action => 'new'
    end
  rescue => e
    flash[:notice] = e
    render :action => 'new'
  end

  def ajax_set_read
    if params[:ids] and params[:ids].size > 0
      EmpMsg.update_all("viewed=1", ["id in(?)", params[:ids]])
      render :json => {:success => true, :info => "设置成功！"}
    else
      render :json => {:success => false, :info => "请选择需要设为已读的消息！"}
    end
  end

  # 阅读消息
  def read
    @title = "查看消息"
    @message = EmpMsg.find(params[:id])
    if @message.folder_id == 0
      (render :text=>"Error!"; return false) if @message.to_id != current_user.id
    elsif @message.folder_id == 1
      (render :text=>"Error!"; return false) if @message.from_id != current_user.id
    end
    @message.marked_as_read
  end

  def reply
    message = EmpMsg.find(params[:id])
    @message = EmpMsg.new
    @message.from_id = current_user.id
    @message.to_names = message.from_user.username
    @message.title = "RE:" + message.title
    @message.content = "<div style='color:666666;'>" + message.content + "</div><hr />"
    render :action => "new"
  end

  def forward
    message = EmpMsg.find(params[:id])
    @message = EmpMsg.new
    @message.from_id = current_user.id
    @message.to_names = ""
    @message.title = "FWD:" + message.title
    @message.content = message.content
    render :action => "new"
  end

  # 设置已读
  def set_read
    if params[:ids] and params[:ids].size > 0
      EmpMsg.update_all("viewed=1", ["id in(?)", params[:ids]])
    end
    flash[:notice] = "设置成功!"
    redirect_to :action => params[:r_url]
  end

  protected

  def init_menu
    @sys_title = "消息系统"
    @sys_nav_menus = []
    @sys_nav_menus << %W(/msg/index 消息首页)
    @sys_nav_menus << %W(/msg/inbox 收件箱)
    @sys_nav_menus << %W(/msg/unread 未读消息)
    @sys_nav_menus << %W(/msg/outbox 发件箱)
  end

  def get_message_by_folder(sql, page)
    EmpMsg.paginate :conditions => sql,
                     :per_page => 30,
                     :page => page,
                     :order=>"emp_msgs.created_at desc"
  end

end
