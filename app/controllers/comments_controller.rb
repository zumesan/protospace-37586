class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params) #保存するデータをインスタンス変数に代入する
    if @comment.save #データが保存されたとき、下記を実行
      redirect_to prototype_path(id:current_user) #show.html.erbを表示
    else
      @prototype = @comment.prototype
      @comments = @prototype.comment
      render "prototypes/show" #保存できなかった時、renderメソッドでprototypes/show.html.erb（新規投稿ページ）を表示
    end
  end



  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id:params[:prototype_id])
  end
end
