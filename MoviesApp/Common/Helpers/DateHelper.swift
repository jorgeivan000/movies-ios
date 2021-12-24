//
//  DateHelper.swift
//  MoviesApp
//
//  Created by jorgehc on 1/8/18.
//  Copyright 2018 jorgehc.com. All rights reserved.
//

import Foundation

enum OwnDateFormat: String {
    //HERE: Add your own date formats
    case local = "yyyy-MM-dd HH:mm:ssZ"
    case server = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case serverShort = "yyyy-MM-dd"
    case database = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case display = "dd/MM/yyyy"
    case yearTwoDigits = "dd/MM/yy"
    case serviceView = "dd MMM yyyy"
    case showView = "EEE, dd MMM"
    case dateAndHour = "dd/MM/YYYY ' - ' hh:mma"
    case hour = "H:mm"
    case hourMeridian = "h:mm a"
}

class DateHelper {
    //TODO: Evaluate use of locale string
    static let localePreferred = "es_MX_POSIX"
    static let timeZoneServer = "GMT"
    static let minutesOnADay = 1440
    
    static func string(from date: Date, using format: OwnDateFormat = .server) -> String {
        let serverFormatter = DateFormatter()
        serverFormatter.dateFormat = OwnDateFormat.server.rawValue
        serverFormatter.locale = Locale.init(identifier: localePreferred)
        let utcServerDate = serverFormatter.string(from: date)
        let localFormatter =  DateFormatter()
        localFormatter.dateFormat = OwnDateFormat.database.rawValue
        localFormatter.locale = Locale.init(identifier: localePreferred)
        let localFormattedDate = localFormatter.date(from: utcServerDate)
        let timeZone = TimeZone.autoupdatingCurrent.identifier as String
        localFormatter.timeZone = TimeZone(identifier: timeZone)
        localFormatter.dateFormat = format.rawValue
        localFormatter.amSymbol = "AM"
        localFormatter.pmSymbol = "PM"
        return localFormatter.string(from: localFormattedDate!)
    }
    
    static func formatStringFromLocal(from string: String, using format: OwnDateFormat = .server) -> String {
        let originalDate = date(from: string, using: .local)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.locale = Locale.init(identifier: localePreferred)
        return dateFormatter.string(from: originalDate!)
    }
    
    static func date(from string: String, using format: OwnDateFormat = .server, timeZone: String? = nil) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.isLenient = true
        dateFormatter.locale = Locale.init(identifier: localePreferred)
        if let timeZone = timeZone {
            dateFormatter.timeZone = TimeZone(identifier: timeZone)
        }
        return dateFormatter.date(from: string)
    }
    
    static func getDisplayDate(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = OwnDateFormat.display.rawValue
        dateFormatter.locale = Locale.init(identifier: localePreferred)
        return dateFormatter.string(from: date)
    }
    
    static func getServerShortDate(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = OwnDateFormat.serverShort.rawValue
        dateFormatter.locale = Locale.init(identifier: localePreferred)
        return dateFormatter.string(from: date)
    }
    
    static func monthAndYear(from date: Date) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM yyyy"
        dateFormatter.isLenient = true
        dateFormatter.locale = Locale.init(identifier: localePreferred)
        let stringDate = dateFormatter.string(from: date)
        return dateFormatter.date(from: stringDate)!
    }
    
    static func add(minutes: Int, to date: Date) -> Date? {
        let calendar = Calendar.current
        let dateWithAdition = calendar.date(byAdding: .minute, value: minutes, to: date)
        return dateWithAdition
    }
    
    static func betweenTimes(startTime: String, endTime: String) -> String {
        let fromHour = formatStringFromLocal(from: startTime, using: .hour)
        let toHour = formatStringFromLocal(from: endTime, using: .hour)
        return "Entre " + fromHour + " y " + toHour
    }
    
    static func isDateToday(date: Date) -> Bool {
        let formattedDate = string(from: date, using: OwnDateFormat.display)
        let localFormatter =  DateFormatter()
        let currentDate = Date()
        localFormatter.dateFormat = OwnDateFormat.display.rawValue
        let currentFormattedDate = localFormatter.string(from: currentDate)
        return formattedDate == currentFormattedDate
    }
    
    static func convertFromLocalToServer(from string: String?) -> String {
        guard let string = string ,let originalDate = date(from: string, using: .local) else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = OwnDateFormat.server.rawValue
        dateFormatter.locale = Locale.init(identifier: localePreferred)
        return dateFormatter.string(from: originalDate)
    }
    
    static func convertServerToLocal(from string: String?) -> String {
        guard let string = string else { return "" }
        let originalDate = date(from: string, using: .server)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = OwnDateFormat.local.rawValue
        dateFormatter.locale = Locale.init(identifier: localePreferred)
        return dateFormatter.string(from: originalDate!)
    }
    
    //Parse date string to obtain simple date with yyyy-mm-dd format
    static func convertDashedDateStringToSimpleDate(from stringDate: String, _ separator: String? = nil) -> Date {
        let separators = NSCharacterSet(charactersIn: separator ??  "-")
        let components = stringDate.components(separatedBy: separators as CharacterSet)
        // Specify date components
        var dateComponents = DateComponents()
        dateComponents.year = Int(components[0])
        dateComponents.month = Int(components[1])
        dateComponents.day = Int(components[2])
        // Create date from components
        let userCalendar = Calendar.current // user calendar
        if let simpleDate = userCalendar.date(from: dateComponents){
            return simpleDate
        }
        return Date()
    }
    
    //Parse date string to obtain simple date with dd/mm/yyyy format
    static func convertDateStringToSimpleDate(from stringDate: String, _ separator: String? = nil) -> Date {
        let separators = NSCharacterSet(charactersIn: separator ??  "/")
        let components = stringDate.components(separatedBy: separators as CharacterSet)
        // Specify date components
        var dateComponents = DateComponents()
        dateComponents.year = Int(components[2])
        dateComponents.month = Int(components[1])
        dateComponents.day = Int(components[0])
        // Create date from components
        let userCalendar = Calendar.current // user calendar
        if let simpleDate = userCalendar.date(from: dateComponents){
            return simpleDate
        }
        return Date()
    }
    
    static func getSimpleDateComponents(from stringDate: String, _ separator: String? = nil) -> (Int?, Int?, Int?) {
        let separators = NSCharacterSet(charactersIn: separator ??  "/")
        let components = stringDate.components(separatedBy: separators as CharacterSet)
        let year = Int(components[2])
        let month = Int(components[1])
        let day = Int(components[0])
        
        return (year, month, day)
    }
    
    static func setHourToDate(selectedDate: Date, hour: Float) -> String {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: selectedDate)
        
        components.hour = Int(roundf(hour))
        components.minute = 0
        components.second = 0
        
        let date = calendar.date(from: components)!
        return DateHelper.string(from: date, using: .local)
    }
    
    static func getHour(from string: String) -> Float? {
        guard let date = self.date(from: string, using: .local) else { return nil }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: date)
        guard let hour = components.hour else { return nil }
        return Float(hour)
    }
    
    static func setTomorrowHour(from string: String) -> String {
        let date = self.date(from: string, using: .local)
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date!)
        
        let tomorrowDate = self.add(minutes: minutesOnADay, to: Date())!
        var tomorrowComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: tomorrowDate)
        
        tomorrowComponents.hour = dateComponents.hour
        tomorrowComponents.minute = 0
        tomorrowComponents.second = 0
        
        let resultDate = calendar.date(from: tomorrowComponents)!
        return self.string(from: resultDate, using: .local)
    }
    
    static func isBeforeToday(string: String) -> Bool {
        guard let date = self.date(from: string, using: .local) else { return true }
        let currrentDate = Date()
        return date < currrentDate
    }
    
    static func tomorrow() -> Date {
        let currrentDate = Date()
        let calendar = Calendar.current
        
        let tomorrow = self.add(minutes: minutesOnADay, to: currrentDate)
        var tomorrowComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: tomorrow!)
        tomorrowComponents.minute = 0
        tomorrowComponents.second = 0
        
        return calendar.date(from: tomorrowComponents)!
    }

    class func from(year: Int, month: Int, day: Int) -> Date {
        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        let date = gregorianCalendar.date(from: dateComponents)!
        return date
    }
    
    class func getMinuteDiference(timeDate: Date) -> Int {
        let calendar = Calendar.current
        let timeComponents = calendar.dateComponents([.hour, .minute], from: timeDate)
        let nowComponents = calendar.dateComponents([.hour, .minute], from: Date())
        return calendar.dateComponents([.minute], from: timeComponents, to: nowComponents).minute!
    }
    
    class func getDayDiference(timeDate: Date) -> Int {
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: timeDate)
        let date2 = calendar.startOfDay(for: Date())
        return calendar.dateComponents([.day], from: date1, to: date2).day!
    }
    
    class func isInSameMonth(date: Date) -> Bool {
        return Calendar.current.isDate(Date(), equalTo: date, toGranularity: .month)
    }
}
