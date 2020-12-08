//
//  CommentView.swift
//  Lab06
//
//  Created by Ker on 08.12.2020.
//  Copyright © 2020 Ker. All rights reserved.
//

import SwiftUI

struct CommentView: View {
    var el : PostComment
    var body: some View {
        VStack{
            HStack{
                Text("\(el.author ?? "")")
              Spacer()
                Text(normalize(timer: el.created_utc ?? 0))
}
            Text(el.body ?? "")
                .padding(10)
            Button(action: {
                self.share()
            }) {
                Text("Share")
                    .foregroundColor(.green)
                 
                
            }
              
}
}
    
    func normalize(timer:Int) -> String{
                 let now = Int(NSDate().timeIntervalSince1970)
           let difference = now - timer
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
        return time
}
    func share(){
        let items = [URL(string:"reddit.com\(el.permalink ?? "")")]
        let ac = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(ac,animated: true,completion: nil)
    }
}
