//
//  RestaurantsList.swift
//  RestaurantsFinder
//
//  Created by Đoàn Minh Hoàng on 7/16/17.
//  Copyright © 2017 Đoàn Minh Hoàng. All rights reserved.
//

import UIKit
import MBProgressHUD

class RestaurantsList: UIViewController {

    @IBOutlet weak var restaurantsList: UITableView!
    
    var searchData = searchDataViewModel()
    var businesses: [Business]?
    var filteredBusinesses: [Business]?
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        // Pull to refresh
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        restaurantsList.insertSubview(refreshControl, at: 0)
        
        restaurantsList.delegate = self
        restaurantsList.dataSource = self
        restaurantsList.estimatedRowHeight = 100
        restaurantsList.rowHeight = UITableViewAutomaticDimension
        
        // Display HUD right before the request is made
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.label.text = "Loading Restaurant"
        
        Business.search(with: "restaurants") { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses {
                self.businesses = businesses
                self.restaurantsList.reloadData()
                // end refresh controll action when finish fetch data
                refreshControl.endRefreshing()
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
        
        // Set up search bar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        // Do any additional setup after loading the view.
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        // Display HUD right before the request is made
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.label.text = "Loading Restaurant"
        
        // ... Use the new data to update the data source ...
        Business.search(with: "restaurants") { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses {
                self.businesses = businesses
                // Reload the tableView now that there is new data
                self.restaurantsList.reloadData()
                // Tell the refreshControl to stop spinning
                refreshControl.endRefreshing()
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredBusinesses = businesses!.filter { businesse -> Bool in
            return (businesse.name?.lowercased().contains((searchText.lowercased())))!
        }
        restaurantsList.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filterSegue" {
            let filterVC = segue.destination as! FilterList
            filterVC.delegate = self
        }
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

extension RestaurantsList: UITableViewDelegate, UITableViewDataSource {
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
        
        cell.nameLabel.text = business.name
        cell.distanceLabel.text = business.distance
        cell.resImage.setImageWith(business.imageURL!)
        cell.rateImage.setImageWith(business.ratingImageURL!)
        cell.reviewLabel.text = (business.reviewCount?.stringValue)! + " Reviews"
        cell.addLabel.text = business.address
        cell.cateLabel.text = business.categories
        
        return cell
    }
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

extension RestaurantsList: FilterListDelegate {
    // Delegate from FilterList to get filtered data
    func filterList(updatedValue filters: [String : AnyObject]) {
        searchData.convertData(filters["distance"]!, filters["categories"]!, filters["deal"]!)
        Business.search(with: "restaurants", distance: searchData.datas.distance , sort: filters["sort"].map { YelpSortMode(rawValue: $0 as! Int) }!, categories: searchData.datas.categories, deals: searchData.datas.deal) { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses {
                self.businesses = businesses
                self.restaurantsList.reloadData()
            }
        }
    }
}
