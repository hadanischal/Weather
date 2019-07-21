//
//  WeatherDetailViewModelTests.swift
//  WeatherTests
//
//  Created by Nischal Hada on 7/21/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherDetailViewModelTests: XCTestCase {
    var viewModel: WeatherDetailViewModel!
    var mockWeatherDetailHandler: MockWeatherDetailHandler!
    var mockWeatherInformation: WeatherInformation?

    override func setUp() {
        self.mockWeatherDetailHandler = MockWeatherDetailHandler()
        //        self.viewModel = WeatherDetailViewModel(withCityListHandler: mockWeatherDetailHandler, withWeatherInformation: mockWeatherInformation)
    }

    override func tearDown() {
        self.viewModel = nil
        self.mockWeatherDetailHandler = nil
        self.mockWeatherInformation = nil
    }

    func testFetchWeatherInfo() {
        let exp = expectation(description: "Loading service call")
        let weatherData = StubData.shared.stubWeather()

        self.mockWeatherInformation = weatherData[0]
        mockWeatherDetailHandler.weatherData = StubData.shared.stubDetailModel()

        self.viewModel = WeatherDetailViewModel(withCityListHandler: mockWeatherDetailHandler, withWeatherInformation: mockWeatherInformation)

        self.viewModel.dataSource.bindAndFire { list in
            if list.count > 1 {
                exp.fulfill()
                XCTAssertNotNil(list, "expect detail list to be not nil")
                XCTAssertEqual(list.count, 2, "expected to have array count 2")

                let section1 = list[0]
                let section2 = list[1]
                XCTAssertEqual(section1.count, 2, "expected to have array count 2")
                XCTAssertEqual(section2.count, 2, "expected to have array count 2")

                let section1_Row1 = section1[0]
                let section2_Row2 = section2[0]
                XCTAssertEqual(section1_Row1.title, "Humidity", "expected title to be Humidity")
                XCTAssertEqual(section2_Row2.title, "WindSpeed", "expected title to be WindSpeed")
            }
        }
        waitForExpectations(timeout: 3)
    }

    func testFetchWeatherInfoFails() {
        let exp = expectation(description: "Loading service call")

        let weatherData = StubData.shared.stubWeather()
        self.mockWeatherInformation = weatherData[0]

        mockWeatherDetailHandler.weatherData = nil
        self.viewModel = WeatherDetailViewModel(withCityListHandler: mockWeatherDetailHandler, withWeatherInformation: mockWeatherInformation)

        self.viewModel.dataSource.bindAndFire { list in
            XCTAssertNotNil(list, "expect city list to be not nil")
            XCTAssertEqual(list.count, 1, "expected to have array count 0")
        }

        let errorMock = ErrorResult.parser(string: "Error while parsing json data")
        self.viewModel.onErrorHandling = { error in
            exp.fulfill()
            XCTAssertNotNil(error, "expect error to be not nil")
            XCTAssertEqual(error?.localizedDescription, errorMock.localizedDescription, "expected to error out with Error while parsing json data")
        }
        waitForExpectations(timeout: 3)
    }
}
