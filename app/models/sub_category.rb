#encoding:utf-8
class SubCategory < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :category
  validates_presence_of :name, :message => "名称不能为空"
  validates_presence_of :category_id, :message => "一级分类不能为空"

  def name_valid?
    unless self.category_id.blank?
      if self.id.blank?
        c = SubCategory.where("category_id = ? and name = ?", self.category_id, self.name)
      else
        c = SubCategory.where("category_id = ? and name = ? and id != ?", self.category_id, self.name, self.id)
      end
      self.errors.add(:name, "该分类下已经存在这个名称了") unless c.blank?
    end
    self.errors[:name].blank?
  end

end
