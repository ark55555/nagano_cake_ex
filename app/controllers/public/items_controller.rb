class Public::ItemsController < ApplicationController

  def top
    @items = Item.all
    @genres = Genre.all
  end

  def index
    @genres = Genre.all
    if params[:genre_id]
      @genre = @genres.find(params[:genre_id])
      @items = @genre.items.all
    else
      @items = Item.all
    end
  end

  def about
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

end
