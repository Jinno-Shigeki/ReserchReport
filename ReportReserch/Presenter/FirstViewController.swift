//
//  ViewController.swift
//  ReportReserch
//
//  Created by 神野成紀 on 2020/05/24.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit
protocol FirstViewProtocol {
    func reloadData()
}
final class FirstViewController: UIViewController {
    
    var presenter: FirstViewPresenter!
    
    @IBOutlet private weak var reportList: UITableView!
    @IBOutlet private weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reportList.delegate = self
        reportList.dataSource = self
        reportList.register(UINib(nibName: reprotListCellData.cellIdentifier1, bundle: nil), forCellReuseIdentifier: reprotListCellData.cellIdentifier1)
        searchTextField.delegate = self
        presenter = FirstViewPresenter(view: self)
        searchTextField.addTarget( self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
}
//MARK: - UITableViewDelegate
extension FirstViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = storyboard?.instantiateViewController(identifier: "DetailVC") as! DetailViewController
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.reportData = presenter.reportArray[indexPath.row]
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .systemOrange
    }
}
//MARK: - UITableViewDataSource
extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if presenter.reportArray.count == 0 {
            return 1
        } else {
            return presenter.reportArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reprotListCellData.cellIdentifier1, for: indexPath) as! ReportListCell
        if presenter.reportArray.count == 0 {
            cell.reportTitleLabel.text = reprotListCellData.titleLabel
            cell.authorsLabel.text = reprotListCellData.autherLabel
        } else {
            cell.reportTitleLabel.text = presenter.reportArray[indexPath.row].title
            cell.authorsLabel.text = presenter.reportArray[indexPath.row].getAuthorsName()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let targetCell = presenter.reportArray.count - indexPath.row
        if presenter.reportArray.count >= 20 && targetCell == 5 && presenter.dataItems == 20 {
            presenter.getReport(searchKey: searchTextField.text ?? "",firstLoading: false)
        }
    }
}
//MARK: - UITextFieldDelegate
extension FirstViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            presenter.getReport(searchKey: text, firstLoading: true)
        }
        if presenter.reportArray.count != 0 {
            reportList.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
            self.presenter.getReport(searchKey: textField.text ?? "", firstLoading: true)
        }
    }
}
//MARK: - FirstViewProtocol
extension FirstViewController: FirstViewProtocol{
    func reloadData() {
        reportList.reloadData()
    }
}

