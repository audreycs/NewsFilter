//
//  ResultTableViewCell.swift
//  NewsFilter
//
//  Created by 王雨欣 on 2018/12/19.
//  Copyright © 2018 Hayden. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
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
