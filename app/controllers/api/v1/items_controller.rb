class Api::V1::ItemsController < ApiController
  def index
    items = Item.includes(:photos, :specs, :item_categories, :categories).all
    render json: items, only: [:id, :name, :price]
  end

  def show
    item = Item.includes(:photos, :specs, :item_categories, :categories).find(params[:id])
    specs = item.specs

    result_item = {}
    result_item[:id] = item.id
    result_item[:name] = item.name
    result_item[:price] = item.price
    result_item[:description] = item.description
    include_photos = []    
    item.photos.each do |photo|
      pic = {}
      pic[:image_url] = photo.image.medium.url
      pic[:photo_intro] = photo.photo_intro
      include_photos << pic
    end
    result_item[:photos] = include_photos

    include_specs = []
    specs.each do |spec|
      spec_hash = {}
      spec_hash[:id] = spec.id
      spec_hash[:style] = spec.style
      spec_hash[:amount] = spec.style_amount
      spec_hash[:pic] = spec.style_pic.url
      include_specs << spec_hash
    end
    result_item[:specs] = include_specs
    
    render json: result_item
  end
end