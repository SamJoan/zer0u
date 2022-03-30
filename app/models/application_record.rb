class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  SET_CUSTOMER_ID_SQL = 'SET rls.customer_id = %s'.freeze
  RESET_CUSTOMER_ID_SQL = 'RESET rls.customer_id'.freeze
  def self.with_customer_id(customer_id, &block)
    begin
      connection.execute format(SET_CUSTOMER_ID_SQL, connection.quote(customer_id))
      block.call
    ensure
      connection.execute RESET_CUSTOMER_ID_SQL
    end
  end
end
