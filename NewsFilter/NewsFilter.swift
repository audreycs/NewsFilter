//
//  NewsFilter.swift
//  NewsFilter
//
//  Created by 王雨欣 on 2018/12/20.
//  Copyright © 2018 Hayden. All rights reserved.
//

import UIKit

class NewsFilter{
    
    func filterOutAdvisory(news: [News]) -> [News]{
        
        let news1 = news.filter{ (item) -> Bool in
            print(item.sourceKind)
            return item.sourceKind == .advisory
        }
        
        return news1
    }
    
    
    func filterOutFashion(news: [News]) -> [News]{

        let news1 = news.filter{ (item) -> Bool in
            return item.sourceKind == .fashion
        }
        
        return news1
    }
    
    
    func filterOutEntertainment(news: [News]) -> [News]{
        
        let news1 = news.filter{ (item) -> Bool in
            return item.sourceKind == .entertainment
        }
        
        return news1
    }
    
    
    func filterOutFinance(news: [News]) -> [News]{
        
        let news1 = news.filter{ (item) -> Bool in
            return item.sourceKind == .finance
        }
        
        return news1
    }
    
    
    func filterOutOther(news: [News]) -> [News]{
        
        let news1 = news.filter{ (item) -> Bool in
            return item.sourceKind == .other
        }
        
        return news1
    }
    
    
}
