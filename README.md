# Weather
## Requirements:
* iOS 11.0+
* Xcode 9.4.1
* Swift 4.1

## Compatibility
This demo is expected to be run using Swift 4.1 and Xcode 9.4.x.

## Notices:
Implement an iOS native app using Swift 4.1 to demonstrate weather information. The current version is working with Xcode Version Xcode 9.1

## Objective:
This is a simple Demo project which aims to display weather information.
* This project was intended to work as a  weather information demo projects for iOS using Swift. 
* The demo uses the [Openweathermap API](http://api.openweathermap.org) as an excuse to have a nice use-case, because querying a WebService API is asynchronous by nature and is thus a good example for showing how It can be useful .

## Guidelines:
* Use a UITableViewController to display weather information of Sydney, Melbourne and Brisbane as start.
* Provide a way to add more cities using another modal view controller which includes a search functionality to find a city by name or location.
* City IDs:
    * Sydney, Melbourne and Brisbane are: 4163971, 2147714, 2174003
    * More city can be found from  [Bulk Openweathermap API](http://bulk.openweathermap.org/sample/) 
* Each cell should display at least two pieces of info: Name of city on the left, temperature on the right.
* Get real time weather information using  [Openweathermap current API](https://openweathermap.org/current)  
    * You can register and get your API key for free.
* A sample request to get weather info for one city: 
    * http://api.openweathermap.org/data/2.5/weather?id=4163971&units=metri c&APPID=your_registered_API_key
* Weather should be automatically updated periodically.
* Use Storyboard and Autolayouts.
* It is fine to use 3rd party libraries via CocoaPods or by other means.

## Additional Requirements
* Use an activity indicator to provide some feedback to user while waiting for network response.
* Allow user to tap on a cell to open a new “Detail view”, to show more information about the city such as current weather summary, min and max temperature, humidity, etc.
* Try to use table view or collection view to display details.
* In the “Detail view”, implement animations to enhance the user experience.
* Support all different dimensions of the devices.
* Support landscape and portrait view together

 
