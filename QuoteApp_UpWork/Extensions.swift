//
//  Extensions.swift
//  QuoteApp_UpWork
//
//  Created by Abdurakhmon Jamoliddinov on 2/11/21.
//

import Foundation
import UIKit

extension UIColor {
    static func random() -> UIColor {
        let colors = [UIColor.red, .green, .orange, .yellow, .blue]
        return colors.randomElement()!
    }
}
