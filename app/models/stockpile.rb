class Stockpile < ApplicationRecord

  # Validations
  validates :available, :numericality => { :greater_than_or_equal_to => 0 }
  validates :reserved, :numericality => { :greater_than_or_equal_to => 0 }
  validates :shipped, :numericality => { :greater_than_or_equal_to => 0 }

  # Associations
  belongs_to :product
  belongs_to :warehouse


  def do_account(kind:, quantity:)
    with_lock do
      case kind
      when 'add'
        self.stock_on_hand += quantity
      when 'remove'
        self.stock_on_hand -= quantity
      when 'reserve'
        self.stock_on_hand -= quantity
        self.stock_on_reserve += quantity
      when 'ship'
        self.stock_on_reserve -= quantity
      end
      save!
    end
  end
end
