require 'httparty'
require 'json'


# This class represents a world traveller who knows what languages are spoken in each country
# around the world and can cobble together a sentence in most of them (but not very well)
class Multilinguist

  TRANSLTR_BASE_URL = "http://bitmakertranslate.herokuapp.com"
  COUNTRIES_BASE_URL = "https://restcountries.eu/rest/v2/name"
  #{name}?fullText=true
  #?text=The%20total%20is%2020485&to=ja&from=en


  # Initializes the multilinguist's @current_lang to 'en'
  #
  # @return [Multilinguist] A new instance of Multilinguist
  def initialize
    @current_lang = 'en'
  end

  # Uses the RestCountries API to look up one of the languages
  # spoken in a given country
  #
  # @param country_name [String] The full name of a country
  # @return [String] A 2 letter iso639_1 language code
  def language_in(country_name)
    params = {query: {fullText: 'true'}}
    response = HTTParty.get("#{COUNTRIES_BASE_URL}/#{country_name}", params)
    json_response = JSON.parse(response.body)
    json_response.first['languages'].first['iso639_1']
  end

  # Sets @current_lang to one of the languages spoken
  # in a given country
  #
  # @param country_name [String] The full name of a country
  # @return [String] The new value of @current_lang as a 2 letter iso639_1 code
  def travel_to(country_name)
    local_lang = language_in(country_name)
    @current_lang = local_lang
  end

  # (Roughly) translates msg into @current_lang using the Transltr API
  #
  # @param msg [String] A message to be translated
  # @return [String] A rough translation of msg
  def say_in_local_language(msg)
    params = {query: {text: msg, to: @current_lang, from: 'en'}}
    response = HTTParty.get(TRANSLTR_BASE_URL, params)
    json_response = JSON.parse(response.body)
    json_response['translationText']
  end

end

  class MathGenius < Multilinguist


    def report_total(numbers_list)
      @numbers_list = numbers_list
        sum = 0
      @numbers_list.each do |number|
        sum += number
    end

    return "The sum of your number list is #{sum}"
  end

end


class QuoteCollector < Multilinguist
    @@quotes = []
  def initialize

  end

  def add_quote(quote)
    @quote = quote
    @@quotes << @quote
    return @@quotes
  end

  def select_quote
    @random_quote = @@quotes.sample
    return @random_quote
  end
end

# valerie = MathGenius.new

# p valerie.report_total([23, 45, 65, 12, 34])
#
# p valerie.travel_to("Guatemala")
#
# p valerie.say_in_local_language(valerie.report_total([23, 45, 65, 12, 34]))
#
# p valerie.travel_to("Italy")
#
# p valerie.say_in_local_language(valerie.report_total([23, 45, 65, 12, 34]))
#
# p valerie.travel_to("France")
#
# p valerie.say_in_local_language(valerie.report_total([23, 45, 65, 12, 34]))

sally = QuoteCollector.new
dale = QuoteCollector.new
britney = QuoteCollector.new
sean = QuoteCollector.new
ray = QuoteCollector.new

p sally.add_quote("I love cookies!")
p dale.add_quote("See the sun.")
p britney.add_quote("Your eyes glow.")
p ray.add_quote("I can eat any food I want :)")

p sean.select_quote

p sean.travel_to("France")

p sean.say_in_local_language(sean.select_quote)

p ray.travel_to("Spain")

p ray.say_in_local_language(ray.select_quote)
