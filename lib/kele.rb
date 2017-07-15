require 'httparty'
require 'json'
require './lib/roadmap.rb'

class Kele
  include HTTParty
  include JSON
  include Roadmap

  def initialize(email, password)
    @base_url = "https://www.bloc.io/api/v1"
    response = self.class.post('/sessions', body: { email: email, password: password} )
    raise "invalid email/password" if response.code != 200
    @auth_token = response["auth_token"]
  end

  def get_me
    response = self.class.get('/users/me', headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get('/mentors/#{mentor_id}/student_availability', headers: { "authorization" => @auth_token})
    JSON.parse(response.body)
  end

  def get_messages(page = nil)
    if page == nil
      response = self.class.get('/message_threads/', headers: { "authorization" => @auth_token })
    else
      response = self.class.get('/message_threads>page=#{page_num}', headers: { "authorization" => @auth_token })
    end
    JSON.parse(response.body)
  end

  def create_message(sender, recipient_id, subject, stripped-text)
    respose = self.class.get('/messages', body: { sender: sender, recipient_id: recipient_id, subject: subject, stripped-text: stripped-text}, headers: {"authorization" => @auth_token })
  end

  def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment, enrollment_id)
    response = self.class.get('/checkpoint_submission', body: { checkpoint_id: checkpoint_id, assignment_branch: assignment_branch, assignment_commit_link: assignment_commit_link, comment: comment, enrollment_id: enrollment_id }, header: { "authorization" => @auth_token })
  end
end
