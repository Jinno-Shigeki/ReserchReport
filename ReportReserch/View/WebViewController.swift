//
//  WebViewController.swift
//  ReportReserch
//
//  Created by 神野成紀 on 2020/05/30.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    private let activityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet private weak var webView: WKWebView!
       var reportLink = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        guard let reportUrl = URL(string: reportLink) else { return }
        let urlRequest = URLRequest(url: reportUrl)
        addIndicator()
        webView.load(urlRequest)
    }
    func addIndicator() {
        activityIndicatorView.style = .large
        activityIndicatorView.color = .white
        activityIndicatorView.frame = CGRect(x: 0, y: 0, width: 90, height: 90)
        activityIndicatorView.center = webView.center
        activityIndicatorView.backgroundColor = .black
        activityIndicatorView.alpha = 0.5
        activityIndicatorView.layer.cornerRadius = 10
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
}
//MARK: - WKNavigationDelegate
extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.activityIndicatorView.stopAnimating()
    }
}
