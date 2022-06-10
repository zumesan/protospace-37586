class UsersController < ApplicationController

  def show
    @user = User.find(params[:id]) #Usersテーブルの特定のユーザーの情報を、@userに代入
    @prototype = Prototype.all
  end

end