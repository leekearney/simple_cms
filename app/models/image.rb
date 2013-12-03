require 'position_mover'
class Image < ActiveRecord::Base

  include PositionMover

   #attr_accessible :title, :body
  belongs_to :page
  has_many :images
  #has_many :editors, :through => :section_edits, :class_name => "AdminUser"

  

end