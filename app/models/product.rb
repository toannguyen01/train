class Product < ApplicationRecord	
	validates :title, :description, :price, presence: true	
	validate :title_is_shorter_than_description	
	validates_numericality_of :price, greater_than: 0	
	scope :published, -> { where(published: true) }	

	before_save :strip_html_from_description, :downcase_fields

	def strip_html_from_description
		self.description =
		ActionView::Base.full_sanitizer.sanitize(self.description)
	end

	def downcase_fields
	  self.title = title.downcase
	end

	def title_is_shorter_than_description		
		return if title.blank? or description.blank?		
		if description.length < title.length			
			errors.add(:description, 'can\'t be shorter than title')		
		end	

	end
end