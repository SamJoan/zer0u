class DocumentsController < ApplicationController
  before_action :authenticate_user!

  def index
    ApplicationRecord.with_customer_id(current_user.id) do	
      # This fails because the query is executed outside of the block.
      # @documents = current_user.documents

      # Cause records to be loaded from the DB (See: https://apidock.com/rails/ActiveRecord/Relation/load)
      @documents = current_user.documents.load
    end
  end

  def show
    ApplicationRecord.with_customer_id(current_user.id) do	
      @document = current_user.documents.find(params[:id])
    end
  end

  def show_insecure
    @document = Document.find(params[:id])
    render "show"
  end

  def show_insecure_two
    ApplicationRecord.with_customer_id(current_user.id) do	
      @document = Document.find(params[:id])
      render "show"
    end
  end

  def new
    ApplicationRecord.with_customer_id(current_user.id) do	
      @document = Document.new
    end
  end

  def create
    ApplicationRecord.with_customer_id(current_user.id) do	
      @document = Document.new(document_params)
      @document.user = current_user

      if @document.save
        redirect_to @document
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def edit
    ApplicationRecord.with_customer_id(current_user.id) do	
      @document = current_user.documents.find(params[:id])
    end
  end

  def update
    ApplicationRecord.with_customer_id(current_user.id) do	
      @document = current_user.documents.find(params[:id])
      
      if @document.update(document_params)
        redirect_to @document
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    ApplicationRecord.with_customer_id(current_user.id) do	
      @document = current_user.documents.find(params[:id])
      @document.destroy

      redirect_to root_path, status: :see_other
    end
  end

  private
    def document_params
      params.require(:document).permit(:from, :date, :identifier, :reference,
                                       :description, :total, :document_type)
    end
end
