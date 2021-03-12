//
//  DesignableLabel.swift
//  SnapKit IB
//
//  Created by Isaiah Turner on 3/12/21.
//

import UIKit

@IBDesignable class DesignableLabel: UILabel {
    @IBInspectable var isRedText: Bool = false {
        didSet {
            self.textColor = isRedText ? .red : .black
        }
    }
}
