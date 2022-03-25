class Document < ApplicationRecord
  validates :from, presence: true
  validates :date, presence: true
  validates :type, presence: true
  validates :total, presence: true
  enum type: [ :bill, :invoice ] 
end
