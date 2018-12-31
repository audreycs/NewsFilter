//
//  NewsSorting.swift
//  NewsFilter
//
//  Created by 王雨欣 on 2018/12/20.
//  Copyright © 2018 Hayden. All rights reserved.
//

import UIKit

class NewsSorter{
    
    func sortByRelativity(news: [News]) -> [News]{
        
        var news1:[News] = [News]()
        
        var kind:newSource
        if news.count > 0{
            switch(news[0].sourceKind){
            case .advisory :
                kind = .advisory
            case .entertainment:
                kind = .entertainment
            case .fashion:
                kind = .fashion
            case .finance:
                kind = .finance
            case .other:
                kind = .other
            }
            
            for item in newsList{
                if item.sourceKind == kind{
                    news1.append(item)
                }
            }
        }
        
        return news1
        
    }
    
    // 根据时间对新闻进行排序
    func sortByTime(news: [News]) -> [News]{
     
        var news1:[News] = news
        news1.sort(by: compare)
    
//        for item in news1{
//            print(item.title)
//            print(item.url)
//            print()
//        }
        
        return news1
        
    }
    
    func compare(news1: News, news2: News) -> Bool{
        return news1.time > news2.time
    }
    
}
