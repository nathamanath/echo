require 'sinatra/base'

class App < Sinatra::Base

  def get_url_params_or_json
    if request.content_type == 'application/json'
      p = JSON.parse(request.body.read)
      Hash[p.map { |k, v| [k.to_sym, v] }]
    else
      params
    end
  end

  def set_cors_headers
    headers 'Access-Control-Allow-Methods' => 'GET, POST, PUT, PATCH, DELETE, OPTIONS',
            'Access-Control-Max-Age' => (10 * 60).to_s,
            'Access-Control-Allow-Headers' => 'Origin, Content-Type, Accept, Authorization, Token',
            'Access-Control-Allow-Origin' => '*'
  end

  before do
    @args = get_url_params_or_json
    set_cors_headers
  end

  # Do the echoing for listed verbs
  ['get', 'post', 'put', 'patch', 'delete'].each do |verb|
    self.send(verb, '/echo') do
      status @args[:status] || 200

      if @args[:headers]
        @args[:headers].each do |key, value|
          headers key => value
        end
      end

      @args[:body] || ''
    end
  end
end

