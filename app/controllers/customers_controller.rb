class CustomersController < ApplicationController
  def index

    queries = {
      sort: params["sort"],
      n: params["n"],
      p: params["p"]
    }


    if queries[:sort]
      @customers = Customer.all
      @customers = @customers.order(queries[:sort])

      if queries[:p]
        if queries[:n]
          # IF BOTH P AND N
          start_index = ( queries[:p].to_i - 1 ) * queries[:n].to_i
          ending_index = start_index + queries[:n].to_i
          @customers = @customers[start_index...ending_index]

        else
          # IF ONLY P
          start_index = (queries[:p].to_i - 1) * 10
          ending_index = start_index + 10

          @customers = @customers[start_index...ending_index]

        end
      elsif queries[:n]
        # IF ONLY N
        start_index = 0
        ending_index = queries[:n].to_i

        @customers = @customers[start_index...ending_index]

      end

    else

      @customers = Customer.all

      if queries[:p]
        if queries[:n]
          # IF BOTH P AND N WITHOUT SORT
          start_index = ( queries[:p].to_i - 1 ) * queries[:n].to_i
          ending_index = start_index + queries[:n].to_i
          @customers = @customers[start_index...ending_index]

        else
          # IF ONLY P WITHOUT SORT
          start_index = (queries[:p].to_i - 1) * 10
          ending_index = start_index + 10

          @customers = @customers[start_index...ending_index]

        end
      elsif queries[:n]
        # IF ONLY N WITHOUT SORT
        start_index = 0
        ending_index = queries[:n].to_i

        @customers = @customers[start_index...ending_index]

      end

    end

    if @customers.empty?
      render json: {errors: {
        customer: ["No customers were found"]
      }
      }, status: :not_found

    else
      render 'index.json'
    end
  end

end
