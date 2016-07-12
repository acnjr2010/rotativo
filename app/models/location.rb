class Location < ActiveRecord::Base
  geocoded_by :endereco
  after_validation :geocode
end
