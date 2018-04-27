//
//  L10n.swift
//  Bookshelf
//
//  Created by Mario on 27/4/18.
//  Copyright © 2018 Mario Negro. All rights reserved.
//

import Foundation

enum L10n: String {
    case detail
}

extension L10n: Localizable {
    var localized: String {
        return self.rawValue.localized
    }
}
