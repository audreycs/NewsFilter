//
//  CollectNewsTableViewCell.swift
//  NewsFilter
//
//  Created by 王雨欣 on 2018/12/21.
//  Copyright © 2018 Hayden. All rights reserved.
//

import UIKit

class CollectNewsTableViewCell: UITableViewCell{
    
    @IBOutlet weak var newsTitle: UILabel!
    
    var url:String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
