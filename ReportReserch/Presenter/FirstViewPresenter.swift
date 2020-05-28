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
    var reportArray: [ReportData] = [ReportData(json: "", count: 0)]
    var titleCount = 0
    
    required init(view: FirstViewProtocol) {
        self.view = view
    }
    func getReport(searchKey: String) {
        refreshData()
        let urlString = "https://ci.nii.ac.jp/opensearch/search?appid=crUCRy1i2aOgtZxpEihA&format=json&count=20&q=\(searchKey)"
        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let url = URL(string: encoded){
            Alamofire.request(url, method: .get).responseJSON { [weak self](response) in
                guard let self = self else {return}
                    guard let data = response.result.value else {return}
                    let json = JSON(data)
                while self.reportArray.count < 20 {
                    self.reportArray.append(ReportData(json: json, count: self.titleCount))
                    self.titleCount += 1
                }
                
                self.view.reloadData()
            }
        }
    }
    func refreshData(){
        reportArray.removeAll()
        titleCount = 0
    }
}

