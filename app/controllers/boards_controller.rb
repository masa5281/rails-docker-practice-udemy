class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def new
    @board = Board.new
  end

  def create
    Board.create(board_params) # 引数に保存するパラメーターを渡すことでDBに保存できる。
  end

  private

  def board_params
    params.require(:board).permit(:author_name, :title, :body) # paramsの中のboardキーの中のauthor_name, title, bodyの値のみを取得できる。
  end
end