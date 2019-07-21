//
//  AddCityViewModelTests.swift
//  WeatherTests
//
//  Created by Nischal Hada on 7/21/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import XCTest
@testable import Weather

class AddCityViewModelTests: XCTestCase {
    var viewModel: AddCityViewModel!
    var mockCityListHandler: MockCityListHandler!

    override func setUp() {
        self.mockCityListHandler = MockCityListHandler()
//        self.viewModel = AddCityViewModel(withCityListHandler: mockCityListHandler)
    }

    override func tearDown() {
        self.viewModel = nil
        self.mockCityListHandler = nil
    }

    func testFetchCityInfo() {
        let exp = expectation(description: "Loading service call")
        let cityData = StubData.shared.stubCity()
        mockCityListHandler.cityListData = cityData
        self.viewModel = AddCityViewModel(withCityListHandler: mockCityListHandler)

        self.viewModel.cityListModel.bindAndFire { result in
            if result.count > 0 {
                exp.fulfill()
                XCTAssertNotNil(result, "expect city list to be not nil")
                XCTAssertEqual(result.count, 7, "expected to have array count 7")
                XCTAssertEqual(result[0].name, "Sydney", "expected city to be sydney")
            }
        }
        waitForExpectations(timeout: 3)
    }

    //for get city success
    func testFetchCityInfoisFinished() {
        let exp = expectation(description: "Loading service call")
        let cityData = StubData.shared.stubCity()
        mockCityListHandler.cityListData = cityData
        self.viewModel = AddCityViewModel(withCityListHandler: mockCityListHandler)
        
        self.viewModel.isFinished.bindAndFire { isTrue in
            if isTrue {
                exp.fulfill()
                XCTAssertNotNil(isTrue, "expect isTrue to be not nil")
                XCTAssertEqual(isTrue, true, "expected isFinished to be true")
            }
        }
        waitForExpectations(timeout: 3)
    }
    
    func testFetchWeatherInfoByCityFails() {
        let exp = expectation(description: "Loading service call")
        self.mockCityListHandler.cityListData = nil
        self.viewModel = AddCityViewModel(withCityListHandler: mockCityListHandler)
        
        self.viewModel.cityListModel.bindAndFire { result in
            XCTAssertNotNil(result, "expect city list to be not nil")
            XCTAssertEqual(result.count, 0, "expected to have array count 0")
        }
        
        let errorMock = ErrorResult.parser(string: "Error while parsing json data")
        self.viewModel.onErrorHandling = { error in
            exp.fulfill()
            XCTAssertNotNil(error, "expect error to be not nil")
            XCTAssertEqual(error?.localizedDescription, errorMock.localizedDescription, "expected to error out with Error while parsing json data")
        }
        waitForExpectations(timeout: 3)
    }

    //for get city success
    func testFetchCityInfoisFinishedForCityFails() {
        let exp = expectation(description: "Loading service call")
        self.mockCityListHandler.cityListData = nil
        self.viewModel = AddCityViewModel(withCityListHandler: mockCityListHandler)
        
        self.viewModel.isFinished.bindAndFire { isTrue in
            if isTrue {
                exp.fulfill()
                XCTAssertNotNil(isTrue, "expect isTrue to be not nil")
                XCTAssertEqual(isTrue, true, "expected isFinished to be true")
            }
        }
        waitForExpectations(timeout: 3)
    }
}
