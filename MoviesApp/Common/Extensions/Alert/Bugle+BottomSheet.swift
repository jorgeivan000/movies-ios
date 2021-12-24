//
//  AlertHandler.swift
//  MoviesApp
//
//  Refactor by jorgehc on 7/31/20.
//  Copyright © 2018 jorgehc.com. All rights reserved.
//

import UIKit
//TODO: Picker
final class AlertHandler {
    
    static func displayOptionsPicker(on controller: UIViewController, title: String = .empty, description: String, data: [String], completionHandler: @escaping (String) -> Void) {
        var currentTitle = title
        if currentTitle == .empty {
            currentTitle = String.chooseOption
        }
        let alert = UIAlertController(
            title: currentTitle,
            message: description,
            preferredStyle: .actionSheet
        )
        data.forEach {cardType in
            var style = UIAlertAction.Style.default
            if cardType.lowercased().contains("eliminar") { style = UIAlertAction.Style.destructive }
            let action = UIAlertAction.init(title: cardType, style: style, handler: {
                return completionHandler($0.title ?? "")
            })
            action.accessibilityLabel = cardType
            alert.addAction(action)
        }
        alert.addAction(title: .cancel, style: .cancel)
        controller.present(alert, animated: true, completion: nil)
    }
}
