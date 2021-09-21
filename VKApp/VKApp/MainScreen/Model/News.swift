//
//  News.swift
//  VKApp
//
//  Created by Butmalay Denis on 06.03.2021.
//

//{
//"response": {
//"items": [{
//"source_id": -24565142,
//"date": 1601902200,
//"can_doubt_category": false,
//"can_set_category": false,
//"topic_id": 19,
//"post_type": "post",
//"text": "«Сундрунские кекуры»
//
//Останцы в верхнем течении реки Сундрун, Якутия. Снимал А. Лавров: nat-geo.ru/community/user/193148",
//"marked_as_ads": 0,
//"attachments": [{
//"type": "photo",
//"photo": {
//"album_id": -7,
//"date": 1601840378,
//"id": 457329521,
//"owner_id": -24565142,
//"has_tags": false,
//"access_key": "cf0d95f95cdb1fac6f",
//"post_id": 1568083,
//"sizes": [{
//"height": 87,
//"url": "https://sun9-70.u...jJd5bevYn45e_5RZuOc",
//"type": "m",
//"width": 130
//}



import UIKit
import RealmSwift
import SwiftyJSON


struct NewsResopnse: Codable {
    let response : NewsContainer
}

struct NewsContainer : Codable {
    let items: [News]
}

class News: RealmSwift.Object, Codable {
    @objc dynamic var NewsId: Int = 0
    @objc dynamic var post_type: String = ""
    @objc dynamic private var NewsPhoto: String = ""

    required convenience init(from decoder: Decoder) throws {
           self.init()

     let container = try decoder.container(keyedBy: CodingKeys.self)
    NewsId = try container.decode(Int.self, forKey: .NewsId)
    post_type = try container.decode(String.self, forKey: .post_type)
    NewsPhoto = try container.decode(String.self, forKey: .NewsPhoto)
}
    var NewsPhotoUrl: URL? { URL(string: NewsPhoto) }


    enum CodingKeys: String, CodingKey {
           case NewsId = "source_id"
           case post_type = "post"
           case NewsPhoto = "url"
       }

func primaryKey() -> String? {
        return "NewsId"
    }

struct NewsSection: Comparable {
   let title: Character
   let news: [News]

   static func < (lhs: NewsSection, rhs: NewsSection) -> Bool {
          lhs.title < rhs.title
  }
}
    struct NewsPic: Equatable {
        let name: String
        let date: Date
        let pic: UIImage
    }

}


// NewsResponse - mb comprable





