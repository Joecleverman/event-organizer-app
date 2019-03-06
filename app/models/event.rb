class Event < ActiveRecord::Base
    belongs_to :user
    has_many :attenders, dependent: :destroy
    has_many :contractors, dependent: :destroy
  
    validates_presence_of :name
  
    def formatted_date
      self.date.strftime("%A %B %e, %Y")
    end
  
    def confirmed_attenders
      self.attenders.select {|attender| attender.rsvp }
    end
  
    def total_contractor_cost
      self.contractors.inject(0){|sum, contractor| sum + contractor.cost }
    end
  
    def avg_contractor_cost
      unless self.contractors.count == 0
        total_contractor_cost / self.contractors.count
      end
    end
  
  end