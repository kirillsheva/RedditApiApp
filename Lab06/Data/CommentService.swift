//
//  CommentService.swift
//  Lab06
//
//  Created by Ker on 04.12.2020.
//  Copyright © 2020 Ker. All rights reserved.
//

import Foundation

struct Comments : Codable{
    var data: PostComments
    struct PostComments : Codable {
        var children : [Child]
        struct Child : Codable {
            var data: Post
            struct Post : Codable {
                var id: String?
                var permalink : String?
                var author : String?
                var created_utc:Int?
                var body : String?
                var ups : Int?
                var downs : Int?
            }
        }
    }
}

struct PostComment:Identifiable, Codable {
                var id : String?
               var permalink : String?
               var author : String?
               var created_utc:Int?
               var body : String?
               var ups : Int?
               var downs : Int?
    
    
    init(_ post: Comments.PostComments.Child.Post) {
    self.id = post.id
      self.permalink = post.permalink
      self.author = post.author
      self.created_utc = (post.created_utc)
      self.body = post.body
      self.ups = post.ups
      self.downs = post.downs

         }
    
}

class CommentService{
    
    static func commentService(_ permalink: String){
        HTTPRequester.request(url: jsonURL(permalink), completionHandler:{ data in
                if let data = data{
                    print(data)
                    if let info = getComments(res:data){
                        PersistenceManager.shared.clear()
                        for element in info{
                            for post in element.data.children{
                                
                                PersistenceManager.shared.addComment(PostComment(post.data))
                             //   print(post.data)
                            }
                        }
                        PersistenceManager.shared.comments.remove(at: 0)
                        PersistenceManager.shared.comments.removeLast()
                          NotificationCenter.default.post(Notification(name: commentsSaved))
                        
                    }
                }else{
                    print("Comment Service error")
                }
                    
                
    })

        
    }
  static func getComments(res:Data)->[Comments]?{
        do{
            let objs = try JSONDecoder().decode([Comments].self, from: res)
            return objs
        } catch{
            print("Asshole")
            return nil
        }
    
    }
    
  
    static func jsonURL(_ permalink:String) -> String {
        let url = "https://www.reddit.com"+permalink+".json"
        return url
    }
    
}
