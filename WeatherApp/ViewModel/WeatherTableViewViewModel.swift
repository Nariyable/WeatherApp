//
//  WeatherTableViewViewModel.swift
//  WeatherApp
//
//  Created by NG on 27.01.2021.
//

import Foundation
import CoreLocation

struct WeatherViewModel {
    
    // MARK: - Constants
   private let emptyString = ""
    
    // MARK: - Properties
    let isFetchingData: Observable<Bool>
    let hasError: Observable<Bool>
    let processMessage: Observable<String>
    let weatherDescription: Observable<String>
    let location: Observable<String>
    let temperature: Observable<String>
    let maxTemp: Observable<String>
    let minTemp: Observable<String>
    let huminity: Observable<String>
    let feelsLike: Observable<String>
    let forecasts: Observable<[ForecastCellViewModel]>
    
    // MARK: - Dependency Injection
    fileprivate var locationService: LocationService

    // MARK: - init
    init() {
        
        isFetchingData = Observable(false)
        hasError = Observable(true)
        processMessage = Observable("")
        weatherDescription = Observable(emptyString)
        location = Observable("Loading...")
        temperature = Observable(emptyString)
        minTemp = Observable(emptyString)
        maxTemp = Observable(emptyString)
        huminity = Observable(emptyString)
        feelsLike = Observable(emptyString)
        forecasts = Observable([])
        
        locationService = LocationService()
    }
    
    // MARK: - public
    func startLocationService() {
        processMessage.value = "Fetching weather details..."
        isFetchingData.value = true
        locationService.delegate = self
        locationService.requestLocation()
    }
    
    // MARK: - private
    private func update(_ weather: Weather) {
        processMessage.value = ""
        location.value = weather.cityName + ", \(weather.country)"

        guard let currentWeather = weather.weaterDetails.first else {
            update(WAError.noData)
            return
        }
        
        weatherDescription.value = currentWeather.description.capitalized
        temperature.value = "\(currentWeather.currentTemperature) °C"
        maxTemp.value = "\(currentWeather.maxTemperature) "
        minTemp.value = "\(currentWeather.minTemperature) °C"
        huminity.value = "Huminity \(currentWeather.huminity)%"
        feelsLike.value = "Feels like \(currentWeather.feelsLike) °C"

        constructForecastDataModel(fromWeatherDetails: Array(weather.weaterDetails.dropFirst()))
        hasError.value = false
        isFetchingData.value = false
    }
    
    
    private func update(_ error: WAError) {
        hasError.value = true
        switch error {
        case .invalidURL, .requestParameterError:
            processMessage.value = "The weather service is not working."
        case .networkRequestFailed, .noData:
            processMessage.value = "The network appears to be down."
        case .jsonParsingFailed:
            processMessage.value = "We're having trouble parsing weather data."
        case .unableToFindLocation:
            processMessage.value = "We're having trouble getting user location."
        case .unknown(let errorMsg):
            processMessage.value = errorMsg
        }
        
        weatherDescription.value = emptyString
        location.value = emptyString
        temperature.value = emptyString
        maxTemp.value = emptyString
        minTemp.value = emptyString
        feelsLike.value = emptyString
        huminity.value = emptyString
        
        self.forecasts.value = []
        isFetchingData.value = false
        hasError.value = true
    }
    
    private func constructForecastDataModel(fromWeatherDetails weatherDetails: [WeatherDetail]) {

        if (weatherDetails.count > 0) {
            let tempForecasts = weatherDetails.map { forecast in
                return ForecastCellViewModel(forecast)
            }
            forecasts.value = tempForecasts

        } else {
            self.forecasts.value = []
        }
    }
}

// MARK: LocationServiceDelegate
extension WeatherViewModel: LocationServiceDelegate {
    
    func locationDidUpdate(_ service: LocationService, location: CLLocation) {
        var weatherService = OpenWeatherMapService()

        weatherService.retrieveWeatherInfo(location) { (weather, error) -> Void in
            DispatchQueue.main.async(execute: {
                if let unwrappedError = error {
                    print(unwrappedError)
                    self.update(unwrappedError)
                    return
                }
                
                guard let unwrappedWeather = weather else {
                    return
                }
                self.update(unwrappedWeather)
            })
        }
    }
    
    func locationDidFail(withError error: WAError) {
        self.update(error)
    }
}
