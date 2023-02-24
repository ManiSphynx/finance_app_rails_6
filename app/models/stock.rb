class Stock < ApplicationRecord
  def self.new_lookup(_ticker_symbol)
    client = IEX::Api::Client.new(publishable_token: Rails.application.credentials.iex_client[:publishable_api_key],
                                  secret_token: Rails.application.credentials.iex_client[:secret_api_key],
                                  endpoint: 'https://cloud.iexapis.com/v1')

    client.quote(_ticker_symbol).latest_price
  end
end
