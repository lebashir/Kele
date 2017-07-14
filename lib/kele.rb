require 'httparty'
require 'json'

class Kele
  include HTTParty
  include JSON

  def initialize(email, password)
    @base_url = "https://www.bloc.io/api/v1"
    response = self.class.post('https://www.bloc.io/api/v1/sessions', body: { email: email, password: password} )
    raise "invalid email/password" if response.code != 200
    @auth_token = response["auth_token"]
  end

  def get_me
    response = self.class.get('https://www.bloc.io/api/v1/users/me', headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end
end
