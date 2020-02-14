//
//  ToDoItem.swift
//  TODO
//
//  Created by 安子和 on 2020/2/14.
//  Copyright © 2020 安子和. All rights reserved.
//

import Foundation

class ToDoItem : Codable{

    var name : String = ""
    var hasDone : Bool = false
    
    init(name:String){
        self.name = name
    }
}
