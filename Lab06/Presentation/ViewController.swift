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
         saveB.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
    }
    
  @IBAction func saveButton(_ sender: UIButton){
    sender.isSelected = !sender.isSelected
    if(sender.isSelected){
    PersistenceManager.shared.save(title: titleL.text!)
    }
    if(!sender.isSelected){
         PersistenceManager.shared.remove(title: titleL.text!)        
    }
    }
    
    func normalize(data: Post,position: Int){
         DispatchQueue.main.async {
                   
                   let now = Int(NSDate().timeIntervalSince1970)
            let difference = now - data.created_utc
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
                       self.authorL?.text = (data.author)
            self.timeL?.text = time
                       self.domainL?.text = data.domain
                       self.titleL?.text = data.title
                       self.ratingL?.text = String((data.ups )-(data.downs ))
                       self.numcommentsL?.text = String(data.num_comments )
            self.imgView.sd_setImage(with: URL(string:data.url ), placeholderImage: UIImage())
            self.saveB?.isSelected = data.isSaved
        }

}
}

