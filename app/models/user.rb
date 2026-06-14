class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :secret, presence: true, uniqueness: true

  enum :role, { member: 0, admin: 1, viewer: 2, superadmin: 3 }, default: :member
end
