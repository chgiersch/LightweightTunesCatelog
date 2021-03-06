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
  var resultsDictionary: [String : [Media]] = [:] {
    willSet {
      sections = Array<String>(newValue.keys).sorted()
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  var favoritesDictionary: [String : [Media]] = [:]
  var favorites: Favorites = Favorites()
  var sections: [String] = []

  
  override func viewDidLoad() {
    super.viewDidLoad()
    favoritesDictionary = ["favorites" : Array(favorites.mediaSet)]
    resultsDictionary = favoritesDictionary
    
    let favoritesButton = UIButton(type: .custom)
    favoritesButton.setImage(UIImage(systemName: "heart"), for: .normal)
    favoritesButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
    favoritesButton.frame = CGRect(x: 0, y: 0, width: 53, height: 51)

    let barButton = UIBarButtonItem(customView: favoritesButton)
    self.navigationItem.rightBarButtonItem = barButton
    
    hideKeyboardWhenTappedAround()
  }
  
  @objc func didTapFavoriteButton() {
    let favoritesArray = Array(Favorites().mediaSet)
    self.resultsDictionary = ["favorites" : favoritesArray]
    self.searchBar.text = ""
  }
  
}

extension SearchViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let sectionArray = resultsDictionary[self.sections[indexPath.section]]
    let media = sectionArray?[indexPath.row]
    if let urlString = media?.url, let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
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
    cell.favorites = self.favorites
    if favorites.contains(media!) {
      cell.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    } else {
      cell.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
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
        if let results = searchResults?.results {
          self.resultsDictionary = Dictionary(grouping: results, by: { ($0.kind ?? "other") })
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
