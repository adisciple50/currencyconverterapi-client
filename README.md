# currencyconverterapi-client
an api library for currencyconverterapi.com using httparty

# Usage

## Inherit a class with a httparty base url method defined

```
require 'currency_converter_api'

class Client < CurrencyConverterApi::CurrencyConverterApi

  # then choose either of these according to this documentation - https://www.currencyconverterapi.com/docs
  # delete as appropriate - base_uri is a httparty method.
  
  base_uri 'https://api.currconv.com'
  # or
  base_uri 'https://prepaid.currconv.com'
  # or if your using the free server
  base_uri 'https://free.currconv.com'
  # specify your own subdomain
  base_uri 'https://custom-subdomain.currconv.com'
  
  (your code goes here...)
  
end

```


# Licence
this module and all code in this repo is licenced under the MIT Licence. Copyleft Holder is Jason Crockett, code is written and licenced on day of repo creation 2021 
