class Users::PasswordsController < ApplicationController
  def edit
  end

  def update
    @user = current_user
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    respond_to do |format|
      if @user.valid? && @user.save
        format.html { redirect_to root_path, notice: 'User was successfully created.' }
        format.json { render :edit, status: :created, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

end
