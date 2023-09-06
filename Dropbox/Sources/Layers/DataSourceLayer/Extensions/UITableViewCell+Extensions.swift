//
//  UITableViewCell+Extensions.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 04.09.2023.
//

import UIKit

extension UITableViewCell {

    class func identifier() -> String {
        return String(describing: self)
    }
}
