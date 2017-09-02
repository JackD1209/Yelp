//
//  FilterList.swift
//  Yelp
//
//  Created by Đoàn Minh Hoàng on 9/1/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

class FilterList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var filterTable: UITableView!
    
    let sectionArray = ["Offering", "Distance", "Sort By", "Category"]
    let distanceArray = ["Auto", "0.3 miles", "1 miles", "5 miles", "20 miles"]
    let sortByArray = ["Best Match", "Distance", "Rating"]
    let categoryArray = ["Afghan", "African", "American (New)", "American (Tranditional)", "Arabian", "Argentine", "Armenian", "Asian Fusion", "Asturian", "Australian", "Austrian", "Baguettes", "Bangladeshi", "Barbecue", "Basque"]
    var didCategoryExpand = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterTable.delegate = self
        filterTable.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        switch section {
    case 0: // section offering
        return 1
    case 1: // section distance
        return distanceArray.count
    case 2: // section sort by
        return sortByArray.count
    case 3: // section category
        if didCategoryExpand {
            return categoryArray.count
        }
        else {
            return 4
        }
    default:
        return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // set cell content
        switch  section {
        case 0:
            var cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell") as! SwitchCell
            cell.switchLabel.text = "Offering a Deal"
        case 1:
            <#code#>
        case 2:
            <#code#>
        case 3:
            <#code#>
        default:
            <#code#>
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionArray[section]
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
