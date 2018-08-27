//
//  CountryPickerList.swift
//  CountryPickerView
//
//  Created by Yehor Chernenko on 8/22/18.
//  Copyright © 2018 Yehor Chernenko. All rights reserved.
//

import UIKit

public class CountryPickerList: UITableViewController {
    private enum PresentationStyle {
        case pushed
        case presented
    }
    // MARK: - Output
    public weak var output: CountryPickerListOutput!
    
    // MARK: - Variables
    private var searchResults = [Country]()
    private var isSearchMode = false
    private var sectionsTitles = [String]()
    private var countries = [String: [Country]]()
    private var countryModel: CountryModel!
    private let searchController = UISearchController(searchResultsController: nil)
    private var presentationStyle: PresentationStyle = .pushed
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        countryModel = output.getCountryModel()
        definePresentationStyle()
        prepareTableItems()
        tableView.reloadData()
        scrollToSelectedCountry()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //add search bar with animation
        prepareSearchBar()
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.view.layoutSubviews()
        }
        
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //fix bag with black line on IOS 11.0+ that appears after pop
        navigationController?.view.layoutSubviews()
    }
}

// MARK: - Private
extension CountryPickerList {
    private func definePresentationStyle() {
        presentationStyle = navigationController == nil ? .presented : .pushed
    }
    
    private func prepareTableItems() {
        let countriesAlphabetic = countryModel.countriesAlphabetic()
        
        sectionsTitles = countriesAlphabetic.keys.sorted()
        countries = countriesAlphabetic
    }
    
    private func prepareSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        
        switch presentationStyle {
        case .presented:
            tableView.tableHeaderView = searchController.searchBar
            searchController.searchBar.showsCancelButton = true
            
        case .pushed:
            navigationItem.titleView = searchController.searchBar
        }
    }
    
    private func scrollToSelectedCountry() {
        if !isSearchMode {
            let countryName = output.getSelectedCountry().name
            guard let indexPath = countryModel.getCountryPosition(countryName: countryName) else { return }
            
            tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        }
    }
}

// MARK: - UITableViewDataSource
extension CountryPickerList {
    override public func numberOfSections(in tableView: UITableView) -> Int {
        return isSearchMode ? 1 : sectionsTitles.count
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchMode ? searchResults.count : countries[sectionsTitles[section]]!.count
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        let country = isSearchMode ? searchResults[indexPath.row]
            : countries[sectionsTitles[indexPath.section]]![indexPath.row]
        
        cell.imageView?.image = country.flag
        cell.textLabel?.text = country.name
        cell.accessoryType = country == output.getSelectedCountry() ? .checkmark : .none
        cell.separatorInset = .zero
        
        return cell
    }
    
    override public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return isSearchMode ? nil : sectionsTitles[section]
    }
    
    override public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return isSearchMode ? nil : sectionsTitles
    }
    
    override public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return sectionsTitles.index(of: title)!
    }
}

// MARK: - UITableViewDelegate
extension CountryPickerList {
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = isSearchMode ? searchResults[indexPath.row]
            : countries[sectionsTitles[indexPath.section]]![indexPath.row]
        output.didSelectCountry(country)
        
        switch presentationStyle {
        case .presented:
            dismiss(animated: true, completion: nil)
        case .pushed:
            navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - UISearchBarDelegate
extension CountryPickerList: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        isSearchMode = false
        if let text = searchController.searchBar.text, text.count > 0 {
            isSearchMode = true
            searchResults.removeAll()

            searchResults.append(contentsOf: countryModel.getCountries(byName: text))
        }
        tableView.reloadData()
    }
}

extension CountryPickerList: UISearchBarDelegate {
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // Hide the back/left navigationItem button
        navigationItem.hidesBackButton = true
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Show the back/left navigationItem button
        
        if presentationStyle == .presented {
            dismiss(animated: true, completion: nil)
        }
        navigationItem.hidesBackButton = false
    }
}
