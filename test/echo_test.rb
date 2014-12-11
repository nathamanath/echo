require File.expand_path '../test_helper.rb', __FILE__

class EchoTest < MiniTest::Unit::TestCase

  include Rack::Test::Methods

  def app
    App
  end

  def test_get_params
    get "/echo?status=#{status}&body=#{body}&headers[#{header[:key]}]=#{header[:value]}"

    assert_equal status, last_response.status
    assert_equal body, last_response.body
    assert_equal header[:value], last_response.headers[header[:key]]
  end

  # same for array of verbs, test url params, and json
  ['post', 'delete', 'put', 'patch'].each do |meth|
    # url params
    define_method "test_#{meth}_url_encoded" do
      self.send(meth, "/echo", params) do
        assert_equal status, last_response.status
        assert_equal body, last_response.body
        assert_equal header[:value], last_response.headers[header[:key]]
      end
    end

    # json params
    define_method "test_#{meth}_json" do
      self.send(meth, "/echo", params.to_json, headers) do
        assert_equal status, last_response.status
        assert_equal body, last_response.body
        assert_equal header[:value], last_response.headers[header[:key]]
      end
    end
  end

  def test_post_json_with_json_body
    post "/echo", {body: json_body}.to_json, headers
    assert_equal json_body, last_response.body
  end

private

  def status
    201
  end

  def body
    "blalalala"
  end

  def json_body
    {nathan: 'awesome'}.to_json
  end

  def header
    {
      key: "Content-Type",
      value: "application/json"
    }
  end

  def params
    {
      status: status,
      body: body,
      headers: { header[:key] => header[:value] }
    }
  end

  def headers
    { 'CONTENT_TYPE' => 'application/json' }
  end
end

