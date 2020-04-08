//
//  SearchViewController.swift
//  Lightweight Tunes Catalog
//
//  Created by Christopher Giersch on 4/6/20.
//  Copyright © 2020 Cognizant. All rights reserved.
//

import UIKit
import SafariServices

class SearchViewController: UIViewController {
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  
  let searchAPI = ITunesSearchAPI()
  var resultsArray: [Media] = [] {
    willSet(newResultsArray) {
      resultsDictionary = Dictionary(grouping: newResultsArray, by: { ($0.kind ?? "other") })
      createSections()
    }
  }
  var resultsDictionary: [String : [Media]] = [:]
//  var sections: [String] = ["favorites"]
  var sections: [String] = []

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.hideKeyboardWhenTappedAround()
  }
  
  func createSections() {
    let newSections = Array<String>(resultsDictionary.keys)
//    sections = sections + newSections.sorted()
    sections = newSections.sorted()
  
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  
}


extension SearchViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let sectionArray = resultsDictionary[self.sections[indexPath.section]]
    let media = sectionArray?[indexPath.row]
    if let urlString = media?.url, let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
      print("Opening external link: \(urlString)")
      UIApplication.shared.open(url, options: [.universalLinksOnly : true]) { (success) in
        if !success {
          let safariVC = SFSafariViewController(url: url)
          self.present(safariVC, animated: true, completion: nil)
        }
      }
    }
  }
}


extension SearchViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let sectionKey = self.sections[section]
    return resultsDictionary[sectionKey]?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MediaCell", for: indexPath) as! MediaCell
    let sectionArray = resultsDictionary[self.sections[indexPath.section]]
    let media = sectionArray?[indexPath.row]
    cell.media = media
    return cell
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sections[section].capitalized
  }
  
}

extension SearchViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    dismissKeyboard()
    
    self.searchAPI.getMediaResults(withString: searchBar.text!) { (searchResults, error) in
      if error != nil {
        print("Search Error: \(error!)")
      } else {
        /// Organize Search Results
        if let results = searchResults?.results {
          self.resultsArray = results
          
        }
      }
    }
  }
  
}

extension UIViewController {
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(
      target: self,
      action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}
