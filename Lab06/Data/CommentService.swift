//
//  CommentService.swift
//  Lab06
//
//  Created by Ker on 04.12.2020.
//  Copyright © 2020 Ker. All rights reserved.
//

import Foundation

class CommentService{
    
    func loadComments(_ permalink: String, completion: @escaping ([Comments.PostComments.Child])->Void){
        guard let url = URL(string: jsonURL(permalink)) else {return}
        URLSession.shared.dataTask(with: url){(data,response,error) in
            guard let data = data else {return}
            do{
                let obj = try JSONDecoder().decode([Comments].self,from: data)
                for element in obj {
                    let commentChild = element.data.children
                    completion(commentChild)
                }
            }catch{
                print("Error")
            }
        }.resume()
    }
    
    func jsonURL(_ permalink:String) -> String {
        let url = "https://www.reddit.com"+permalink+".json"
        return url
    }
    
}
