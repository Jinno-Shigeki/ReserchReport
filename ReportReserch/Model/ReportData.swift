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
    let authors: [String]
    let reportLink: String
    let publisher: String
    let date: String
    let description: String
    
    init(json: JSON) {
        self.title = json["title"].string ?? "Title"
        self.reportLink = json["link"]["@id"].string ?? ""
        self.publisher = json["dc:publisher"].string ?? ""
        self.date = json["dc:date"].string ?? ""
        self.authors = json["dc:creator"].arrayValue.map {$0["@value"].stringValue}
        self.description = json["description"].string ?? "Non description"
    }
    
    func getAuthorsName() -> String {
        var authorsName = ""
        authors.forEach { (name) in
            authorsName += (name + "  ")
        }
        return authorsName
    }
}


