class PrototypesController < ApplicationController
  before_action :authenticate_user! #ログインしていないユーザーを、ログイン画面に戻す

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params) #保存するデータをインスタンス変数に代入する
    if @prototype.save #データが保存されたとき、下記を実行
      redirect_to root_path #ルートパスへ飛ぶ
    else
      render :new #保存できなかった時、renderメソッドでprototypes/new.html.erb（新規投稿ページ）を表示
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = Comment.all
  end

  def edit
    unless user_signed_in?
      redirect_to action: :index
    end
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype) #ビューファイルで表示するため、引数でインスタンス変数を渡す
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    if prototype.destroy
      redirect_to root_path
    end
  end


  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)

  end
end