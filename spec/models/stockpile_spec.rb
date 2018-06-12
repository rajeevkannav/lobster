require 'rails_helper'

RSpec.describe Stockpile, type: :model do

  # Validation Tests
  # ensure column name and price are present before saving
  describe '#stock_on_hand' do
    it { should validate_presence_of(:stock_on_hand)}
    it { should validate_numericality_of(:stock_on_hand).is_greater_than_or_equal_to(0) }

  end

  describe '#stock_on_reserve' do
    it { should validate_presence_of(:stock_on_reserve) }
    it { should validate_numericality_of(:stock_on_reserve).is_greater_than_or_equal_to(0) }
  end

  # Associations Tests
  describe "#product" do
    it { should belong_to(:product) }
  end

  describe "#warehouse" do
    it { should belong_to(:warehouse) }
  end

  before do
    @warehouse  = Warehouse.create(name: Faker::Address.city)
    @product  = Product.create(name: Faker::Lorem.word, price: Faker::Number.decimal(2))
  end

  # do_account
  describe "#do_account" do
    context "When kind#add" do
      it "stock_on_hand should be incremented by 50" do
        @stockpile = @warehouse.stockpiles.find_or_create_by(product_id: @product.id)
        stock_on_hand = @stockpile.stock_on_hand
        @stockpile.do_account(kind: 'add', quantity: 50)
        expect(@stockpile.stock_on_hand).to eql(stock_on_hand + 50)
      end
    end

    context "When kind#remove quantity is more than stock on hand" do
      it "should raise an exception" do
        @stockpile = @warehouse.stockpiles.find_or_create_by(product_id: @product.id)
        expect {@stockpile.do_account(kind: 'remove', quantity: 50)}.to raise_error(ActiveRecord::RecordInvalid,'Validation failed: Stock on hand must be greater than or equal to 0')
      end
    end

    context "When kind#remove quantity is less than Or equal to stock on hand" do
      it "should decrement the value of stock_on_hand" do
        @stockpile = @warehouse.stockpiles.find_or_create_by(product_id: @product.id, stock_on_hand: 50)
        @stockpile.do_account(kind: 'remove', quantity: 50)
        expect(@stockpile.stock_on_hand).to eql(0)
      end
    end

    context "When kind#reserve quantity is more than stock on hand" do
      it "should raise an exception" do
        @stockpile = @warehouse.stockpiles.find_or_create_by(product_id: @product.id)
        expect {@stockpile.do_account(kind: 'reserve', quantity: 50)}.to raise_error(ActiveRecord::RecordInvalid,'Validation failed: Stock on hand must be greater than or equal to 0')
      end
    end

    context "When kind#remove quantity is less than Or equal to stock on hand" do
      it "should decrement the value of stock_on_hand and incrrment the value of stock_on_reserve" do
        @stockpile = @warehouse.stockpiles.find_or_create_by(product_id: @product.id, stock_on_hand: 50)
        @stockpile.do_account(kind: 'reserve', quantity: 50)
        expect(@stockpile.stock_on_hand).to eql(0)
        expect(@stockpile.stock_on_reserve).to eql(50)
      end
    end

    context "When kind#ship quantity is more than stock on reserve" do
      it "should raise an exception" do
        @stockpile = @warehouse.stockpiles.find_or_create_by(product_id: @product.id)
        expect {@stockpile.do_account(kind: 'ship', quantity: 50)}.to raise_error(ActiveRecord::RecordInvalid,'Validation failed: Stock on reserve must be greater than or equal to 0')
      end
    end

    context "When kind#remove quantity is less than Or equal to stock on hand" do
      it "should decrement the value of stock_on_reserve" do
        @stockpile = @warehouse.stockpiles.find_or_create_by(product_id: @product.id, stock_on_reserve: 50)
        @stockpile.do_account(kind: 'ship', quantity: 50)
        expect(@stockpile.stock_on_reserve).to eql(0)
      end
    end

  end
end
