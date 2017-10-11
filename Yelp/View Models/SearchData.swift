//
//  SearchData.swift
//  Yelp
//
//  Created by Đoàn Minh Hoàng on 10/11/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import Foundation

struct SearchData {
    var distance: Int!
    var categories: [String]!
    var deal: Bool!
}

class searchDataViewModel {
    var datas = SearchData()
    func convertData(_ distance: AnyObject, _ categories: AnyObject, _ deal: AnyObject) {
        self.datas.distance = distance as! Int
        self.datas.categories = categories as! [String]
        self.datas.deal = categories as! Bool
    }
}
