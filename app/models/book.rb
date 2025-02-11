# app/models/book.rb
class Book < ApplicationRecord
  has_many :borrowings
  has_many :users, through: :borrowings
end