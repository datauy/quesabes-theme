
class IrekiaBridge
  def self.authenticate(req)
    user_id = MySociety::Config.get('IREKIA_BASE_AUTH_USER_ID', '')
    password = MySociety::Config.get('IREKIA_BASE_AUTH_PASSWORD', '')
    req.basic_auth user_id, password unless user_id.blank?
  end

  def self.connect(uri)
    # In case a proxy is needed (to use Charles for debugging), do:
    # proxy = Net::HTTP::Proxy('localhost', 8888)
    # proxy.start(uri.host, uri.port) do |http|
    Net::HTTP.start(uri.host, uri.port) do |http|
      yield(http)
    end
  end

  def self.send_message(outgoing_message, log_event_type)
    uri = URI(MySociety::Config.get('IREKIA_BASE_URL', '')+'questions.json')
    req = Net::HTTP::Post.new(uri.request_uri)
    req['Accept'] = 'application/json'
    req['Content-type'] = 'application/json'
    req['User-Agent'] = 'tuderechoasaber.es'  # can't be blank!

    area_id = outgoing_message.info_request.public_body.get_tag_values('area').first
    req.body = {
      # TODO: Move id/password to config file
      'user' => {
        'email' => MySociety::Config.get('IREKIA_USER_ID', ''),
        'password' => MySociety::Config.get('IREKIA_PASSWORD', '')
      },
      'question' => {
        'title' => outgoing_message.info_request.title, 
        'body' => outgoing_message.body, 
        'area_id' => area_id
      }
    # The target server doesn't handle the Rails encoding of accented characters in the output JSON.
    # See http://stackoverflow.com/questions/5123993/json-encoding-wrongly-escaped-rails-3-ruby-1-9-2
    }.to_json.gsub!(/\\u([0-9a-z]{4})/) {|s| [$1.to_i(16)].pack("U")}

    self.connect(uri) do |http|
      self.authenticate(req)
      response = http.request(req)
      # TODO: Check response code. Think of what to do

      # Parse response
      begin
        result = JSON.parse(response.body)
      rescue JSON::ParserError
        # TODO: We probably got HTML, think of best way to raise alert. Do nothing for now
      end

      # Log event
      outgoing_message.info_request.log_event('followup_' + log_event_type, {
        :area_id => area_id,
        :outgoing_message_id => outgoing_message.id,
        :response => response.body,
        :question_id => result && result['question']['id']
      })
    end
  end

  def self.get_response(request_id, question_id)
    uri = URI(MySociety::Config.get('IREKIA_BASE_URL', '')+"questions/#{question_id}.json")

    req = Net::HTTP::Get.new(uri.request_uri)
    req['Accept'] = 'application/json'
    req['Content-type'] = 'application/json'
    req['User-Agent'] = 'tuderechoasaber.es'  # can't be blank!
    
    self.connect(uri) do |http|
      self.authenticate(req)
      response = http.request(req)
      # TODO: Check response code. Think of what to do

      # Parse response
      begin
        result = JSON.parse(response.body)
        question = result['question']
      rescue JSON::ParserError
        # TODO: We probably got HTML, think of best way to raise alert. Do nothing for now
      end

      # Not approved yet: {"status":"pendiente"}
      # Approved but not answered: {"question":{"comments":[],"status":"aprobado","area_id":2,"answer_requests":1,"body":"...","id":186,"title":"..."}}
      # If answered, check answer.body
      if question and question['answer']
        puts "Got response '#{question['answer']['body']}' at #{question['answer']['answered_at']}"

        # Create a fake email with a minimal header and the fetched answer
        raw_email = "To: #{InfoRequest.magic_email_for_id('request-', request_id)}\n\n#{question['answer']['body']}"
        RequestMailer.receive(raw_email)
      else
        puts "Got no response so far"
      end
    end
  end
end
