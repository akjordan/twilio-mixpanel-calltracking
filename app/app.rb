require 'sinatra'
require 'extensions/get_or_post'
require 'helpers/log_request_params'

#load config
config_file 'config.yml'

#Initialize Mixpanel Tracker with project_token stored in config.yml
tracker = Mixpanel::Tracker.new(settings.mixpanel_project_token)

#You should point the VoiceURL of your Twilio number to www.appdomain.com/
get_or_post("/") do

  # build up a TwiML response using the twilio-ruby library
  response = Twilio::TwiML::Response.new do |r|
    r.Dial :record => "true", :action => "/callback", :timeout => "10" do |d|
    #If you want to use a whisper, uncomment this line and delete the other
    #d.Number settings.agent_number, :url => "/whisper"
      d.Number settings.agent_number
    end
  end

  # print the result to render the TwiML
  return response.text

end

#This route captures the post from the action callback and updates Mixpanel
get_or_post("/callback") do

  #This logs every incoming param from the Twilio request into a Mixpanel tracker
  if params['CallSid'] != ''
    tracker.track(params['CallSid'], 'Incoming Call', { 'AccountSid' => params['AccountSid'], 'From' => params['From'], 'To' => params['To'],
      'CallStatus' => params['CallStatus'], 'ApiVersion' => params['ApiVersion'], 'Direction' => params['Direction'], 
      'ForwardedFrom' => params['ForwardedFrom'], 'CallerName' => params['CallerName'], 'FromCity' => params['FromCity'], 
      'FromState' => params['FromState'], 'FromZip' => params['FromZip'], 'FromCountry' => params['FromCountry'], 'ToCity' => params['ToCity'],
      'ToState' => params['ToState'], 'ToZip' => params['ToZip'], 'ToCountry' => params['ToCountry']
    })
  end

  response = Twilio::TwiML::Response.new

  return response.text

end

#This defines the optional whisper your agent will hear when they pick up
get_or_post('/whisper') do

  response = Twilio::TwiML::Response.new do |r|
    r.Pause :length => '1'
    r.Say 'This call provided by Twilio', :voice => 'woman'
  end

  return response.text

end