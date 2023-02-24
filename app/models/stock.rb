class Stock < ApplicationRecord
  # Asociations
  has_many :user_stocks
  has_many :users, through: :user_stocks

  # Validations
  validates :name, :ticker, presence: true

  # Method definitions
  def self.new_lookup(_ticker_symbol)
    client =
      IEX::Api::Client.new(
        publishable_token:
          Rails.application.credentials.iex_client[:publishable_api_key],
        secret_token: Rails.application.credentials.iex_client[:secret_api_key],
        endpoint: "https://cloud.iexapis.com/v1"
      )

    begin
      new(
        ticker: _ticker_symbol,
        name: client.company(_ticker_symbol).company_name,
        last_price: client.quote(_ticker_symbol).latest_price
      )
    rescue => exception
      return nil
    end
  end
end
