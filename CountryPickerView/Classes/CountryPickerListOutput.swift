//
//  CountryPickerListDelegate.swift
//  CountryPickerView
//
//  Created by Yehor Chernenko on 8/22/18.
//  Copyright © 2018 Yehor Chernenko. All rights reserved.
//

import Foundation

public protocol CountryPickerListOutput: AnyObject {
    func didSelectCountry(_ country: Country)
    func getSelectedCountry() -> Country
    func getCountryModel() -> CountryModel
}
