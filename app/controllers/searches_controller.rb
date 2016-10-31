class SearchesController < ApplicationController
  def search
  end

  def foursquare
    # making request to the api endpoint
    # we can pass in required params in a block through the request object
    # we store the actual response from the call to Faraday.get in an instance variable
    # so we can access the response in the view
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = ENV['client_id']
        req.params['client_secret'] = ENV['client_secret']
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        # req.options.timeout = 0
      end
      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body["response"]["venues"]
      else
        @error = body["meta"]["errorDetail"]
      end

    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
