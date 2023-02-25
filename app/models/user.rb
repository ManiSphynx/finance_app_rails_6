class User < ApplicationRecord
  # Asociations
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  # Method definitions

  def under_stock_limit?
    stocks.count < 10
  end

  def stock_already_tracked?(_ticker_symbol)
    stock = Stock.check_db(_ticker_symbol)
    return false unless stock

    stocks.where(id: stock.id).exists?
  end

  def can_track_stock?(_ticker_symbol)
    under_stock_limit? && !stock_already_tracked?(_ticker_symbol)
  end

  def full_name
    return "#{first_name} #{last_name}".strip if (first_name || last_name)

    "Anonymous"
  end

  def self.search(param)
    param.strip!
    to_send_back =
      (
        first_name_matches(param) + last_name_matches(param) +
          email_matches(param)
      ).uniq
    return nil unless to_send_back

    to_send_back
  end

  def self.first_name_matches(param)
    matches("first_name", param)
  end

  def self.last_name_matches(param)
    matches("last_name", param)
  end

  def self.email_matches(param)
    matches("email", param)
  end

  def self.matches(field_name, param)
    where("lower(#{field_name}) like ?", "%#{param.downcase}%")
  end

  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end

  def not_friends_with?(friend_id)
    !self.friends.where(id: friend_id).exists?
  end
end
