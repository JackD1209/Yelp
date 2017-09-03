//
//  FilterList.swift
//  Yelp
//
//  Created by Đoàn Minh Hoàng on 9/1/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

protocol FilterListDelegate {
    func filterList(updatedValue filters: [String : AnyObject])
}

class FilterList: UIViewController, UITableViewDelegate, UITableViewDataSource, DistanceCellDelegate, SortByCellDelegate, SwitchCellDelegate {
    
    @IBOutlet weak var filterTable: UITableView!
    
    // Set up data for 4 section in tableview
    let sectionArray = ["Offering", "Distance", "Sort By", "Category"]
    let distanceArray = [["name" : "Auto", "code" : nil], ["name" : "0.3 miles", "code" : 480], ["name" : "1 miles", "code" : 1600], ["name" : "5 miles", "code" : 8000], ["name" : "20 miles", "code" : 32000]] as [AnyObject]
    let sortByArray = [["name" : "Best Match", "code" : 1], ["name" : "Distance", "code" : 2], ["name" : "Rating", "code" : 3]]
    let categoryArray = [["name" : "American (Traditional)", "code" : "tradamerican"], ["name" : "Asian Fusion", "code" : "asianfusion"], ["name" : "Australian", "code" : "australian"], ["name" : "Belgian", "code" : "belgian"], ["name" : "Brazilian", "code" : "brazilian"], ["name" : "Chinese", "code" : "chinese"], ["name" : "French", "code" : "french"], ["name" : "German", "code" : "german"], ["name" : "Greek", "code" : "greek"], ["name" : "Hungarian", "code" : "hungarian"], ["name" : "Indian", "code" : "indpak"], ["name" : "Irish", "code" : "irish"], ["name" : "Italian", "code" : "italian"], ["name" : "Japanese", "code" : "japanese"], ["name" : "Korean", "code" : "korean"], ["name" : "Mexican", "code" : "mexican"], ["name" : "Russian", "code" : "russian"], ["name" : "Spanish", "code" : "spanish"], ["name" : "Syrian", "code" : "syrian"], ["name" : "Thai", "code" : "thai"], ["name" : "Turkish", "code" : "turkish"], ["name" : "Vietnamese", "code" : "vietnamese"]]
    
    var didCategoryExpand = false
    var didDistanceExpand = false
    var didDistanceClicked = false
    var didSortByExpand = false
    var didSortByClicked = false
    var selectedDistanceRowIndex = 0
    var selectedSortByRowIndex = 0
    var selectedCategory = [Int : Bool]()
    
    // Variable to store selected filters
    var filterValue = [String : AnyObject]()
    
    var delegate: FilterListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionArray[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: // Set up data for offering section
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell") as! SwitchCell
            cell.switchToggle.isOn = false
            cell.switchLabel.text = "Offering a Deal"
            cell.delegate = self
            if cell.switchToggle.isOn {
                filterValue["deal"] = true as AnyObject
            }
            else {
                filterValue["deal"] = false as AnyObject
            }
            return cell
        case 1: // Set up data for distance section
            let cell = tableView.dequeueReusableCell(withIdentifier: "DistanceCell") as! DistanceCell
            cell.delegate = self
            
            switch indexPath.row {
            case 0:
                cell.distanceLabel.text = distanceArray[indexPath.row]["name"] as? String
                if didDistanceExpand {
                    cell.distanceImage.image = UIImage(named: "uncheck")
                    
                }
                else {
                    cell.distanceImage.image = UIImage(named: "arrow")
                }
                if !didDistanceExpand && didDistanceClicked {
                    cell.distanceImage.image = UIImage(named: "check")
                    filterValue["distance"] = distanceArray[indexPath.row]["code"] as AnyObject
                }
            case 1:
                cell.distanceLabel.text = distanceArray[indexPath.row]["name"] as? String
                if didDistanceExpand {
                    cell.distanceImage.image = UIImage(named: "uncheck")
                    
                }
                else {
                    cell.distanceImage.image = UIImage(named: "check")
                    filterValue["distance"] = distanceArray[indexPath.row]["code"] as AnyObject
                }
            case 2:
                cell.distanceLabel.text = distanceArray[indexPath.row]["name"] as? String
                if didDistanceExpand {
                    cell.distanceImage.image = UIImage(named: "uncheck")
                }
                else {
                    cell.distanceImage.image = UIImage(named: "check")
                    filterValue["distance"] = distanceArray[indexPath.row]["code"] as AnyObject
                }
            case 3:
                cell.distanceLabel.text = distanceArray[indexPath.row]["name"] as? String
                if didDistanceExpand {
                    cell.distanceImage.image = UIImage(named: "uncheck")
                }
                else {
                    cell.distanceImage.image = UIImage(named: "check")
                    filterValue["distance"] = distanceArray[indexPath.row]["code"] as AnyObject
                }
            case 4:
                cell.distanceLabel.text = distanceArray[indexPath.row]["name"] as? String
                if didDistanceExpand {
                    cell.distanceImage.image = UIImage(named: "uncheck")
                }
                else {
                    cell.distanceImage.image = UIImage(named: "check")
                    filterValue["distance"] = distanceArray[indexPath.row]["code"] as AnyObject
                }
            default:
                break
            }
            return cell
        case 2: // Set up data for sort by section
            let cell = tableView.dequeueReusableCell(withIdentifier: "SortByCell") as! SortByCell
            cell.delegate = self
            
            switch indexPath.row {
            case 0:
                cell.sortByLabel.text = sortByArray[indexPath.row]["name"] as? String
                if didSortByExpand {
                    cell.sortByImage.image = UIImage(named: "uncheck")
                    
                }
                else {
                    cell.sortByImage.image = UIImage(named: "arrow")
                }
                if !didSortByExpand && didSortByClicked {
                    cell.sortByImage.image = UIImage(named: "check")
                    filterValue["sort"] = sortByArray[indexPath.row]["code"] as AnyObject
                }
            case 1:
                cell.sortByLabel.text = sortByArray[indexPath.row]["name"] as? String
                if didSortByExpand {
                    cell.sortByImage.image = UIImage(named: "uncheck")
                    
                }
                else {
                    cell.sortByImage.image = UIImage(named: "check")
                    filterValue["sort"] = sortByArray[indexPath.row]["code"] as AnyObject
                }
            case 2:
                cell.sortByLabel.text = sortByArray[indexPath.row]["name"] as? String
                if didSortByExpand {
                    cell.sortByImage.image = UIImage(named: "uncheck")
                }
                else {
                    cell.sortByImage.image = UIImage(named: "check")
                    filterValue["sort"] = sortByArray[indexPath.row]["code"] as AnyObject
                }
            default:
                break
            }
            return cell
        case 3: // Set up data for category section
            if didCategoryExpand {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell") as! SwitchCell
                cell.switchToggle.isOn = selectedCategory[indexPath.row] ?? false
                cell.switchLabel.text = categoryArray[indexPath.row]["name"]
                cell.delegate = self
                return cell
            }
            else {
                if indexPath.row < 3 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell") as! SwitchCell
                    cell.switchToggle.isOn = selectedCategory[indexPath.row] ?? false
                    cell.switchLabel.text = categoryArray[indexPath.row]["name"]
                    cell.delegate = self
                    return cell
                }
                else {
                    let cell = filterTable.dequeueReusableCell(withIdentifier: "SeeAllCell")! as UITableViewCell
                    return cell
                }
            }
        default:
            return UITableViewCell()
        }
    }
    
    // When the arrow down is clicked, it will change the height of hidden cells so that it can appear
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            if didDistanceExpand {
                return 75
            }
            else {
                return indexPath.row == selectedDistanceRowIndex ? 75 : 0
            }
        case 2:
            if didSortByExpand {
                return 75
            }
            else {
                return indexPath.row == selectedSortByRowIndex ? 75 : 0
            }
        default:
            return 75
        }
    }
    
    // Check if See All  is clicked or not
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            if !didCategoryExpand {
                if indexPath.row == 3 {
                    didCategoryExpand = true
                    filterTable.reloadSections(NSIndexSet(index: indexPath.section) as IndexSet, with: .automatic)
                }
            }
        }
    }
    
    // Delegate from DistanceCell to check whenever the arrow is clicked to expand the hidden options
    func distanceCell(dropCell: DistanceCell, didClick imageClicked: UIImage) {
        if let index = filterTable.indexPath(for: dropCell) {
            if index.section == 1 {
                switch imageClicked {
                case UIImage(named: "arrow")!:
                    didDistanceExpand = true
                case UIImage(named: "check")!:
                    didDistanceExpand = false
                case UIImage(named: "uncheck")!:
                    didDistanceExpand = false
                default:
                    break
                }
                if let selectedIndex = filterTable.indexPath(for: dropCell) {
                    selectedDistanceRowIndex = selectedIndex.row
                }
                filterTable.reloadSections(NSIndexSet(index: 1) as IndexSet, with: UITableViewRowAnimation.automatic)
            }
        }
        didDistanceClicked = true
    }
    
    // Delegate from SortByCell to check whenever the arrow is clicked to expand the hidden options
    func sortByCell(dropCell: SortByCell, didClick imageClicked: UIImage) {
        if let index = filterTable.indexPath(for: dropCell) {
            if index.section == 2 {
                switch imageClicked {
                case UIImage(named: "arrow")!:
                    didSortByExpand = true
                case UIImage(named: "check")!:
                    didSortByExpand = false
                case UIImage(named: "uncheck")!:
                    didSortByExpand = false
                default:
                    break
                }
                if let selectedIndex = filterTable.indexPath(for: dropCell) {
                    selectedSortByRowIndex = selectedIndex.row
                }
                filterTable.reloadSections(NSIndexSet(index: 2) as IndexSet, with: UITableViewRowAnimation.automatic)
            }
        }
        didSortByClicked = true
    }
    
    // Delegate from SwitchCell to get bool value whenever the swith is togged
    func switchCell(switchCell: SwitchCell, didSwitch value: Bool) {
        let index = filterTable.indexPath(for: switchCell)
        if index?.section == 0 {
            filterValue["deal"] = value as AnyObject?
        }
        else {
            selectedCategory[index!.row] = value
        }
    }
    
    // Filtered search function with selected filters
    @IBAction func filteredSearch(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        var finalSelectedCategories = [String]()
        for (index, isSelected) in selectedCategory {
            if isSelected {
                finalSelectedCategories.append(categoryArray[index]["code"]!)
            }
        }
        filterValue["categories"] = finalSelectedCategories as AnyObject
        // Delegate to send selected filters to RestaurantList
        delegate?.filterList(updatedValue: filterValue)
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
