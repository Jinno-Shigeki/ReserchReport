//
//  FirstViewPresenter.swift
//  ReportReserch
//
//  Created by 神野成紀 on 2020/05/26.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class FirstViewPresenter {
    var titleCount = 0
    var reportArray: [String] = []
    
    func getReport(searchKey: String) {
        let urlString = "https://ci.nii.ac.jp/opensearch/search?appid=crUCRy1i2aOgtZxpEihA&format=json&count=20&q=\(searchKey)"
        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let url = URL(string: encoded){
                Alamofire.request(url, method: .get).responseJSON { (response) in
                    guard let data = response.result.value else {return}
                    let json = JSON(data)
                    while self.reportArray.count < 20 {
                        self.reportArray.append(json["@graph"][0]["items"][self.titleCount]["title"].string!)
                        self.titleCount += 1
                }
            }
        }
    }
}

