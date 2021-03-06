require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get orders_url, as: :json
    assert_response :success
  end

  test "should create orders" do
    assert_difference('Order.count') do
      post orders_url, params: { order: { purchase_channel: @order.purchase_channel, address: @order.address, line_items: @order.line_items, batch_id: @order.batch_id, cliente_name: @order.cliente_name, ref: @order.ref, status: @order.status, total_value: @order.total_value } }, as: :json
    end

    assert_response 201
  end

  test "should show order" do
    get order_url(@order), as: :json
    assert_response :success
  end

  test "should update order" do
    patch order_url(@order), params: { order: { purchase_channel: @order.purchase_channel, address: @order.address, line_items: @order.line_items, batch_id: @order.batch_id, cliente_name: @order.cliente_name, ref: @order.ref, status: @order.status, total_value: @order.total_value } }, as: :json
    assert_response 200
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete order_url(@order), as: :json
    end

    assert_response 204
  end
end
