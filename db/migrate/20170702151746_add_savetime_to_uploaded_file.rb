class AddSavetimeToUploadedFile < ActiveRecord::Migration[5.1]
  def change
    add_column :uploaded_files, :savetime, :string
  end
end
