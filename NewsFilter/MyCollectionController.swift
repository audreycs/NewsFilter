//
//  MyCollection.swift
//  NewsFilter
//
//  Created by 王雨欣 on 2018/12/20.
//  Copyright © 2018 Hayden. All rights reserved.
//

import UIKit

class MyColletcionController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    var newsCollectedList = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDatas()
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsCollectedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cellIdentifier = "CollectNewsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CollectNewsTableViewCell  else {
            fatalError("The dequeued cell is not an instance of CollectNewsTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let news = newsCollectedList[indexPath.row]
        
        cell.newsTitle.text = news[0]
        cell.url = news[1]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
        
    }
    
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?{
        return "删除"
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            let index:Int = indexPath.row
            let news = newsCollectedList[index]
//            print(news[0])
            
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "NewsFilter"+news[1])
            
            newsCollectedList.remove(at: index)
            
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        
//        print(segue.destination)
        
        guard let webViewController = segue.destination as? CollectedWebViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        guard let selectedResultCell = sender as? CollectNewsTableViewCell else {
            fatalError("Unexpected sender: \(String(describing: sender))")
        }
        
        guard let indexPath = tableView.indexPath(for: selectedResultCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        let selectedResult = newsCollectedList[indexPath.row]
        
        webViewController.newsTitle = selectedResult[0]
        webViewController.urlStr = selectedResult[1]
        
    }
    
    func loadDatas(){
        let defaults = UserDefaults.standard
        for item in defaults.dictionaryRepresentation(){
            if item.key.contains("NewsFilter"){
                newsCollectedList.append(item.value as! [String])
            }
        }
    }
}
