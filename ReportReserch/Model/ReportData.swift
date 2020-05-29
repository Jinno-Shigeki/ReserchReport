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
    
    init(json: JSON) {
        self.title = json["title"].string ?? "Title"
        self.reportLink = json["link"]["@id"].string ?? ""
        self.publisher = json["dc:publisher"].string ?? ""
        self.date = json["dc:publisher"].string ?? ""
        self.authors = json["dc:creator"].arrayValue.map {$0["@value"].stringValue}
    }
}


