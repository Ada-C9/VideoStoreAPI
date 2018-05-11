collection @customers

attributes :id, :name, :phone, :postal_code
attribute :created_at => :registered_at

node (:movies_checked_out_count) { |customer| customer.checkedout }
