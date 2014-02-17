module Sinatra
  
  module LogRequestParamsHelper
    
    def log_request_params
      timestamp = Time.now.strftime("%H:%M:%S")
      if params.length > 0
        puts "=== #{request.request_method} REQUEST at #{timestamp}==="
        params.each {|k, v| puts "#{k} : #{v}"}
        puts "=== END REQUEST ==="
      else
        puts "=== #{request.request_method} REQUEST with no params at #{timestamp}"
      end
    end

  end

  helpers LogRequestParamsHelper

end