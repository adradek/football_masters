class Visit < ApplicationRecord
  belongs_to :user, optional: true
end
