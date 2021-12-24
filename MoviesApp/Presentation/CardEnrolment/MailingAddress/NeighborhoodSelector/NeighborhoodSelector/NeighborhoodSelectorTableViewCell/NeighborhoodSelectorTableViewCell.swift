//
//  ServiceProductSelectorTableViewCell.swift
//  MoviesApp
//
//  Created by jorgehc on 4/15/20.
//  Copyright © 2020 jorgehc.com. All rights reserved.
//

import Foundation
import UIKit

class NeighborhoodSelectorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setSelectedColor(color: .weakGray)
    }
    
    override func setHighlighted(_ setHighlighted: Bool, animated: Bool) {
        super.setHighlighted(setHighlighted, animated: animated)
    }
}
