class Location < ActiveRecord::Base
  has_many :votes

  obfuscate_id
end
