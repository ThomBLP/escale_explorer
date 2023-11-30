class MeteoServices
  def initialize
  end
  def call
    url = "https://history.openweathermap.org/data/2.5/history/city?lat={lat}&lon={lon}&type=hour&start={start}&end={end}&appid={API key}"
  end
end
