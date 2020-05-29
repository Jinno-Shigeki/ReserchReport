//
//  DetailViewController.swift
//  ReportReserch
//
//  Created by 神野成紀 on 2020/05/29.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var Presenter = DetailViewPresenter()
    var reportData: ReportData?
    
    @IBOutlet private weak var detailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.register(UINib(nibName: reprotListCellData.cellIdentifier2, bundle: nil), forCellReuseIdentifier: reprotListCellData.cellIdentifier2)
    }
}
//MARK: - UITableViewDelegate
extension DetailViewController: UITableViewDelegate {
    
}
//MARK: -
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reprotListCellData.cellIdentifier2, for: indexPath) as! DetailTableViewCell
        if indexPath.row == 0 {
            cell.cellTitle.text = DetailTableViewCellData.title
            cell.contentLabel.text = reportData?.title
        } else if indexPath.row == 1 {
            cell.cellTitle.text = DetailTableViewCellData.authors
            cell.contentLabel.text = reportData?.getAuthorsName()
        } else if indexPath.row == 2 {
            cell.cellTitle.text = DetailTableViewCellData.discription
        } else if indexPath.row == 3 {
            cell.cellTitle.text = DetailTableViewCellData.publisher
            cell.contentLabel.text = reportData?.publisher
        } else if indexPath.row == 4 {
            cell.cellTitle.text = DetailTableViewCellData.date
            cell.contentLabel.text = reportData?.date
        } else if indexPath.row == 5 {
            cell.cellTitle.text = DetailTableViewCellData.reportLink
            cell.contentLabel.text = reportData?.reportLink
        }
        return cell
    }
}

