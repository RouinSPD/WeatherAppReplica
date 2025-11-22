//
//  WeatherAppReplicateTests.swift
//  WeatherAppReplicateTests
//
//  Created by Pedro Daniel Rouin Salazar on 22/11/25.
//

import XCTest
import WeatherKit
@testable import WeatherAppReplica

final class WeatherAppReplicateTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    @MainActor
    func testUpdateCurrentConditions() {
        let viewModel = WeatherViewModel(service: MockWeatherService())
        
        let mockCurrent = CurrentConditions(
            description: "Sunny",
            temperature: 28.5,
            symbol: "sun.max",
            feelsLike: 30.0,
            precipitation: 0,
            visibility: 10
        )
        
        viewModel.currentConditions = mockCurrent
        
        XCTAssertEqual(viewModel.currentConditions.description, "Sunny")
        XCTAssertEqual(viewModel.currentConditions.temperature, 28.5)
        XCTAssertEqual(viewModel.currentConditions.symbol, "sun.max")
        XCTAssertEqual(viewModel.currentConditions.feelsLike, 30.0)
        XCTAssertEqual(viewModel.currentConditions.precipitation, 0)
        XCTAssertEqual(viewModel.currentConditions.visibility, 10)
    }
    
    @MainActor
    func testUpdateWindInfo() {
        let viewModel = WeatherViewModel(service: MockWeatherService())
        
        let mockWind = WindInfo(
            speed: 15,
            gust: 25,
            compassDirection: "NE"
        )
        
        viewModel.wind = mockWind
        
        XCTAssertEqual(viewModel.wind.speed, 15)
        XCTAssertEqual(viewModel.wind.gust, 25)
        XCTAssertEqual(viewModel.wind.compassDirection, "NE")
    }
    
    @MainActor
    func testUpdateHumidityInfo() {
        let viewModel = WeatherViewModel(service: MockWeatherService())
        
        let mockHumidity = HumidityInfo(
            humidity: 60,
            dewPoint: 12
        )
        
        viewModel.humidity = mockHumidity
        
        XCTAssertEqual(viewModel.humidity.humidity, 60)
        XCTAssertEqual(viewModel.humidity.dewPoint, 12)
    }
    
    @MainActor
    func testUpdateUVIndexInfo() {
        let viewModel = WeatherViewModel(service: MockWeatherService())
        
        let mockUVIndex = UVIndexInfo(
            value: 5,
            description: "Moderate"
        )
        
        viewModel.uvIndex = mockUVIndex
        
        XCTAssertEqual(viewModel.uvIndex.value, 5)
        XCTAssertEqual(viewModel.uvIndex.description, "Moderate")
    }
    
    @MainActor
    func testUpdateSunInfo() {
        let viewModel = WeatherViewModel(service: MockWeatherService())
        
        let sunrise = Date(timeIntervalSince1970: 1711250000)
        let sunset = Date(timeIntervalSince1970: 1711290000)
        
        let mockSun = Sun(
            sunrise: sunrise,
            sunset: sunset
        )
        
        viewModel.sun = mockSun
        
        XCTAssertEqual(viewModel.sun.sunrise, sunrise)
        XCTAssertEqual(viewModel.sun.sunset, sunset)
    }
    
    @MainActor
    func testIsPastSunset_whenSunsetIsInPast_returnsTrue() {
        let vm = WeatherViewModel(service: MockWeatherService())
        vm.sun.sunset = Date(timeIntervalSinceNow: -3600) // 1 hora antes
        XCTAssertTrue(vm.isPastSunset())
    }

    @MainActor
    func testIsPastSunrise_whenSunriseIsInFuture_returnsFalse() {
        let vm = WeatherViewModel(service: MockWeatherService())
        vm.sun.sunrise = Date(timeIntervalSinceNow: 3600) // 1 hora después
        XCTAssertFalse(vm.isPastSunrise())
    }
    
    func testTemperatureExtremes_returnsCorrectMaxAndMin() {
        let forecast: [MockDayWeather] = [
            .init(date: Date(), highTemp: 30, lowTemp: 20),
            .init(date: Date(), highTemp: 35, lowTemp: 15),
            .init(date: Date(), highTemp: 25, lowTemp: 18)
        ]

        let extremes = forecast.temperatureExtremes()
        XCTAssertEqual(extremes.max, 35)
        XCTAssertEqual(extremes.min, 15)
    }
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//    
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
