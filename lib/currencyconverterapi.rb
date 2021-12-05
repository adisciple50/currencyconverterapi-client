# frozen_string_literal: true

require_relative "currencyconverterapi/version"

module CurrencyConverterApi
  require 'httparty'
  require 'date'

  class Error < StandardError; end

  class DedicatedClient
    include HTTParty
    Ultra = 'ultra'
    attr_accessor :pairs_to_query,:compact
    attr_reader :request

    base_uri 'https://tradeup.currconv.com'

    @@request = { query: { apiKey:ENV['currency_converter_api'] } }
    @@compact = Ultra
    @@pairs_to_query = []

    def initialize
      @pairs_to_query = []
      @compact = Ultra
      @@request = { query: { apiKey:ENV['currency_converter_api'] } }
    end

    def self.server(uri)
      base_uri uri
    end

    def self.convert(pairs_array)
      get('/api/v7/convert', @@request['query'].merge({ q:pairs_array, compact:@compact})).body
    end

    def self.currencies
      get('/api/v7/currencies',@request)
    end

    def self.countries
      get('/api/v7/countries', @request)
    end

    def self.single_historical_date(date:Date)
      get('/api/v7/convert', @request['query'].merge({ q:@pairs_to_query, compact:@compact, date:date.strftime("%Y-%m-%d")}))
    end

    def self.historical_date_range(date:Date,end_date:Date)
      if date > date + 365
        raise('Date range is bigger than 365 days')
      end
      get('/api/v7/convert', @request['query'].merge({ q:@pairs_to_query, compact:@compact, date:date.strftime("%Y-%m-%d"), endDate:date.strftime("%Y-%m-%d")}))
    end
  end
end
