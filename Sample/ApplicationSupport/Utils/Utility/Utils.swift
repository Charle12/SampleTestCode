//
//  Utils.swift
//  Sample
//
//  Created by Admin on 10/02/23.


import Foundation

class Utils {
    
    static func getDateFromString(dateString: String) -> NSDate? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from:dateString) else {
            NSLog("Date conversion failed due to mismatched format.")
            return NSDate()
        }
        return date as NSDate
    }
    
    static func getStringFromDate(date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" //Your New Date format as per requirement change it own
        let newDate = dateFormatter.string(from: date) //pass Date here
        return newDate //New formatted Date string
    }
    
    static func isConnectedToNetwork() -> Bool {
        return Reach().isNetworkReachable()
    }
}

