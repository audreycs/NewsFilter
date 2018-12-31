//
//  WebView.swift
//  NewsFilter
//
//  Created by 王雨欣 on 2018/12/4.
//  Copyright © 2018 Hayden. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet weak var webViewExample: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = URL(string: "http://wemedia.ifeng.com/90728806/wemedia.shtml")
        if let unwrappedURL = url {
            
            let request = URLRequest(url: unwrappedURL)
            let session = URLSession.shared
            
            let task = session.dataTask(with: request) { (data, response, error) in
                
                if error == nil {
                    
                    self.webViewExample.load(request)
                    
                } else {
                    
                    print("ERROR: \(String(describing: error))")
                    
                }
                
            }
            
            task.resume()
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
