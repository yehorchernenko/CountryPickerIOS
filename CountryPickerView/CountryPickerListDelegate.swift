//
//  CountryPickerViewDelegate.swift
//  CountryPickerView
//
//  Created by Yehor Chernenko on 8/22/18.
//  Copyright © 2018 Yehor Chernenko. All rights reserved.
//

import UIKit

public protocol CountryPickerListDelegate: AnyObject {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country)
    
    func showCountryList(output: CountryPickerListOutput)
}

// MARK: - Default implementation
extension CountryPickerListDelegate {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {}
}
