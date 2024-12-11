class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def new
    @board = Board.new
  end

  def create
    board = Board.create(board_params) # 引数に保存するパラメーターを渡すことでDBに保存できる。
    redirect_to board # データ作成時点でidが付与されているため、参照している。
  end

  def show
    @board = Board.find(params[:id])
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    board = Board.find(params[:id])
    board.update(board_params)

    redirect_to board
  end

  def destroy
    board = Board.find(params[:id])
    board.destroy

    redirect_to boards_path
  end

  private

  def board_params
    params.require(:board).permit(:author_name, :title, :body) # paramsの中のboardキーの中のauthor_name, title, bodyの値のみを取得できる。
  end
end