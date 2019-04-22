class Movie < ApplicationRecord
  acts_as_paranoid

  has_many :scores, as: :scorable
end
