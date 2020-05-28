//
//  ReportData.swift
//  ReportReserch
//
//  Created by 神野成紀 on 2020/05/27.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ReportData {
    let title: String
    var authors: [String] 
    let reportLink: String
    let publisher: String
    let date: String
    
    
    init(json: JSON, count: Int) {
        self.title = json["@graph"][0]["items"][count]["title"].string ?? "Title"
        self.reportLink = json["@graph"][0]["items"][count]["link"]["@id"].string ?? ""
        self.publisher = json["@graph"][0]["items"][count]["dc:publisher"].string ?? ""
        self.date = json["@graph"][0]["items"][count]["dc:date"].string ?? ""
        if json == "" {
            self.authors = ["Authors"]
        } else {
        self.authors =  json["@graph"][0]["items"][count]["dc:creator"].arrayValue.map {$0["@value"].stringValue}
        }
    }
}
