//
//  SearchResultViewController.swift
//  NewsFilter
//
//  Created by 王雨欣 on 2018/12/19.
//  Copyright © 2018 Hayden. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var resultNumberLabel: UILabel!
    
    @IBOutlet var SourceButtons: [UIButton]!
    
    @IBOutlet var KindButtons: [UIButton]!
    
    @IBOutlet var SortButtons: [UIButton]!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var myCrawler = Crawler()
    var curNews = [News]()

    override func viewDidLoad(){
        super.viewDidLoad()
        start()
        curNews = newsList
        resultNumberLabel.text = "共有 "+String(curNews.count)+" 条搜索结果"
    }

    // MARK: 爬取数据
    func start(){

        myCrawler.ScrapeAndParse()
//        print(newsList.count)

        if netConnect == false {
            let alertController = UIAlertController(title:"提示",message:"请检查下网络连接状况!",preferredStyle: .alert)
            let okAciton = UIAlertAction(title:"确定",style:.default,handler: {
                action in
            })
            alertController.addAction(okAciton)
            self.present(alertController, animated: true, completion: nil)
        }
    }

    // MARK: 显示列表
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return curNews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cellIdentifier = "ResultTableViewCell"

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ResultTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ResultTableViewCell.")
        }

        // Fetches the appropriate meal for the data source layout.
        let news = curNews[indexPath.row]

        cell.titleLabel.text = news.title
        cell.timeLabel.text = news.time
        cell.sourceLabel.text = news.sourcestr
        cell.url = news.url

        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        
//        print(segue.destination)
        
        guard let webViewController = segue.destination as? WebViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        guard let selectedResultCell = sender as? ResultTableViewCell else {
            fatalError("Unexpected sender: \(String(describing: sender))")
        }
        
        guard let indexPath = tableView.indexPath(for: selectedResultCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        let selectedResult = curNews[indexPath.row]
        
        webViewController.urlStr = selectedResult.url
        webViewController.newsTitle = selectedResult.title
        webViewController.newsSource = selectedResult.sourcestr
        webViewController.newsTime = selectedResult.time
//        print(selectedResult.url)
        
    }
    
    
    @IBAction func newsSourceButton(_ sender: UIButton) {
        
        KindButtons.forEach{ (button) in
            button.isHidden = true
        }
        
        SortButtons.forEach{ (button) in
            button.isHidden = true
        }
        
        SourceButtons.forEach{ (button) in
            
            // 下拉栏被隐藏
            if button.isHidden == true{
                //显示下拉栏
                button.isHidden = false
                //table view 隐藏
                tableView.isHidden = true
            }
            // 下拉栏显示出来
            else{
                //隐藏下拉栏
                button.isHidden = true
                //table view 显示
                tableView.isHidden = false
            }
        }
    }
    
    @IBAction func newsKindButton(_ sender: UIButton) {
        
        SourceButtons.forEach{ (button) in
            button.isHidden = true
        }
        
        SortButtons.forEach{ (button) in
            button.isHidden = true
        }
        
        KindButtons.forEach{ (button) in
            
            // 下拉栏被隐藏
            if button.isHidden == true{
                //显示下拉栏
                button.isHidden = false
                //table view 隐藏
                tableView.isHidden = true
                
            }
                // 下拉栏显示出来
            else{
                //隐藏下拉栏
                button.isHidden = true
                //table view 显示
                tableView.isHidden = false
            }
        }
    }
    
    @IBAction func newsSortButton(_ sender: UIButton) {
        
        SourceButtons.forEach{ (button) in
            button.isHidden = true
        }
        
        KindButtons.forEach{ (button) in
            button.isHidden = true
        }
        
        SortButtons.forEach{ (button) in
            
            // 下拉栏被隐藏
            if button.isHidden == true{
                //显示下拉栏
                button.isHidden = false
                //table view 隐藏
                tableView.isHidden = true
            }
                // 下拉栏显示出来
            else{
                //隐藏下拉栏
                button.isHidden = true
                //table view 显示
                tableView.isHidden = false
            }
        }
    }
    
    @IBAction func sourceSelected(_ sender: UIButton) {
        
        SourceButtons.forEach{(button) in
            button.isHidden = true
            
        }
        
        tableView.isHidden = false
    }
    
    @IBAction func kindSelected(_ sender: UIButton) {
        
        let filter = NewsFilter()
        
        if let kind:String = sender.titleLabel!.text{
            switch kind {
            case "资讯":
                curNews = filter.filterOutAdvisory(news: newsList)
                resultNumberLabel.text = "共有 "+String(curNews.count)+" 条搜索结果"
                print(curNews.count)
                tableView.reloadData()
            case "娱乐" :
                curNews = filter.filterOutEntertainment(news: newsList)
                resultNumberLabel.text = "共有 "+String(curNews.count)+" 条搜索结果"
                tableView.reloadData()
            case "财经":
                curNews = filter.filterOutFinance(news: newsList)
                resultNumberLabel.text = "共有 "+String(curNews.count)+" 条搜索结果"
                tableView.reloadData()
            case "时尚":
                curNews = filter.filterOutFashion(news: newsList)
                resultNumberLabel.text = "共有 "+String(curNews.count)+" 条搜索结果"
                tableView.reloadData()
            case "其他":
                curNews = filter.filterOutOther(news: newsList)
                resultNumberLabel.text = "共有 "+String(curNews.count)+" 条搜索结果"
                tableView.reloadData()
            default:
                print("fitler news button error")
            }
        }
        
        KindButtons.forEach{ (button) in
            
            button.isHidden = true
            
        }
        
        tableView.isHidden = false
    }
    
    @IBAction func sortSelected(_ sender: UIButton) {
        
        let sorter = NewsSorter()
        
        if let sort:String = sender.titleLabel!.text{
            switch sort {
            case "按相关度排序":
                curNews = sorter.sortByRelativity(news: curNews)
                tableView.reloadData()
            case "按时间排序" :
                curNews = sorter.sortByTime(news: curNews)
//                for item in curNews{
//                    print(item.title)
//                    print(item.url)
//                    print()
//                }
                tableView.reloadData()
            default:
                print("sorter news button error")
            }
            SortButtons.forEach{(button) in
                button.isHidden = true
                
            }
            
            tableView.isHidden = false
            
        }
        
        
    }
}
