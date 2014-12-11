require 'sinatra/base'

class App < Sinatra::Base

  AC_ALLOW_METHODS = 'GET, POST, PUT, PATCH, DELETE OPTIONS, LINK, UNLINK'
  AC_ALLOW_MAX_AGE = (10 * 60).to_s
  AC_ALLOW_ORIGIN = '*'
  AC_ALLOW_HEADERS = 'Origin, Content-Type, Accept, Authorization, Token'

  def get_url_params_or_json
    if request.content_type == 'application/json'
      p = JSON.parse(request.body.read)
      Hash[p.map { |k, v| [k.to_sym, v] }]
    else
      params
    end
  end

  def set_cors_headers
    headers 'Access-Control-Allow-Methods' => AC_ALLOW_METHODS,
            'Access-Control-Max-Age' => AC_ALLOW_MAX_AGE,
            'Access-Control-Allow-Headers' => AC_ALLOW_HEADERS,
            'Access-Control-Allow-Origin' => AC_ALLOW_ORIGIN
  end

  before do
    @args = get_url_params_or_json
    set_cors_headers
  end

  # handle preflight checks
  options '*' do
    ''
  end

  # Do the echoing for listed verbs
  ['get', 'post', 'put', 'patch', 'delete'].each do |verb|
    self.send(verb, '/echo') do
      set_cors_headers

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

