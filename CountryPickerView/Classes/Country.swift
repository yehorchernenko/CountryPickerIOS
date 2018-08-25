//
//  Country.swift
//  CountryPickerView
//
//  Created by Yehor Chernenko on 8/22/18.
//  Copyright © 2018 Yehor Chernenko. All rights reserved.
//

import UIKit

public struct Country {
    public var name: String
    public var code: String
    public var phoneCode: String
    public var flag: UIImage {
        return UIImage(named: "CountryPickerView.bundle/Images/\(code.uppercased())",
            in: Bundle(for: CountryPickerView.self), compatibleWith: nil)!
    }
    
    internal init(name: String, code: String, phoneCode: String) {
        self.name = name
        self.code = code
        self.phoneCode = phoneCode
    }
}

public func == (lhs: Country, rhs: Country) -> Bool {
    return lhs.code == rhs.code
}
public func != (lhs: Country, rhs: Country) -> Bool {
    return lhs.code != rhs.code
}
