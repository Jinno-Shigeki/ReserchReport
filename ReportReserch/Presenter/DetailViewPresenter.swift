//
//  DetailViewPresenter.swift
//  ReportReserch
//
//  Created by 神野成紀 on 2020/05/29.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import Foundation
import Firebase

class DetailViewPresenter {
    let db = Firestore.firestore()
    
    func sendReportData(data: ReportData, userID: String) {
       db.collection("users").document(userID).collection("\(userID)").addDocument(data: ["authors": data.getAuthorsName(), "title": data.title, "publisher": data.publisher, "description": data.description, "link": data.reportLink, "date": data.date]){ err in
        if let err = err {
            print("Error adding document")
        } else {
            print("Document added")
            }
        }
    }
}
