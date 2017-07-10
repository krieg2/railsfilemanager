class UploadedFile < ApplicationRecord
  validates :user_account_id, :filename, :savetime, presence: true

  belongs_to :user_account
end
