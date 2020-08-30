//
//  dataModelStruct.swift
//  The News
//
//  Created by MacBook Pro on 27/8/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import Foundation


struct TheNews:Codable {
    var  status: String
    var  totalResults: Int?
    var articles: [info]
}

//struct information:Codable {
//    var infoData: [info]
//}

struct info:Codable {
    var title: String
    var description:String
    var url:String
    var urlToImage: String?
    var publishedAt:String
}

struct source:Codable {
    var id:String
    var name:String
}

//
// struct apiStruct: Codable{
//    var code: Int?
//    var status: String
//  //  var data: surahh
//}
