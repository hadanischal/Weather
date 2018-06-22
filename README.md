# Weather

Notices

Implement an iOS native app using Swift 4.1 to demonstrate weather information. The current version is working with Xcode Version Xcode 9.1 . If you are using different Xcode version, please rework for Swift version.

Requirement:
-  Use a UITableViewController to display weather information of Sydney, Melbourne and Brisbane as start.
-  Provide a way to add more cities using another modal view controller which includes a search functionality to find a city by name or location.
-  City IDs
o Sydney, Melbourne and Brisbane are: 4163971, 2147714, 2174003
o Morecitycanbefoundfromfollowinglink:http://bulk.openweathermap.org/sample/
-  Each cell should display at least two pieces of info: Name of city on the left,
temperature on the right.
-  Get real time weather information using https://openweathermap.org/current - You
can register and get your API key for free.
-  A sample request to get weather info for one city:
o http://api.openweathermap.org/data/2.5/weather?id=4163971&units=metri c&APPID=your_registered_API_key
-  Weather should be automatically updated periodically.
-  Use Storyboard and Autolayouts.
-  It is fine to use 3rd party libraries via CocoaPods or by other means.


Brownie Points:
-  Use an activity indicator to provide some feedback to user while waiting for network response.
-  Allow user to tap on a cell to open a new “Detail view”, to show more information about the city such as current weather summary, min and max temperature, humidity, etc.
-  Try to use table view or collection view to display details.
-  In the “Detail view”, implement animations to enhance the user experience.
-  Support all different dimensions of the devices.
-  Support landscape and portrait view together

 
