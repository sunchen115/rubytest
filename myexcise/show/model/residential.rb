require_relative './data_reader'

class Residential < ActiveRecord::Base
  self.table_name = "Residential"

  class << self
    def get_top5
    # ActiveRecord::Base.connection_pool.with_connection do |conn|
        data = select("PropertyNumber").limit(5).to_a

        #close_connect
    #   end
    end
  end
end