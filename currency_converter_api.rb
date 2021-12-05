module CurrencyConverterApi
require 'httparty'
require 'date'
class CurrencyConverterApi
  include HTTParty
  include Credentials
  Ultra = 'ultra'
  attr_accessor :pairs_to_query,:compact
  attr_writer :api_key

  def initialize
    @pairs_to_query = []
    @compact = Ultra
    @api_key = ENV['currency_converter_api']
    @request = { query: { apiKey:@api_key } }
  end

  def convert
    self.class.get('/api/v7/convert', @request['query'].merge({ q:@pairs_to_query, compact:@compact}))
  end

  def currencies
    self.class.get('/api/v7/currencies', @request)
  end

  def countries
    self.class.get('/api/v7/countries', @request)
  end

  def single_historical_date(date:Date)
    self.class.get('/api/v7/convert', @request['query'].merge({ q:@pairs_to_query, compact:@compact, date:date.strftime("%Y-%m-%d")}))
  end

  def historical_date_range(date:Date,end_date:Date)
    if date > date + 365
      raise('Date range is bigger than 365 days')
    end
    self.class.get('/api/v7/convert', @request['query'].merge({ q:@pairs_to_query, compact:@compact, date:date.strftime("%Y-%m-%d"), endDate:date.strftime("%Y-%m-%d")}))
  end
end
end