//
//  CityListHandlerTests.swift
//  WeatherTests
//
//  Created by Nischal Hada on 7/21/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import XCTest
@testable import Weather

class CityListHandlerTests: XCTestCase {
    var testHandler: CityListHandler!
    var mockFileManagerHandler: MockFileManagerHandler!

    override func setUp() {
        mockFileManagerHandler = MockFileManagerHandler()
        testHandler = CityListHandler(withFileManagerHandler: mockFileManagerHandler)
    }

    override func tearDown() {
        self.testHandler = nil
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
}
