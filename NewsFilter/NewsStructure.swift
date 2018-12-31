//
//  NewsStructure.swift
//  NewsFilter
//
//  Created by 王雨欣 on 2018/12/19.
//  Copyright © 2018 Hayden. All rights reserved.
//

import UIKit

//
enum newSource{
    // 咨询类
    case advisory
    // 娱乐类
    case entertainment
    // 时尚类
    case fashion
    // 财经类
    case finance
    // 其他类
    case other
}


public struct News{
    // news title
    var title : String
    // news url
    var url : String
    // news source
    var sourcestr : String
    // news source kind
    var sourceKind : newSource
    //news time
    var time : String
    
}

public struct NewsCollected{
    var title : String
    var url : String
    var sourcestr: String
}

public var newsList = [News]()

public var newsCollect = [News]()
