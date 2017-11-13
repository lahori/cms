class Appliance < ApplicationRecord
  belongs_to :system
  has_many :cpus, dependent: :destroy
  has_many :disks, dependent: :destroy
  has_many :enclosures, dependent: :destroy
  has_many :hbas, dependent: :destroy
  has_many :nics, dependent: :destroy
end