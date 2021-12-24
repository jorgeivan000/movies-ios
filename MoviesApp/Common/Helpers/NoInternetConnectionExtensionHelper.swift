//
//  NoInternetConnectionExtensionHelper.swift
//  MoviesApp
//
//  Created by jorgehc on 3/26/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//

import Foundation
import UIKit

struct NoInternetConnectionExtensionHelper {
    static var isNavigationBarVisible: Bool = false
    
    static func setNavigationBarVisibility(visible: Bool) {
        isNavigationBarVisible = visible
    }
    
    static func insentTopForBannerLabel() -> CGFloat {
        if isNavigationBarVisible {
            if DeviceType.IS_IPHONE_XR_XSMAX || DeviceType.IS_IPHONE_X_XS {
                return 95
            } else if DeviceType.IS_IPHONE_6P_7P || DeviceType.IS_IPHONE_6_7 {
                return 75
            } else if DeviceType.IS_IPHONE_5 {
                return 70
            }
        }
        return 35.0
    }
    
    static func heightAnchorForBannerLabel() -> CGFloat  {
        if isNavigationBarVisible {
            if DeviceType.IS_IPHONE_XR_XSMAX || DeviceType.IS_IPHONE_X_XS {
                return 130.0
            } else if DeviceType.IS_IPHONE_6P_7P || DeviceType.IS_IPHONE_6_7 {
                return 110.0
            } else if DeviceType.IS_IPHONE_5 {
                return 100.0
            }
        }
        return 60.0
    }
}
