//
//  SearchViewController.swift
//  Lightweight Tunes Catalog
//
//  Created by Christopher Giersch on 4/6/20.
//  Copyright © 2020 Cognizant. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

  @IBOutlet weak var searchBar: UISearchBar!
  
  let mediaDictionary: [String : [Media]]? = nil
  let searchAPI = ITunesSearchAPI()
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension SearchViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    self.searchAPI.getMediaResults(withString: searchBar.text!) { (searchResults, error) in
      print(searchResults)
    }
  }
  
}
