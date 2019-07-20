//
//  WeatherListViewModelTests.swift
//  WeatherTests
//
//  Created by Nischal Hada on 7/12/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherListViewModelTests: XCTestCase {
    
    var viewModel: WeatherListViewModel!
    var mockWeatherListHandler: MockWeatherListHandler!
    
    override func setUp() {
        mockWeatherListHandler = MockWeatherListHandler()
        viewModel = WeatherListViewModel(withWeatherListHandler: mockWeatherListHandler)
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.mockWeatherListHandler = nil
    }
    
    func testWeatherList() {
        let exp = expectation(description: "Loading service call")
        self.mockWeatherListHandler.cityListData = StubData.shared.stubCity()
        self.mockWeatherListHandler.weatherListData = StubData.shared.stubWeather()

        self.viewModel.weatherList.bindAndFire { result in
            if result.count > 0 {
                exp.fulfill()
                XCTAssertNotNil(result, "expect weather list to be not nil")
                XCTAssertEqual(result.count, 7, "expected to have array count 7")
                XCTAssertEqual(result[0].name, "Sydney", "expected city to be sydney")
                XCTAssertEqual(result[1].name, "Melbourne", "expected Melbourne to be sydney")
            }
        }
        self.viewModel.pullToRefresh()
        waitForExpectations(timeout: 3)
    }
}
