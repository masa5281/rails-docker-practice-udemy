class BoardsController < ApplicationController
  before_action :set_target_board, only: %i[show edit update destroy]

  def index
    @boards = Board.page(params[:page])
  end

  def new
    @board = Board.new(flash[:board])
  end

  def create
    board = Board.new(board_params) # 引数に保存するパラメーターを渡すことでDBに保存できる。
    if board.save # この時点でバリデーションが検証される
      flash[:notice] = "「#{board.title}」の掲示板を作成しました" # flashの任意のキーの値のデータが、次に参照されるまでセッションに保存される。
      redirect_to board # データ作成時点でidが付与されているため、参照している。
    else
      redirect_to new_board_path, flash: {
        board: board, # flashでboardオブジェクトを返すことで、newメソッドで入力されたままの値で保持される。
        error_message: board.errors.full_messages # エラーがあるとerrorsにエラーオブジェクトが格納され、full_messagesで見やすい形で配列にする。
      }
    end
  end

  def show
  end

  def edit
  end

  def update
    @board.update(board_params)
    redirect_to @board
  end

  def destroy
    @board.destroy
    redirect_to boards_path, flash: { notice: "「#{@board.title}」の掲示板が削除されました" }
  end

  private

  def board_params
    params.require(:board).permit(:author_name, :title, :body) # paramsの中のboardキーの中のauthor_name, title, bodyの値のみを取得できる。
  end

  def set_target_board
    @board = Board.find(params[:id])
  end
end