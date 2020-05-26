//
//  ViewController.swift
//  ReportReserch
//
//  Created by 神野成紀 on 2020/05/24.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var reportList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reportList.delegate = self
        reportList.dataSource = self
        reportList.register(UINib(nibName: "ReportListCell", bundle: nil), forCellReuseIdentifier: "ReportListCell")
    }
}
//MARK: - UITableViewDelegate
extension FirstViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
//MARK: - UITableViewDataSource
extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReportListCell", for: indexPath) as! ReportListCell
        return cell
    }
}
