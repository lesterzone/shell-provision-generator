class Package < ActiveRecord::Base

  attr_accessor :platform_search

  belongs_to :platform

  validates :name, presence: true
  validates :name, length: { in: 2..250 }

  validates :version, presence: true

  validates :install, presence: true
  validates :platform_id, presence: true

  def self.search(criteria, platform)
    self.where("name ilike ? AND platform_id = ?", "%#{criteria}%", platform).
      select(:id, :name, :version, :install)
  end
end
