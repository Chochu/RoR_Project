require 'test_helper'

class IdStockControllerTest < ActionDispatch::IntegrationTest
  test "should get SecurityMaster" do
    get id_stock_SecurityMaster_url
    assert_response :success
  end

  test "should get Exchange" do
    get id_stock_Exchange_url
    assert_response :success
  end

  test "should get Summary" do
    get id_stock_Summary_url
    assert_response :success
  end

  test "should get TopGainer" do
    get id_stock_TopGainer_url
    assert_response :success
  end

  test "should get TopLoser" do
    get id_stock_TopLoser_url
    assert_response :success
  end

end
