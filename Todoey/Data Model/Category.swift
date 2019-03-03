//
//  Category.swift
//  Todoey
//
//  Created by Watchara Saisomboon on 27/2/19.
//  Copyright © 2019 Watchara Saisomboon. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    //List is like array and this is to declar that items property is set to have things in Item class
    let items = List<Item>()
}
