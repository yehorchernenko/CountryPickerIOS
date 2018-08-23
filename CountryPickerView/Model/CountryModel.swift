//
//  CountryModel.swift
//  CountryPickerView
//
//  Created by Yehor Chernenko on 8/22/18.
//  Copyright © 2018 Yehor Chernenko. All rights reserved.
//

import Foundation

public struct CountryModel {
    
    public var countries: [Country] = {
        var countries = [Country]()
        let bundle = Bundle(for: CountryPickerView.self)
        guard let jsonPath = bundle.path(forResource: "CountryPickerView.bundle/Data/CountryCodes", ofType: "json"),
            let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) else {
                return countries
        }
        
        if let jsonObjects = (try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization
            .ReadingOptions.allowFragments)) as? [Any] {
            
            for jsonObject in jsonObjects {
                
                guard let countryObj = jsonObject as? [String: Any] else {
                    continue
                }
                
                guard let name = countryObj["name"] as? String,
                    let code = countryObj["code"] as? String,
                    let phoneCode = countryObj["dial_code"] as? String else {
                        continue
                }
                
                let country = Country(name: name, code: code, phoneCode: phoneCode)
                countries.append(country)
            }
            
        }
        
        return countries
    }()
    
    //Wrap countries to alphabetic dict
    func countriesAlphabetic() -> [String: [Country]] {
        //unique headers for section
        var header = Set<String>()
        countries.forEach {
            let name = $0.name
            header.insert(String(name[name.startIndex]).uppercased())
        }
        
        var alphabeticDict = [String: [Country]]()
        
        //sorted countries by headers
        countries.forEach({
            let name = $0.name
            let index = String(name[name.startIndex])
            var dictValue = alphabeticDict[index] ?? [Country]()
            dictValue.append($0)
            
            alphabeticDict[index] = dictValue
        })
        
        // Sort the sections
        alphabeticDict.forEach { key, value in
            alphabeticDict[key] = value.sorted {$0.name < $1.name}
        }
        return alphabeticDict
    }
    
    //Define postion of country in alphabetic order
    func getCountryPosition(countryName: String) -> IndexPath? {
        let header = String(countryName[countryName.startIndex])
        let alphabeticCountries = countriesAlphabetic()
        let countryArray = Array(alphabeticCountries).sorted { $0.key  < $1.key }

        guard let section = countryArray.index(where: { $0.key == header }) else { return nil}
        guard let row = alphabeticCountries[header]?.index(where: { $0.name.lowercased() == countryName.lowercased()}) else { return nil}
        
        return IndexPath(row: row, section: section)
    }
    
    //Search countries by name, e.g. - search bar
    func getCountries(byName name: String) -> [Country] {
        let alphabeticCountries = countriesAlphabetic()
        guard let array = alphabeticCountries[String(name[name.startIndex]).uppercased()] else { return  [Country]() }
        
        return array.filter({ $0.name.lowercased().hasPrefix(name.lowercased())})
    }
}
