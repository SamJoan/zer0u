class Document < ApplicationRecord
  validates :from, presence: true
  validates :date, presence: true
  validates :document_type, presence: true
  validates :total, presence: true
  attribute :paid, default: false
  
  enum document_type: [ :bill, :invoice ] 
end
