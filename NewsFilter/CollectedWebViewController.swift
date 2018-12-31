//
//  CollectedWebViewController.swift
//  NewsFilter
//
//  Created by 王雨欣 on 2018/12/21.
//  Copyright © 2018 Hayden. All rights reserved.
//

import UIKit
import WebKit

class CollectedWebViewController: UIViewController, WKNavigationDelegate{
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var newsTitle:String = ""
    var urlStr:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.translatesAutoresizingMaskIntoConstraints=false
        
        webView.layer.zPosition = -1
        
        webView.navigationDelegate = self
        
        indicator.hidesWhenStopped = true
        
        loadWebsite()
        
    }
    
    
    // 加载网页
    func loadWebsite(){
        let url = URL(string: urlStr)
        
        if let unwrappedURL = url {
            let request = URLRequest(url: unwrappedURL)
            self.webView.load(request)
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.indicator.startAnimating()
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(WKNavigationActionPolicy.allow);
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.indicator.stopAnimating()
        
    }
    
    
}
