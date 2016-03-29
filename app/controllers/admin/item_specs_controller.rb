class Admin::ItemSpecsController < AdminController
  before_action :find_item
  before_action :find_spec, only: [:edit, :update, :destroy]

  def index
    @item_specs = @item.specs
  end

  def new
    @item_spec = @item.specs.new
  end

  def create
    # 多圖上傳
    begin
      create_spec_params[:images].each do |image|
        @item.specs.create!(style_pic: image)
      end
      flash[:notice] = "樣式圖片上傳完成"
      redirect_to admin_item_item_specs_path(@item)
    rescue Exception => e
      flash.now[:alert] = "請確認上傳圖片是否正確"
    end

    # 單張圖
    # @item_spec = @item.specs.new(spec_params)

    # if @item_spec.save!
    #   flash[:notice] = "成功新增樣式"
    #   redirect_to admin_item_item_specs_path(@item)
    # else
    #   flash[:alert] = "請確認所有欄位資料是否正確"
    #   render :new
    # end
  end

  def edit
  end

  def update
    @item_spec.update!(update_spec_params)

    respond_to do |format|
      format.html do
        if @item_spec.valid?
          flash[:notice] = "編輯完成"
          redirect_to admin_item_item_specs_path(@item)
        else
          flash.now[:alert] = "請確認編輯內容是否正確"
          render :edit
        end
      end

      format.js
    end
  end

  def destroy
  end

  private

  def find_item
    @item = Item.includes(:specs).find(params[:item_id])
  end

  def find_spec
    @item_spec = @item.specs.find(params[:id])
  end

  def create_spec_params
    params.require(:item_spec).permit(:style, :style_pic, :style_amount).merge!(images: params[:images])
  end

  def update_spec_params
    params.require(:item_spec).permit(:style, :style_pic, :style_amount)
  end
end