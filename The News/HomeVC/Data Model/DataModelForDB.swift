//
//  DataModelForDB.swift
//  The News
//
//  Created by MacBook Pro on 27/8/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import Foundation
import RealmSwift



class DbForLates: Object {
    @objc dynamic var title = ""
    @objc dynamic var desc = ""
    @objc dynamic var url = ""
    @objc dynamic var urlToImage = ""
}



/*
 
 var title: String
 var description:String
 var url:String
 var urlToImage: String?
 var publishedAt:String
 
 */
