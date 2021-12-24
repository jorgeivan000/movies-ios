//
//  UIViewController+Access.swift
//  MoviesApp
//
//  Created by Jorge Herrera on 5/29/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//

import Foundation
import Photos
import AVFoundation
import UIKit

extension UIViewController {
    func authorizeToCamera(_ audioPermissionsRequired: Bool = false, completion: @escaping (Bool) -> Void) {
        let audioPermissionsAutorized = audioPermissionsRequired ? AVCaptureDevice.authorizationStatus(for: .audio) ==  .authorized : true
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized && audioPermissionsAutorized {
            DispatchQueue.main.async(execute: {
                completion(true)
            })
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                    if audioPermissionsRequired {
                        AVCaptureDevice.requestAccess(for: .audio, completionHandler: { (granted: Bool) in
                            DispatchQueue.main.async(execute: {
                                completion(granted)
                            })
                        })
                    } else {
                        DispatchQueue.main.async(execute: {
                            completion(true)
                        })
                    }
                } else {
                    DispatchQueue.main.async(execute: {
                        completion(false)
                    })
                }
            })
        }
    }
    
    func authorizeToGallery(completion:@escaping (Bool) -> Void) {
        if PHPhotoLibrary.authorizationStatus() != .authorized {
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status == .authorized {
                    DispatchQueue.main.async(execute: {
                        completion(true)
                    })
                } else {
                    DispatchQueue.main.async(execute: {
                        completion(false)
                    })
                }
            })
        } else {
            DispatchQueue.main.async(execute: {
                completion(true)
            })
        }
    }
}
