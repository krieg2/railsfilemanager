class AddDescriptionToUploadedFile < ActiveRecord::Migration[5.1]
  def change
    add_column :uploaded_files, :description, :string
  end
end
