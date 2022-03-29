class DocumentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @documents = current_user.documents
  end

  def show
    @document = current_user.documents.find(params[:id])
  end

  def show_insecure
    @document = Document.find(params[:id])
    render "show"
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    @document.user = current_user

    if @document.save
      redirect_to @document
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @document = current_user.documents.find(params[:id])
  end

  def update
    @document = current_user.documents.find(params[:id])
    
    if @document.update(document_params)
      redirect_to @document
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @document = current_user.documents.find(params[:id])
    @document.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def document_params
      params.require(:document).permit(:from, :date, :identifier, :reference,
                                       :description, :total, :document_type)
    end
end
