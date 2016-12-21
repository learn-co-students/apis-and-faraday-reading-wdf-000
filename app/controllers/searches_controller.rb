class SearchesController < ApplicationController
  def search
  end

  def foursquare
  	@resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
  		req.params['client_id'] = "53LNOOIKCUQ0XC151IZ1QWQGU0AS4N5FYRCZ1V000JIR5GHU"
  		req.params['client_secret'] = "UPO3YSUXXA24ZC1OT43BSIMXYBT10TCCFOGYF0K3B3VK1YAL"
  		req.params['v'] = '20160201'
  		req.params['near'] = params[:zipcode]
      	req.params['query'] = 'coffee shop'
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
