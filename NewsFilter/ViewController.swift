//
//  ViewController.swift
//  NewsFilter
//
//  Created by 王雨欣 on 2018/11/5.
//  Copyright © 2018 Hayden. All rights reserved.
//

import UIKit

var keyWords:String = ""

class ViewController: UIViewController, UISearchBarDelegate{
    
    @IBOutlet weak var mainsearchBar: UISearchBar!
    
    @IBOutlet weak var AppTitleLabel: UILabel!
    
    @IBOutlet weak var newspaperImage: UIImageView!
    
    
    func imageGradient(){
        let view = UIView(frame: newspaperImage.frame)
        view.frame = newspaperImage.bounds
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        
        // same color with View's background
        let startColor = UIColor(red: 30/255, green: 113/255, blue: 79/255, alpha: 1).cgColor
        let endColor = UIColor.clear.cgColor
        gradient.colors = [startColor, endColor]
        gradient.locations = [0.0, 1.0]
        
        //gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        //gradient.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        view.layer.insertSublayer(gradient, at: 0)
        newspaperImage.addSubview(view)
        newspaperImage.bringSubviewToFront(view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        // remove the borders of search bar
        self.mainsearchBar.backgroundImage = UIImage()
        
        // Applying color gradient to newspaper image
        imageGradient()
        
        mainsearchBar.keyboardType = UIKeyboardType.default
        
        mainsearchBar.delegate = self
        mainsearchBar.returnKeyType = UIReturnKeyType.done
        
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        
        netConnect = true
        
        if let content = mainsearchBar.text {
            keyWords = content
            if keyWords == "" {
                print("no content")
            }
            else{
                //print(keyWords)
            }
        }
        else{
            print("Error appears in Search Bar!")
        }
        newsList.removeAll()
        
    }
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

