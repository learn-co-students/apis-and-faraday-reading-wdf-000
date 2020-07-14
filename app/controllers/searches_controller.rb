class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
	req.params['client_id'] = 'XR1C0E4AVHEOERZYOCFBM13FRFF1LMADVVKRHTAENYR5EE1P'
	req.params['client_secret'] = 'CWNJ2UP54GJNOG1KHTAJ2WDWYZ3R234URWC0TOZHXYZS1K4Q'
	req.params['v'] = '20160201'
	req.params['near'] = params[:zipcode]
	req.params['query'] = 'coffee shop'
	# req.options.timeout = 0
      end
      body_hash = JSON.parse(@resp.body)
      if @resp.success?
	@venues = body_hash["response"]["venues"]
      else
	@error = body_hash["meta"]["errorDetail"]
      end
    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
