class CustomersController < ApplicationController
  def index
    if params[:sort] == "name"
      customers = Customer.all.order(:name).paginate(page: params[:p], per_page: params[:n])
    elsif params[:sort] == "registered_at"
      customers = Customer.all.order(:registered_at).paginate(page: params[:p], per_page: params[:n])
    elsif params[:sort] == "postal_code"
      customers = Customer.all.order(:postal_code).paginate(page: params[:p], per_page: params[:n])
    else
      customers = Customer.all
    end
    render json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone])
  end
end
