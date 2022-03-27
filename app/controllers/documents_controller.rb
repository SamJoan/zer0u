class DocumentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @documents = Document.all
  end

  def show
    @document = Document.find(params[:id])
  end

  def new
    @document = Document.new
  end

  def create
    @document =  Document.new(document_params)

    if @document.save
      redirect_to @document
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @document = Document.find(params[:id])
  end

  def update
    @document = Document.find(params[:id])
    
    if @document.update(document_params)
      redirect_to @document
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def document_params
      params.require(:document).permit(:from, :date, :identifier, :reference,
                                       :description, :total, :document_type)
    end
end
