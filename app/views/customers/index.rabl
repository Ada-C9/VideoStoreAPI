collection @customers
attributes :id, :name, :phone, :postal_code, :registered_at
node(:movies_checked_out_count) { |customer| customer.movies_checked_out_count }
