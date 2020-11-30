//
//  PostTableViewCell.swift
//  Lab06
//
//  Created by Ker on 24.11.2020.
//  Copyright © 2020 Ker. All rights reserved.
//

import UIKit
import SDWebImage
class PostTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "postCell"
    
    
    @IBOutlet weak var authorL:UILabel!
     @IBOutlet weak var timeL:UILabel!
     @IBOutlet weak var domainL:UILabel!
     @IBOutlet weak var numcommentsL:UILabel!
     @IBOutlet weak var ratingL:UILabel!
     @IBOutlet weak var titleL:UITextView!
     @IBOutlet weak var shareL:UIButton!
    @IBOutlet weak var imgView:UIImageView!
    
    override func prepareForReuse() {
        self.authorL.text = nil
        self.timeL.text = nil
        self.domainL.text = nil
        self.numcommentsL.text = nil
        self.ratingL.text = nil
        self.titleL.text = nil
        self.imgView.image = nil
     
    }
    
    
  
    
    func configure(for data: Post){
    
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
        
       self.authorL.text = (data.author)
        self.timeL.text = time
        self.domainL.text = data.domain
        self.titleL.text = data.title
        self.ratingL.text = String((data.ups )-(data.downs ))
        self.numcommentsL.text = String(data.num_comments )
        self.imgView.sd_setImage(with: URL(string:data.url ), placeholderImage: UIImage())
       
        
    }
    
    
}
