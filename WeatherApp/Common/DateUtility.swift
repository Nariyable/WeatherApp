//
//  DateUtility.swift
//  WeatherApp
//
//  Created by NG on 01.02.2021.
//

import Foundation

struct DateUtility {
    
   private let rawDate: String
    
    init(date: String) {
        self.rawDate = date
    }
    
    var forcastDateTimeString: String {
       
        let sourceDateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = convertDate(fromSourceFormat: sourceDateFormat, toFormat: "d MMM")
        let timeString = convertDate(fromSourceFormat: sourceDateFormat, toFormat: "HH:mm a")
        
        let formatedDate =  (dateString ?? "") + "\n\n" + (timeString ?? "")
        
        return formatedDate
    }
    
    var forcastTimeString: String {
        
        let sourceDateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = convertDate(fromSourceFormat: sourceDateFormat, toFormat: "d MMM")
        let timeString = convertDate(fromSourceFormat: sourceDateFormat, toFormat: "HH:mm")
        
        let formatedDate =  (timeString ?? "") + "\n\n" + (dateString ?? "")
        return formatedDate
    }

    // Converts Date String from sourceFormat to required fromat
    private func convertDate(fromSourceFormat sourceFormat: String, toFormat : String) -> String? {
        
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = sourceFormat
        guard let date = dateFormatter.date(from: rawDate) else {
            return nil
        }
        
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = toFormat
        let formatedString = dateFormatter.string(from: date)
        
        return formatedString
    }
}
