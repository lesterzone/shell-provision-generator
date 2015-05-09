class Platform < ActiveRecord::Base

  validates :name, presence: true
  validates :name, length: { in: 2..250 }

  validates :version, presence: true

  validates :install_command, presence: true

  has_many :packages

  def self.search(criteria)
    self.where("name ilike ?", "%#{criteria}%").
      select(:id, :name, :version, :codename)
  end
end
