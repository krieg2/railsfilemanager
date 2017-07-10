class UserAccount < ApplicationRecord
  validates :firstname, :lastname, :email,
            :password, presence: true
  validates :email, uniqueness: true, on: :create
  #validates :password, length: { minimum: 8 }
  validates_format_of :email, :with => /\A[\w]+@[\w]+\.+[\w]+\z/

  has_many :uploaded_files
end
