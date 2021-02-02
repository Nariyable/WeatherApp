//
//  forecastCellViewModel.swift
//  WeatherApp
//
//  Created by NG on 01.02.2021.
//

import Foundation

struct ForecastCellViewModel {
    
    let dateTime: Observable<String>
    let time: Observable<String>
    let temperature: Observable<String>
    let description: Observable<String>
    
    init(_ weatherDetail: WeatherDetail) {
        let dateTimeSting = DateUtility(date: weatherDetail.dateTime).forcastDateTimeString
        let timeSting = DateUtility(date: weatherDetail.time).forcastTimeString
        dateTime = Observable(dateTimeSting)
        time = Observable(timeSting)
        
        temperature = Observable("\(weatherDetail.currentTemperature) °C")
        description = Observable(weatherDetail.description.capitalized)
    }
}
