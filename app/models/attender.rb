class Attender < ActiveRecord::Base
    belongs_to :event
    validates_presence_of :name
  
    def display
      if self.role == ""
        return self.name
      else
        return self.role + ": " + self.name
      end
    end
  end