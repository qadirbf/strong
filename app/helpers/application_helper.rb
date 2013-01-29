#encoding:utf-8
module ApplicationHelper

  def html_blank(n=1)
    ("&nbsp;"*n).html_safe
  end

  def include_datepicker
    render :partial => "/common/datepicker"
  end

  def errors_for(obj)
    errors = obj.errors.messages.values.flatten.map { |v| "* #{v}" }
    return '' unless errors.size>0
    %{<div class="alert alert-error">#{errors.join("<br>")}</div>}.html_safe
  end

  def format_date(date, type)
    case type
      when :full
        (date ? date.strftime("%Y-%m-%d %H:%M:%S") : "")
      when :min
        (date ? date.strftime("%Y-%m-%d %H:%M") : "")
      when :date
        (date ? date.strftime("%Y-%m-%d") : "")
      when :mon
        (date ? date.strftime("%Y-%m") : "")
      when :year
        (date ? date.strftime("%Y") : "")
      when :quarter
        (date ? [date.strftime("%Y"), "年", [["第一", "第二", "第三", "第四"][(date.month-1)/3], "季度"]].join : "")
      when :expired
        (date ? (date>Time.now ? "未到期" : "已到期") : "")
    end
  end

  def url_with_session(link)
    return link if !link
    l = link.split("/")-[""]
    if l.size==1
      url_for :controller => l[0], :action => "index", :id => nil
    elsif l.size==2
      return link if l[1].include?("?")
      url_for :controller => l[0], :action => l[1], :id => nil
    else
      return link
    end
  end

  def page_links(obj)
    will_paginate obj, :params => page_params(params), :previous_label => "上一页", :next_label => "下一页"
  end

  def page_params(p)
    p||={}
    pa = Hash.new
    p.each { |k, v|
      pa[k] = v if k!='controller'&&k!='page'&&k!='action'
    }
    pa
  end

  def action_name(name)
    if ["introduction", "ceo", "organization", "culture", "honor"].include?(name.to_s)
      return "yewu"
    end
    if ["projects"].include?(name.to_s)
      return "projects"
    end
    if ["services", "case_list"].include?(name.to_s)
      return "services"
    end
  end

end
