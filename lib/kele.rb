require 'httparty'

class Kele
  include HTTParty

  def initialize(email, password)
    @base_url = "https://www.bloc.io/api/v1"
    response = self.class.post('https://www.bloc.io/api/v1/sessions', body: { email: email, password: password} )
    raise "invalid email/password" if response.code != 200
    @auth_token = response["auth_token"]
  end
end
