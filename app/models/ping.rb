class Ping < ActiveRecord::Base
  attr_accessible :counter, :mark_for_deletion, :url
end
