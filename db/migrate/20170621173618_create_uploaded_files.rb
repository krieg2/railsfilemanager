class CreateUploadedFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :uploaded_files do |t|
      t.string :filename
      t.integer :size

      t.timestamps
    end
  end
end
