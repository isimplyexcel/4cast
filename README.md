# 4cast
4cast is an app that allows users to browse the 5-day weather forecast from the [OpenWeatherMap API](https://openweathermap.org/api).

### User Stories
- [x] User can enter a city name as text.
- [x] User can tap a button which triggers a segue to display the forecast in a list
- [x] One list item for each day
- [x] Items in list contain day name, weather icon, and the description of the weather.

### App Walkthrough
<img src="/4cast.gif" width=250><br>

## Addendum
Although the iOS coding challenge calls for a 10 day forecast, the OpenWeatherMap api only allows up to 5 days for free users.
The 16 day / daily forecast is only available for paid accounts. Therefore, this app only displays a 5 day forecast. 

Unfortunately the app does not currently have input validation nor does it have error handling for incorrect input. If the city is
incorrectly typed or is an invalid city name e.g. "asdf", then the app will crash.  

