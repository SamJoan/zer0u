class Document < ApplicationRecord
  enum type: [ :bill, :invoice ] 
end
