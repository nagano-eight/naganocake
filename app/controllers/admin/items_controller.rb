class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    @genres = Genre.all # ジャンルのセレクトボックス用
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item), notice: "商品を登録しました！"
    else
      @genres = Genre.all # 失敗した時にもジャンル一覧が必要
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :genre_id, :is_active, :image)
  end

end
