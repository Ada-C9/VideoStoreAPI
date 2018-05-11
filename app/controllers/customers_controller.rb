class CustomersController < ApplicationController
  def index
    customers = Customer.all
    # render json: { message: "What's up yall?" }

    render :json => customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count]), status: :ok

  end

  def show
  end

  def update
  end

  def create
  end

  def destroy
  end

  def new
  end

  def edit
  end
end
