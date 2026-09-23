class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all

    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.where(is_active: true)
    else
      @items = Item.where(is_active: true)
    end
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
  end
end
