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
import Firebase

class FirstViewPresenter {
    let db = Firestore.firestore()
    private let view: FirstViewProtocol
    var reportArray: [ReportData] = []
    var bookmarkArray: [BookmarkData] = []
    private var loadStatus: String = "initial"
    var gotID = ""
    var startNumber = 1
    var dataItems = 0
    
    required init(view: FirstViewProtocol) {
        self.view = view
    }
    
    func getReport(searchKey: String, firstLoading: Bool) {
        if firstLoading{
            refreshReportArray()
            startNumber = 1
        }
        let urlString = "https://ci.nii.ac.jp/opensearch/search?appid=crUCRy1i2aOgtZxpEihA&format=json&lang=ja&count=   20&start=\(startNumber)&q=\(searchKey)"
        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let url = URL(string: encoded){
            Alamofire.request(url, method: .get).responseJSON { [weak self](response) in
                guard let self = self else {return}
                guard let data = response.result.value else {return}
                let json = JSON(data)
                let jsonArray = json["@graph"][0]["items"]
                jsonArray.forEach { (_, json) in
                    self.reportArray.append(ReportData(json: json))
                }
                self.dataItems = jsonArray.count
                self.startNumber += 20
                self.view.reloadData()
            }
        }
    }
    
    func refreshReportArray() {
        reportArray.removeAll()
    }
    
    func setID(length: Int) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomID: String = ""
        for _ in 0..<length {
            let randomString = base.randomElement()
            randomID += String(randomString!)
        }
        return randomID
    }
    
    func sendUserID(userID: String) {
        db.collection("users").document(userID).setData(["id" : userID]){ err in
            if let err = err {
                print("Error adding document")
            } else {
                print("Document added")
            }
        }
    }
    
    func getBookmark(userID: String) {
        refreshBookmarkArray()
        db.collection("users").document(userID).collection(userID).getDocuments() { [weak self](querySnapshot, err) in
            guard let self = self else {return}
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.bookmarkArray.append(BookmarkData(document: document))
                    }
                self.view.reloadData()
            }
        }
    }
    
    func refreshBookmarkArray() {
        bookmarkArray.removeAll()
    }
}

