//
//  DetailViewController.swift
//  ReportReserch
//
//  Created by 神野成紀 on 2020/05/29.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var presenter = DetailViewPresenter()
    var reportData: ReportData?
    var bookmarkData: BookmarkData?
    var tabNumber: Int?
    
    @IBOutlet private weak var detailTableView: UITableView!
    @IBOutlet weak var bookmarkButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.register(UINib(nibName: reprotListCellData.cellIdentifier2, bundle: nil), forCellReuseIdentifier: reprotListCellData.cellIdentifier2)
        if tabNumber == 2 {
            navigationItem.rightBarButtonItems?.remove(at: 0)
        }
    }
    
    @IBAction func registerBookmark(_ sender: UIBarButtonItem) {
        presenter.sendReportData(data: reportData!, userID: UserDefaults.standard.string(forKey: "userID")!)
        bookmarkButton.image = UIImage(systemName: "star.fill")
    }
}
//MARK: - UITableViewDelegate
extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 5 {
            let WebVC = storyboard?.instantiateViewController(identifier: "WebVC") as! WebViewController
            if tabNumber == 1 {
            WebVC.reportLink = reportData?.reportLink as! String
            } else if tabNumber == 2 {
                WebVC.reportLink = bookmarkData?.link as! String
            }
            navigationController?.pushViewController(WebVC, animated: true)
        }
    }
}
//MARK: -
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reprotListCellData.cellIdentifier2, for: indexPath) as! DetailTableViewCell
         
        if tabNumber == 1 {
            if indexPath.row == 0 {
                cell.cellTitle.text = DetailTableViewCellData.title
                cell.contentLabel.text = reportData?.title
            } else if indexPath.row == 1 {
                cell.cellTitle.text = DetailTableViewCellData.authors
                cell.contentLabel.text = reportData?.getAuthorsName()
            } else if indexPath.row == 2 {
                cell.cellTitle.text = DetailTableViewCellData.description
                cell.contentLabel.text = reportData?.description
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
        } else if tabNumber == 2 {
            if indexPath.row == 0 {
                cell.cellTitle.text = DetailTableViewCellData.title
                cell.contentLabel.text = bookmarkData?.title
            } else if indexPath.row == 1 {
                cell.cellTitle.text = DetailTableViewCellData.authors
                cell.contentLabel.text = bookmarkData?.authors
            } else if indexPath.row == 2 {
                cell.cellTitle.text = DetailTableViewCellData.description
                cell.contentLabel.text = bookmarkData?.description
            } else if indexPath.row == 3 {
                cell.cellTitle.text = DetailTableViewCellData.publisher
                cell.contentLabel.text = bookmarkData?.publisher
            } else if indexPath.row == 4 {
                cell.cellTitle.text = DetailTableViewCellData.date
                cell.contentLabel.text = bookmarkData?.date
            } else if indexPath.row == 5 {
                cell.cellTitle.text = DetailTableViewCellData.reportLink
                cell.contentLabel.text = bookmarkData?.link
            }
            
        }
        return cell
    }
    
    func createBookmarkButton(cell: DetailTableViewCell) {
        let button = UIButton(type: UIButton.ButtonType.system)
        cell.sizeToFit()
        button.center = cell.bookmarkView.center
        let image = UIImage(named: "background")
        button.setImage(image, for: .normal)
        button.addSubview(button)
    }
}
