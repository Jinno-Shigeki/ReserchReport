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
    private let view: FirstViewProtocol
    var reportArray: [ReportData] = []
    private var loadStatus: String = "initial"
    var startNumber = 1
    var dataItems = 0
    
    required init(view: FirstViewProtocol) {
        self.view = view
    }
    
    func getReport(searchKey: String, firstLoading: Bool) {
        if firstLoading{
            refreshData()
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
   
    func refreshData() {
        reportArray.removeAll()
    }
}

