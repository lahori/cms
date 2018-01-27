require 'test_helper'

class PoolConfigurationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pool_configuration = pool_configurations(:one)
  end

  test "should get index" do
    get pool_configurations_url
    assert_response :success
  end

  test "should get new" do
    get new_pool_configuration_url
    assert_response :success
  end

  test "should create pool_configuration" do
    assert_difference('PoolConfiguration.count') do
      post pool_configurations_url, params: { pool_configuration: {  } }
    end

    assert_redirected_to pool_configuration_url(PoolConfiguration.last)
  end

  test "should show pool_configuration" do
    get pool_configuration_url(@pool_configuration)
    assert_response :success
  end

  test "should get edit" do
    get edit_pool_configuration_url(@pool_configuration)
    assert_response :success
  end

  test "should update pool_configuration" do
    patch pool_configuration_url(@pool_configuration), params: { pool_configuration: {  } }
    assert_redirected_to pool_configuration_url(@pool_configuration)
  end

  test "should destroy pool_configuration" do
    assert_difference('PoolConfiguration.count', -1) do
      delete pool_configuration_url(@pool_configuration)
    end

    assert_redirected_to pool_configurations_url
  end
end
