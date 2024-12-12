class BoardsController < ApplicationController
  before_action :set_target_board, only: %i[show edit update destroy]

  def index
    @boards = Board.page(params[:page])
  end

  def new
    @board = Board.new
  end

  def create
    board = Board.create(board_params) # 引数に保存するパラメーターを渡すことでDBに保存できる。
    redirect_to board # データ作成時点でidが付与されているため、参照している。
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

    redirect_to boards_path
  end

  private

  def board_params
    params.require(:board).permit(:author_name, :title, :body) # paramsの中のboardキーの中のauthor_name, title, bodyの値のみを取得できる。
  end

  def set_target_board
    @board = Board.find(params[:id])
  end
end