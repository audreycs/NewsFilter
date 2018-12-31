//
//  Crawler.swift
//  NewsFilter
//
//  Created by 王雨欣 on 2018/12/16.
//  Copyright © 2018 Hayden. All rights reserved.
//

import UIKit
import SwiftSoup

public var netConnect:Bool = true

// 用于对网页数据进行爬取和分析
public class Crawler {
    
    let FHSearchURL1 = "https://search.ifeng.com/sofeng/search.action?q="
    let FHSearchURL2 = "&c=1&chel="
    let FHSearchURLpage = "&p="
    
    // search url
    var searchURL : String
    // 当前页面数
    var curpagenum:Int
    // 总共页面数
    var tolpagenum:Int
    // 搜索条目综述
    var resultsnum:Int
    // 每一页面显示条目数
    let eachPageNum = 10
    
    var queue: DispatchQueue = DispatchQueue(label: "com.edu.nju", attributes: .concurrent, target: .main)
    var dispatchGroup: DispatchGroup = DispatchGroup()
    
    init() {
        searchURL = ""
        curpagenum = 1
        tolpagenum = 2
        resultsnum = 0
    }
    
    func ScrapeAndParse() {
        // 初始化url链接，pagenum = 1
        repeat{
            // 根据当前的pagenum生成要爬取的网页url链接
            self.generizeURL()
        
            //self.generizeURL()
            self.scrapeHTML(urlPath: searchURL)

            curpagenum += 1

            //print("\(curpagenum)  \(tolpagenum)")

        }while(curpagenum <= tolpagenum)
    }
    
    func generizeURL()  {
        searchURL = FHSearchURL1 + keyWords + FHSearchURL2 + FHSearchURLpage + "\(curpagenum)"
        
//        searchURL = "https://search.ifeng.com/sofeng/search.action?q=德国&c=1"
    }
    
    // 获取网页的源代码
//    func scrapeHTML() -> Void {
//        dispatchGroup.enter()
//
//        //这里是函数的调用，{}里面是闭包，responseString函数的唯一参数是一个闭包
//
//        Alamofire.request(self.searchURL, method:.get).responseString() { response in
//            //html = response.result.value!
//            print("网页是否可访问: \(response.result.isSuccess)")
//            if let html = response.result.value {
//                self.parseHTML(html: html)
//            }
//
//            self.dispatchGroup.leave()
//
//            return
//        }
//
//    }
    
    func scrapeHTML(urlPath:String) -> Void {
        
        let encodedUrl = urlPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let url = URL(string: encodedUrl!)!
        
        let request1 = URLRequest(url: url)
        let response: AutoreleasingUnsafeMutablePointer<URLResponse?>?=nil
        
        do{
            let dataVal = try NSURLConnection.sendSynchronousRequest(request1, returning: response)
            
            let dataString = NSString.init(data: dataVal, encoding: String.Encoding.utf8.rawValue)
            
            let html:String = String(dataString!)
            //print(html)
            parseHTML(html: html)
            
        }catch let error as NSError{
            print(error.localizedDescription)
            netConnect = false
        }
        
        return
    }
    
    
    // 对网页源代码进行分析
    func parseHTML(html: String) -> Void {
        //打印网页源代码
        //print(html)
        
        do {
            //let html1 = "<html><head><title>First parse</title></head>" + "<body><p>Parsed HTML into a doc.</p></body></html>"
            let doc: Document = try SwiftSoup.parse(html)
            let mainHead: Element? = try doc.select("div.mainHead").first()
            let mainHeadString: String = try mainHead?.text() ?? ""
            // 获得约 xx条结果,这是第1-10条,（用时0.xxx秒）
//            print(mainHeadString)
            
            // 把结果数目数字提取出来
            let stringArray = mainHeadString.components(separatedBy: CharacterSet.decimalDigits.inverted)
            for item in stringArray {
                if let number = Int(item) {
                    self.resultsnum = Int(number)
                    if self.resultsnum%10 != 0{
                        self.tolpagenum = self.resultsnum/self.eachPageNum + 1
                    }
                    else{
                        self.tolpagenum = self.resultsnum/self.eachPageNum
                    }
//                    print("搜索结果一共有：\(self.resultsnum)")
//                    print("要显示的页面数：\(self.tolpagenum)")
                    break
                }
            }
            
            
            if resultsnum > 0 {
                
                let mainContent: Array<Element> = try doc.select("div.searchResults").array()
                for content in mainContent{
                    let paragraphs : Array<Element> = try content.select("p").array()
                    let p1: Element = paragraphs[0]
                    let p2: Element = paragraphs[2]
                    
                    let title:String = try p1.text()
                    
                    let url:String = try p1.select("a").attr("href")
                    
                    let sourcestr: String = String(try p2.text().split(separator: " ")[0])
                    
                    let sourceKind:newSource
                    
                    if String(try p2.text().split(separator: " ")[0]).contains("资讯") {
                        sourceKind = .advisory
                    }
                    else if String(try p2.text().split(separator: " ")[0]).contains("时尚"){
                        sourceKind = .fashion
                    }
                    else if String(try p2.text().split(separator: " ")[0]).contains("财经"){
                        sourceKind = .finance
                    }
                    else if String(try p2.text().split(separator: " ")[0]).contains("娱乐"){
                        sourceKind = .entertainment
                    }
                    else{
                        sourceKind = .other
                    }
                    
                    let time: String = String(try p2.text().split(separator: " ")[1]) + " " + String (try p2.text().split(separator: " ")[2])
                    
                    let oneNews: News = News(title: title, url: url, sourcestr: sourcestr, sourceKind: sourceKind, time: time)
                    
                    newsList.append(oneNews)
                    
                    //print(newsList.count)
                }
            }
            
            else{
                print("搜索结果条目为0")
            }
            
        } catch Exception.Error( _, let message) {
            print(message)
        } catch {
            print("error")
        }
    }
    
    
    func printURL() {
        print("search url is: " + searchURL)
    }
    
    func printTotalpage(){
        print("total pagenum is: \(tolpagenum)")
    }
    
    func printResultsnum(){
        print("total search result is: \(resultsnum)")
    }
        
}
    

