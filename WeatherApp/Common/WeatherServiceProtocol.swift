//
//  WeatherServiceProtocol.swift
//  WeatherApp
//
//  Created by NG on 29.01.2021.
//

import Foundation
import CoreLocation

protocol WeatherServiceProtocol
{
    typealias WeatherCompletionHandler = (Weather?, WAError?) -> Void
    mutating func retrieveWeatherInfo(_ location: CLLocation, completionHandler: @escaping WeatherCompletionHandler)
}
