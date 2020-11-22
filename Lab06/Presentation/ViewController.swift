//
//  ViewController.swift
//  Lab06
//
//  Created by Ker on 01.11.2020.
//  Copyright © 2020 Ker. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var authorL:UILabel!
     @IBOutlet weak var timeL:UILabel!
     @IBOutlet weak var domainL:UILabel!
     @IBOutlet weak var numcommentsL:UILabel!
     @IBOutlet weak var ratingL:UILabel!
     @IBOutlet weak var titleL:UITextView!
     @IBOutlet weak var shareL:UIButton!
    @IBOutlet weak var saveB:UIButton!
    @IBOutlet weak var imgView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UseCase.getPostsInfo(subreddit: "memes", limit: 1, completion: {(data) -> Void in
            DispatchQueue.main.async {
            
            let now = Int(NSDate().timeIntervalSince1970)
                let difference = now - data.data[0].created_utc
                var time:String
                
                switch difference{
                case let diff where diff < 3600:
                    time = "\(Int(diff/60))m"
                case let diff where diff < 86400:
                    time = "\(Int(diff/3600))h"
                case let diff where diff < 2678400:
                    time = "\(Int(diff/86400))d"
                case let diff where diff < 3153600:
                    time = "\(Int(diff/2678400))m"
                default:
                    time = "\(Int(difference/31536000))y"
                }
                
                self.authorL?.text = (data.data[0].author) 
                self.timeL?.text = time
                self.domainL?.text = data.data[0].domain
                self.titleL?.text = data.data[0].title
                self.ratingL?.text = String((data.data[0].ups )-(data.data[0].downs ))
                self.numcommentsL?.text = String(data.data[0].num_comments )
                self.imgView?.sd_setImage(with: URL(string:data.data[0].url ), placeholderImage: UIImage())
            }
        })
    }
    
    @IBAction func saveButton(){
        if((self.saveB?.isSelected) != nil){
            self.saveB?.isSelected = false
        } else{
            self.saveB?.isSelected = true
        }
    }

}

