class AddUserAccountRefToUploadedFiles < ActiveRecord::Migration[5.1]
  def change
    add_reference :uploaded_files, :user_account, foreign_key: true
  end
end
