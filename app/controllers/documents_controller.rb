class DocumentsController < ApplicationController
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

  private
    def document_params
      params.require(:document).permit(:from, :date, :identifier, :reference,
                                       :description, :total, :type)
    end
end
