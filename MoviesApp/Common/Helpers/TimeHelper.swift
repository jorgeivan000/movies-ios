//
//  TimeHelper.swift
//  MoviesApp
//
//  Created by jorgehc on 3/7/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//

import Foundation
class TimeHelper {
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func getFormattedTimeFrom(seconds: Int) -> String {
        return seconds < 10 ? "0\(seconds)" : "\(seconds)"
    }
    
    func getFormattedMinutesAndSeconds(minutes: Int, seconds: Int) -> String {
        return getFormattedTimeFrom(seconds: minutes) + ":" + getFormattedTimeFrom(seconds: seconds)
    }
    
    func getFormattedMinutesAndSeconds(seconds: Int) -> String {
        let (_, minutes, seconds) = secondsToHoursMinutesSeconds(seconds: seconds)
        return getFormattedTimeFrom(seconds: minutes) + ":" + getFormattedTimeFrom(seconds: seconds)
    }
}
