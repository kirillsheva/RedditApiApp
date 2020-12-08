//
//  CommentList.swift
//  Lab06
//
//  Created by Ker on 07.12.2020.
//  Copyright © 2020 Ker. All rights reserved.
//

import SwiftUI

struct CommentList: View {
    var comments : [PostComment]
    var body: some View {
        List{
        ForEach(comments){el in
            CommentView(el: el)
            .listRowInsets(EdgeInsets())
            .padding(5)
        }
                 
        
                    }
        
            }
}

