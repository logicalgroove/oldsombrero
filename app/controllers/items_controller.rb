class ItemsController < ApplicationController
  before_filter :restrict_to_owner, :only => [:update, :destroy]
  before_filter :rescue_empty_tag_params, :only => [:create, :update]
  before_filter :find_or_create_tags, :only => [:create, :update]
  # GET /items
  # GET /items.json
  def index
    @items = Item.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html do
          flash[:alert] = 'Something went wrong while creating an item.'
          render action: "new"
        end
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, notice: "#{@item.name} was successfully updated." }
        format.json { head :no_content }
      else
        format.html do
          flash[:alert] = 'Something went wrong while updating an item.'
          render action: "edit"
        end
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end

  public

    def restrict_to_owner
      unless current_user.owns?(params[:id])
        redirect_to root_path
      end
    end

    def rescue_empty_tag_params
      params[:item][:tag_names] = params[:item][:tag_names] ? params[:item][:tag_names] : ''
    end

    def find_or_create_tags
      params[:item][:tag_ids] = Tag.find_or_create_tags(params[:item][:tag_names])
    end

end
