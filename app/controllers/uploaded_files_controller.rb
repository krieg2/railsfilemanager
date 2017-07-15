class UploadedFilesController < ApplicationController

  before_action :authorize

  def index
    @user_account = UserAccount.find(params[:user_account_id])
    @uploaded_files = @user_account.uploaded_files.order(filename: :desc).all
  end

  def new
    @user_account = UserAccount.find(params[:user_account_id])
    @uploaded_file = UploadedFile.new(:user_account => @user_account)
  end

  def create
    @user_account = UserAccount.find(params[:user_account_id])
    fileUpload = params[:uploaded_file][:file_to_upload]

    # Ensure that uploaded_file is not nil.
    if fileUpload != nil

      uploaded_filename = fileUpload.original_filename

      # Add timestamp to filename for uniqueness.
      t = Time.now
      ts = t.strftime("%y%m%d%H%M%S")

      @uploaded_file = UploadedFile.new(uploaded_file_params)
      @uploaded_file.user_account = @user_account
      @uploaded_file.filename = uploaded_filename
      @uploaded_file.size = fileUpload.size
      @uploaded_file.savetime = ts

      if @uploaded_file.save

        filename = file_name(uploaded_filename, @user_account.id, ts)

        if not File.exist?(filename)
          File.open(filename, 'wb') do |file|
            file.write(fileUpload.read)
          end
        end
        
        @uploaded_files = @user_account.uploaded_files.order(filename: :desc).all
        render :index
      else

        render :new
      end

    else

      # No file was selected, uploaded_file is nil.
      @uploaded_file = UploadedFile.new(:user_account => @user_account)
      @uploaded_file.errors.add(:base, "No file chosen")
      render :new
    end
  end

  def show
  end

  def download
    @user_account = UserAccount.find(params[:user_account_id])
    @uploaded_file = @user_account.uploaded_files.find(params[:id])
    filename = file_name(@uploaded_file.filename,
                         @user_account.id,
                         @uploaded_file.savetime)

    send_file(filename,
              filename: @uploaded_file.filename,
              disposition: 'attachment' )
   end

  def destroy
    @user_account = UserAccount.find(params[:user_account_id])
    id = params[:id]
    @uploaded_file = @user_account.uploaded_files.find(id)

    filename = file_name(@uploaded_file.filename,
                         @user_account.id,
                         @uploaded_file.savetime)

    File.delete(filename) if File.exist?(filename)
    @uploaded_file.destroy

    redirect_to user_account_uploaded_files_path(@user_account)
  end

  def search
    @user_account = UserAccount.find(params[:user_account_id])
    term = params[:term]
    searchTerm = "%#{term}%"
    @uploaded_files = @user_account.uploaded_files.where("filename like ?", searchTerm)
    render :index
  end

  private

  # Construct a unique filename given the original filename,
  # user account, and a timestamp. i.e. "8.170708141436_Test.pdf"
  # Set the path to the root/public/uploads directory.
  def file_name (filename, user_account_id, timestamp)
    filename =  "#{user_account_id}.#{timestamp}_#{filename}"
    Rails.root.join('public', 'uploads', filename)
  end

  def uploaded_file_params
    params.require(:uploaded_file).permit(:description)
  end
end
