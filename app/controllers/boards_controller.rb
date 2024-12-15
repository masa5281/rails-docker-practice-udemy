class BoardsController < ApplicationController
  before_action :set_target_board, only: %i[show edit update destroy]

  def index
    # 渡されてくるパラメーターのハッシュにtag_idの値がある場合は、そのタグ情報をTagモデルから取得し、それに紐づいている掲示板一覧を取得する。
    # もしtag_idの値がnilだった場合は掲示板を全件取得する。
    # @boardsの中身が参照されるまでDBのアクセスは行われない。
    @boards = params[:tag_id].present? ? Tag.find(params[:tag_id]).boards : Board.all
    @boards = @boards.page(params[:page])

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
      flash[:board] = board # flashでboardオブジェクトを返すことで、newメソッドで入力されたままの値で保持される。
      flash[:error_messages] = board.errors.full_messages # エラーがあるとerrorsにエラーオブジェクトが格納され、full_messagesで見やすい形で配列にする。
      redirect_back fallback_location: new_board_path
    end
  end

  def show
    @comment = Comment.new(board_id: @board.id)
  end

  def edit
  end

  def update
    if @board.update(board_params) 
      redirect_to @board
    else
      flash[:board] = @board
      flash[:error_messages] = @board.errors.full_messages
      redirect_back fallback_location: @board
    end
  end

  def destroy
    @board.destroy
    redirect_to boards_path, flash: { notice: "「#{@board.title}」の掲示板が削除されました" }
  end

  private

  def board_params
    # paramsの中のboardキーの中のauthor_name, title, bodyの値のみを取得できる。
    # tag_ids → 複数のIDが渡されるので配列の形式で渡す。
    params.require(:board).permit(:author_name, :title, :body, tag_ids: [])
  end

  def set_target_board
    @board = Board.find(params[:id])
  end
end