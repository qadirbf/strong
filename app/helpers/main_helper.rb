#encoding:utf-8
module MainHelper

  def auto_link(n)
    ary = [["自动化", 1], ["信息化", 2], ["智能化", 3], ["节能及维保", 4]]
    a = ary.select{|v| v[1] == n}.first
    id = Category.where("name like ?", "%#{a[0]}%").first.try(:id)
    return "/projects/case_list?cat=#{id}"
  end


end
