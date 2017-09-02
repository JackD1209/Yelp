//
//  RestaurantsList.swift
//  RestaurantsFinder
//
//  Created by Đoàn Minh Hoàng on 7/16/17.
//  Copyright © 2017 Đoàn Minh Hoàng. All rights reserved.
//

import UIKit

class RestaurantsList: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var restaurantsList: UITableView!
    var businesses: [Business]?
    var filteredBusinesses: [Business]?
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantsList.delegate = self
        restaurantsList.dataSource = self
        restaurantsList.estimatedRowHeight = 100
        restaurantsList.rowHeight = UITableViewAutomaticDimension
        
        Business.search(with: "Americans") { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses {
                self.businesses = businesses
                self.restaurantsList.reloadData()
            }
        }
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        restaurantsList.tableHeaderView = searchController.searchBar
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredBusinesses!.count
        }
        return businesses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantsDetail
        
        let business: Business
        if searchController.isActive && searchController.searchBar.text != "" {
            business = (filteredBusinesses?[indexPath.row])!
        }
        else {
            business = (businesses?[indexPath.row])!
        }
        
//        if let businesses = businesses {
            cell.nameLabel.text = business.name
            cell.distanceLabel.text = business.distance
            cell.resImage.setImageWith(business.imageURL!)
            cell.rateImage.setImageWith(business.ratingImageURL!)
            cell.reviewLabel.text = (business.reviewCount?.stringValue)! + " Reviews"
            cell.addLabel.text = business.address
            cell.cateLabel.text = business.categories
//        }
        return cell
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredBusinesses = businesses!.filter { businesse -> Bool in
            return (businesse.name?.lowercased().contains((searchText.lowercased())))!
        }
        restaurantsList.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RestaurantsList: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
}

extension RestaurantsList: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
