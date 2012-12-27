#encoding:utf-8
class EmpMsg < ActiveRecord::Base
  belongs_to :from_user, :class_name => "User", :foreign_key => 'from_id'
  belongs_to :to_user, :class_name => "User", :foreign_key => 'to_id'
  #has_many :send_copies, :class_name => "Empmsg", :foreign_key => "parent_id"

  validates_presence_of :title, :message => "标题不能为空！"
  validates_presence_of :from_id, :message => "发件人不能为空！"
  validates_presence_of :to_names, :message => "收件人不能为空！"
  validates_presence_of :content, :message => "消息内容不能为空！"

  FOLDER = [[0, "收件箱"], [1, "发件箱"]]

  def self.send_msg(from_id, to_ids, title, content, url=nil)
    to_ids = [to_ids] unless to_ids.is_a?(Array)
    to_ids = to_ids.compact.uniq
    emps = User.all(:select => "id,username", :conditions => ["id in (?)", to_ids], :order => "username")
    to_names = emps.map(&:username).join(';')
    emps.each do |e|
      self.create(:from_id => from_id, :to_id => e.id, :title => title, :content => content, :to_names => to_names, :viewed => 0, :url => url)
    end
  end

  # 发送消息
  def self.send_message(from_id, to_ids, title, body)
    to_ids = [to_ids] if to_ids.class.name != "Array"
    to_ids = to_ids.uniq.compact
    receivers = User.find(:all, :conditions => ["id in (?)", to_ids])
    receivers.each do |r|
      message = EmpMsg.new
      message.from_id = from_id
      message.to_names = receivers.map { |rr| rr.username }.join("; ")
      message.to_id = r.id
      message.title = title
      message.content = body
      message.folder_id = 0
      message.viewed = 0
      message.save
    end
  end



  def send_now
    address_ary = resolve_receiver_address
    if address_ary.size > 0
      address_ary.each do |address|
        if !address[1].blank?
          employee = User.find_by_username(address[1])
          if employee
            message = EmpMsg.new
            message.from_id = self.from_id
            message.to_names = self.to_names
            message.to_id = employee.id
            message.title = self.title
            message.content = self.content
            message.folder_id = 0
            message.viewed = 0
            message.save
          end
        end
      end
    else
      raise "没有可以识别的收件人！"
    end
    self.folder_id = 1
    self.viewed = 1
    self.save
  end

  def resolve_receiver_address
    return [] if self.to_names.blank?
    addresses = self.to_names.gsub("\>", "").split(";")
    add_ary = []
    addresses.each do |a|
      if a.include?("<")
        add_ary << [a.split("<")[0].strip, a.split("<")[1].strip]
      else
        add_ary << ["", a.strip]
      end
    end
    add_ary
  end

  def sender_name
    self.from_id == 0 ? "系统" : self.from_user
  end

  def viewed?
    self.viewed == 1
  end

  def in_inbox?
    self.folder_id == 0
  end

  def in_outbox?
    self.folder_id == 1
  end

  # 标记为已读
  def marked_as_read
    self.viewed = 1
    self.save
  end

  def self.user_unview_count(user)
    self.count(:id, :conditions => ["viewed=0 and to_id=? and folder_id = 0", user.id])
  end

end
