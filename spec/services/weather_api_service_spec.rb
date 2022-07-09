require 'rails_helper'

RSpec.describe WeatherApiService, type: :service do
  let(:content) {
    {
      address: 'Brunei',
      days: [
        {
          datetime: '2022-01-01',
          conditions: 'Cloudy',
          description: 'Very cloudy day',
          temp: 80.0,
          windspeed: 19.9,
          precipprob: 60.2,
          cloudcover: 89.9,
          icon: 'cloudy'
        }.stringify_keys,
        {
          datetime: '2022-01-02',
          conditions: 'Sunny',
          description: 'Very sunny day',
          temp: 89.0,
          windspeed: 25.9,
          precipprob: 10.1,
          cloudcover: 49.5,
          icon: 'sunny'
        }.stringify_keys
      ]
    }.stringify_keys
  }

  describe '::forecast' do
    before do
      stub_api_request("https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/Brunei/next7days?include=days&key=#{ENV['WEATHER_API_KEY']}")
    end

    it 'returns success response' do
      expect(WeatherApiService.new('Brunei').forecast).to eq([content, '200', ''])
    end
  end

  describe '::history' do
    before do
      stub_api_request("https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/Brunei/2022-01-01/2022-01-02?include=days&key=#{ENV['WEATHER_API_KEY']}")
    end

    context 'when valid dates' do
      it 'returns success response' do
        expect(WeatherApiService.new('Brunei').history('2022-01-01', '2022-01-02')).to eq([content, '200', ''])
      end
    end

    context 'when invalid dates' do
      it 'returns error response' do
        expect(WeatherApiService.new('Brunei').history('2022-13-01', '2022-13-02')).to eq([{}, 500, 'invalid date'])
      end
    end
  end

  private

  def stub_api_request(url)
    stub_request(:get, url)
      .with(headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Ruby'
      })
      .to_return(
        status: 200,
        body: '
          {
            "address": "Brunei",
            "days": [
              {
                "datetime": "2022-01-01",
                "conditions": "Cloudy",
                "description": "Very cloudy day",
                "temp": 80.0,
                "windspeed": 19.9,
                "precipprob": 60.2,
                "cloudcover": 89.9,
                "icon": "cloudy"
              },
              {
                "datetime": "2022-01-02",
                "conditions": "Sunny",
                "description": "Very sunny day",
                "temp": 89.0,
                "windspeed": 25.9,
                "precipprob": 10.1,
                "cloudcover": 49.5,
                "icon": "sunny"
              }
            ]
          }
        '
      )
  end
end
