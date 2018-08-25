//
//  ViewController.swift
//  Testular
//
//  Created by Egor on 25.08.2018.
//  Copyright © 2018 Chernenko Inc. All rights reserved.
//

import UIKit
import CountryPickerIOS

class ViewController: UIViewController {

    var countryPickerView: CountryPickerView?
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryPickerView = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 100, height: textField.bounds.height))
        countryPickerView?.delegate = self
        
        
        textField.leftView = countryPickerView
        textField.leftViewMode = .always
    }

}

extension ViewController: CountryPickerListDelegate {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        debugPrint("Selected country \(country)")
    }
    
    func showCountryList(output: CountryPickerListOutput) {
        let countryList = CountryPickerList(style: .grouped)
        countryList.output = output
        
        navigationController?.pushViewController(countryList, animated: true)
    }
    
    
}
