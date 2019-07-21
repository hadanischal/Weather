//
//  WeatherListHandlerTests.swift
//  WeatherTests
//
//  Created by Nischal Hada on 7/21/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherListHandlerTests: XCTestCase {
    var testHandler: WeatherListHandler!
    var mockWebService: MockWebService!
    var mockFileManagerHandler: MockFileManagerHandler!

    override func setUp() {
        mockWebService = MockWebService()
        mockFileManagerHandler = MockFileManagerHandler()
        testHandler = WeatherListHandler(withFileManagerHandler: mockFileManagerHandler, withWebservice: mockWebService)
    }

    override func tearDown() {
        self.testHandler = nil
        self.mockWebService = nil
        self.mockFileManagerHandler = nil
    }

    func testFetchCityInfo() {
        let cityData = StubData.shared.stubCityData()
        mockFileManagerHandler.cityData = cityData
        testHandler.fetchCityInfo(withfileName: "testInfo") { result in
            switch result {
            case .success(let list) :
                XCTAssertNotNil(list, "expect result to be not nil")
                XCTAssertEqual(list.count, 7, "expect city list count to be 7" )
                XCTAssertEqual(list[0].name, "Sydney", "expected city to be sydney")

                break
            case .failure(let error) :
                print("Parser error \(error)")
                XCTAssert(false, "Expect to get city list, failed with error")
                break
            }
        }
    }

    func testFetchCityInfoFailed() {
        mockFileManagerHandler.cityData = nil
        let errorMock = ErrorResult.parser(string: "Error while parsing json data")

        testHandler.fetchCityInfo(withfileName: "testInfo") { result in
            switch result {
            case .success(let list) :
                XCTAssert(false, "Expect to get city list to failed with error")
                XCTAssertNil(list, "expect result to be nil")
                break

            case .failure(let error) :
                XCTAssertNotNil(error, "expect error to be not nil")
                XCTAssertEqual(error.localizedDescription, errorMock.localizedDescription, "expected to error out with Error while parsing json data")
                break
            }
        }
    }

    func testFetchWeatherInfoWithCityID() {
        let exp = expectation(description: "Loading service call")

        let weatherData = StubData.shared.stubWeatherData()
        mockWebService.weatherData = weatherData
        testHandler.fetchWeatherInfo(withCityID: "testId") { result in
            exp.fulfill()

            switch result {
            case .success(let weather) :
                XCTAssertNotNil(weather, "expect weather to be not nil")
                XCTAssertEqual(weather.name, "Sydney", "expected city name to be sydney")
                XCTAssertEqual(weather.id, 2147714, "expected city id to be \(2147714)")
                XCTAssertEqual(weather.main?.temp, 10.22, "expected weather temperature to be \(10.22)")
                XCTAssertEqual(weather.main?.pressure, 1019, "expected weather pressure to be \(1019)")
                break

            case .failure(let error) :
                print("Parser error \(error)")
                XCTAssert(false, "Expect to get weather info, failed with error")
                break
            }
        }
        waitForExpectations(timeout: 3)

    }

    func testFetchWeatherInfoWithCityIDFailed() {
        let exp = expectation(description: "Loading service call")
        let errorMock = ErrorResult.parser(string: "Error while parsing json data")

        mockWebService.weatherData = nil
        testHandler.fetchWeatherInfo(withCityID: "testId") { result in
            exp.fulfill()
            switch result {
            case .success(let weather) :
                XCTAssert(false, "Expect weather to failed with error")
                XCTAssertNil(weather, "expect weather result to be nil")
                break

            case .failure(let error) :
                XCTAssertNotNil(error, "expect error to be not nil")
                XCTAssertEqual(error.localizedDescription, errorMock.localizedDescription, "expected to error out with Error while parsing json data")
                break
            }
        }
        waitForExpectations(timeout: 3)
    }

    func testFetchWeatherInfoWithCityIDS() {
        let exp = expectation(description: "Loading service call")

        let weatherData = StubData.shared.stubWeatherListData()
        mockWebService.weatherData = weatherData
        testHandler.fetchWeatherInfo(withCityIDs: "testIds") { result in
            exp.fulfill()

            switch result {
            case .success(let weatherList) :
                XCTAssertNotNil(weatherList, "expect weather list to be not nil")
                let weather = weatherList[0]
                XCTAssertNotNil(weather, "expect weather to be not nil")
                XCTAssertEqual(weather.name, "Sydney", "expected city name to be sydney")
                XCTAssertEqual(weather.id, 2147714, "expected city id to be \(2147714)")
                XCTAssertEqual(weather.main?.temp, 15.35, "expected weather temperature to be \(15.35)")
                XCTAssertEqual(weather.main?.pressure, 1014, "expected weather pressure to be \(1014)")
                break

            case .failure(let error) :
                print("Parser error \(error)")
                XCTAssert(false, "Expect to get weather info, failed with error")
                break
            }
        }
        waitForExpectations(timeout: 3)
    }

    func testFetchWeatherInfoWithCityIDSFailed() {
        let errorMock = ErrorResult.parser(string: "Error while parsing json data")
        let exp = expectation(description: "Loading service call")

        mockWebService.weatherData = nil
        testHandler.fetchWeatherInfo(withCityIDs: "testIds") { result in
            exp.fulfill()

            switch result {
            case .success(let weatherList) :
                XCTAssert(false, "Expect weather to failed with error")
                XCTAssertNil(weatherList, "expect weather result to be nil")
                break

            case .failure(let error) :
                XCTAssertNotNil(error, "expect error to be not nil")
                XCTAssertEqual(error.localizedDescription, errorMock.localizedDescription, "expected to error out with Error while parsing json data")
                break
            }
        }
        waitForExpectations(timeout: 3)
    }
}
