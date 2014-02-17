module Sinatra

  module GetOrPostHandler

    def get_or_post(path, opts={}, &block)
      get(path, opts, &block)
      post(path, opts, &block)
    end

  end

  register GetOrPostHandler

end


