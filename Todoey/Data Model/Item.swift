//
//  Item.swift
//  Todoey
//
//  Created by Watchara Saisomboon on 27/2/19.
//  Copyright © 2019 Watchara Saisomboon. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    //below is to declar relationship that this class is subclass of Category (inverse relationship)
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
