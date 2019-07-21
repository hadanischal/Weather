//
//  WeatherDetailHandlerTests.swift
//  WeatherTests
//
//  Created by Nischal Hada on 7/21/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherDetailHandlerTests: XCTestCase {
    var testHandler: WeatherDetailHandler!

    override func setUp() {
        testHandler = WeatherDetailHandler()
    }

    override func tearDown() {
        self.testHandler = nil
    }

    func testFetchWeatherInfo() {
        let exp = expectation(description: "Loading WeatherInfo")

        let weatherInfo = StubData.shared.stubWeather()

        testHandler.fetchWeatherInfo(withWeatherInfo: weatherInfo[0]) { result in
            exp.fulfill()

            switch result {
            case .success(let list) :
                XCTAssertNotNil(list, "expect detail list to be not nil")
                XCTAssertEqual(list.count, 2, "expected to have array count 2")

                let section1 = list[0]
                let section2 = list[1]
                XCTAssertEqual(section1.count, 1, "expected to have array count 1")
                XCTAssertEqual(section2.count, 6, "expected to have array count 6")

                let section1_Row1 = section1[0]
                let section2_Row2 = section2[0]
                XCTAssertEqual(section1_Row1.title, "clear sky", "expected title to be clear sky")
                XCTAssertEqual(section2_Row2.title, "Humidity", "expected title to be Humidity")
                break

            case .failure(let error) :
                print("Parser error \(error)")
                XCTAssert(false, "Expect to get weather info, failed with error")
                break
            }
        }
        waitForExpectations(timeout: 3)
    }

    func testFetchWeatherInfoFailed() {
        let exp = expectation(description: "Loading WeatherInfo")

        let weatherInfo = WeatherInformation.empty

        testHandler.fetchWeatherInfo(withWeatherInfo: weatherInfo) { result in
            exp.fulfill()

            switch result {
            case .success(let list) :
                XCTAssertNotNil(list, "expect detail list to be not nil")
                XCTAssertEqual(list.count, 2, "expected to have array count 2")

                let section1 = list[0]
                let section2 = list[1]
                XCTAssertEqual(section1.count, 1, "expected to have array count 1")
                XCTAssertEqual(section2.count, 6, "expected to have array count 6")
                break

            case .failure(let error) :
                print("Parser error \(error)")
                XCTAssert(false, "Expect to get weather info, failed with error")
                break
            }
        }
        waitForExpectations(timeout: 3)
    }
}
