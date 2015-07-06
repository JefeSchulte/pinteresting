class Pin < ActiveRecord::Base
	belongs_to :user
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  	validates :description, presence: true
	validates :image, presence: true

	#adding this to the file in response to an error in production.
	#Paperclip::Error (Pin model missing required attr_accessor for 'image_file_name'):
	#Commenting this out for now to see if this helps fix the problem of image file names not loading.
	#attr_accessor :image_file_name
	

end