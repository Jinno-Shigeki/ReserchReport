//
//  BookmarkData.swift
//  ReportReserch
//
//  Created by 神野成紀 on 2020/06/03.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import Foundation
import Firebase

struct BookmarkData {
    let title: String?
    let authors: String?
    let description: String?
    let publisher: String?
    let date: String?
    let link: String?
    
    init(document: QueryDocumentSnapshot) {
        self.title = document.get("title") as? String
        self.authors = document.get("authors") as? String
        self.description = document.get("description") as? String
        self.publisher = document.get("publisher") as? String
        self.date = document.get("date") as? String
        self.link = document.get("link") as? String
    }
}

    

