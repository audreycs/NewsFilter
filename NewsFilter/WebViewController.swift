//
//  File.swift
//  NewsFilter
//
//  Created by 王雨欣 on 2018/12/4.
//  Copyright © 2018 Hayden. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webViewTutorial: WKWebView!
    
    @IBOutlet weak var collectButton: UIButton!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    var urlStr:String = ""
    var newsTitle:String = ""
    var newsSource:String = ""
    var newsTime:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webViewTutorial.translatesAutoresizingMaskIntoConstraints=false
        
        webViewTutorial.layer.zPosition = -1
        
        webViewTutorial.navigationDelegate = self
        
        indicator.hidesWhenStopped = true
        
        loadWebsite()
        
    }
    
    @IBAction func collectButtonSelected(_ sender: UIButton) {
       
        
        if let title = collectButton.titleLabel?.text {
            if title == "点击收藏" {
                collectButton.setTitle("⭐️已收藏", for: .normal)
                collectButton.setTitleColor(UIColor(red: 201/256, green: 157/256, blue: 92/256, alpha: 1), for: .normal)
                collectButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
            
                
                let addone :News = News(title: self.newsTitle, url: self.urlStr, sourcestr: self.newsSource, sourceKind: newSource.other,  time: self.newsTime)
                
                let addone_collect : [String] = [self.newsTitle, self.urlStr]
                
                newsCollect.append(addone)
                
                let defaults = UserDefaults.standard
                defaults.set(addone_collect, forKey: "NewsFilter"+self.urlStr)
                
//                for (key, value) in defaults.dictionaryRepresentation() {
//                    print("\(value)     \(key)")
//                }
            }
                
            else
            {
                collectButton.setTitle("点击收藏", for: .normal)
                collectButton.setTitleColor(UIColor(red: 0, green: 122/256, blue: 255/256, alpha: 1), for: .normal)
                collectButton.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
                
                deleteACollect(url: self.urlStr)
                
                let defaults = UserDefaults.standard
                defaults.removeObject(forKey: "NewsFilter"+self.urlStr)
//                for (key, value) in defaults.dictionaryRepresentation() {
//                    print("\(value)     \(key)")
//                }
            }
        }
       
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    func deleteACollect(url: String){
        
        for (index, item) in newsCollect.enumerated(){
            if item.url == url{
                newsCollect.remove(at: index)
            }
        }
        
    }
    
    func checkIfCollected(url: String) -> Bool{
        
        for item in newsCollect{
            if item.url == url{
                return true
            }
        }
        
        return false
    }
    
    // 加载网页
    func loadWebsite(){
        
        let url = URL(string: urlStr)
        
        if let unwrappedURL = url {
            let request = URLRequest(url: unwrappedURL)
            self.webViewTutorial.load(request)
        }
        
        if checkIfCollected(url: self.urlStr) ||  UserDefaults.standard.stringArray(forKey: "NewsFilter"+self.urlStr) != nil {
            collectButton.setTitle("⭐️已收藏", for: .normal)
            collectButton.setTitleColor(UIColor(red: 201/256, green: 157/256, blue: 92/256, alpha: 1), for: .normal)
            collectButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
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

