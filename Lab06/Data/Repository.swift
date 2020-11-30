//
//  Repository.swift
//  Lab06
//
//  Created by Ker on 01.11.2020.
//  Copyright © 2020 Ker. All rights reserved.
//

import Foundation



struct Response : Codable{
 var data : DataStruct
    struct DataStruct : Codable {
        var children : [ItemStruct]
        struct ItemStruct: Codable {
            var data : ItemDataStruct
            struct ItemDataStruct:Codable{
                var id:String
                var author:String
                var domain:String
                var created_utc:Int
                var title:String
                var url:String
                var ups:Int
                var downs:Int
                var num_comments:Int
              
            }
        }
    }
}

struct Post:Codable{
    var id:String
           var author:String
           var domain:String
           var created_utc:Int
           var title:String
           var url:String
           var ups:Int
           var downs:Int
           var num_comments:Int
           var isSaved:Bool
    init(_ post: Response.DataStruct.ItemStruct.ItemDataStruct) {
        self.id=post.id
            self.author = post.author
            self.domain = post.domain
            self.created_utc = (post.created_utc)
            self.title = post.title
            self.url = post.url
            self.ups = post.ups
            self.downs = post.downs
            self.num_comments = (post.num_comments)
            self.isSaved = false
        }
        
}
/*struct SavedResponse:Decodable {
                  var data:[Post]
                  struct Post:Decodable{
                      var author:String
                      var domain:String
                      var created_utc:Int
                      var title:String
                      var url:String
                      var ups:Int
                      var downs:Int
                      var num_comments:Int
                      var isSaved:Bool
                  }
           }*/
class Repository{
    static func parse(data:Data) -> Post?{
        do{
            let result = try JSONDecoder().decode(Post.self, from: data)
            return result
        } catch {
            print(error.localizedDescription)
            return nil
        }
        
    }
    
    func saveToJsonFile(arr : Array<Post>) {
     guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = directory.appendingPathComponent("Info.json")
    
            let data = try? JSONEncoder().encode(arr)
        do{
            try data!.write(to: fileUrl, options: [])
            print("saved")

        } catch{
            print("Error")
        }
             
    }

}

