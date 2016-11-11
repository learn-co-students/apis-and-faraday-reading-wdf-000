class SearchesController < ApplicationController
  def search
  end

  def foursquare
  begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'CDOGUWP2WF0JF4QBSBENYPFSB2SV2YNWNKEIU3ALSPL2JDE1'
      req.params['client_secret'] = 'Y00VPPVOAGNMMRTUYLSRPD1PVILHU3JF2UIGJMITPNVXIOAA'
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
    render 'search'
  end
end
