class Provision < ActiveRecord::Base
  validates :script, presence: true
  validates :script, length: { in: 5..250 }

  validates :title, presence: true
end
