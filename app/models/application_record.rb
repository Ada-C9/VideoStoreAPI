class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.request_query(params, model)
    a = params[:sort]
    b = params[:p].to_i
    c = params[:n].to_i
    customers = model.all
    acceptable = model.new.attributes.keys
    customers = customers.order(a) if acceptable.include?(a)
    customers = customers.to_a

    if b > 0 || c > 0
      b = 1 if b == 0
      c = 10 if c == 0

      start = ( b - 1 ) * c
      finish = start + c

      customers = customers[start...finish]
    end

    return customers
  end
end
