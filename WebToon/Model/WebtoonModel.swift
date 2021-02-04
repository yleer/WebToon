//
//  WebtoonModel.swift
//  WebToon
//
//  Created by Yundong Lee on 2021/01/26.
//

import Foundation

struct WebtoonModel{
    let webtoonThumNailUrl : URL
    let webtoonTitle : String
    let webtoonRating : String
    let webtoonAuthor : String
    var webtoonDiscription : String?
    var episodeArray : [Episode] = []
    
    init(url : String, title : String ,episodes : [[String]], rating : String, author : String) {
        let thumnailUrl = URL(string: url)!     // url 직접 제공하는거라 에러안남.
        webtoonThumNailUrl = thumnailUrl
        webtoonTitle = title
        webtoonRating = rating
        webtoonAuthor = author
        
        for episode in episodes{
            let ep = Episode(title: episode[0], url: episode[1], rating: episode[2], date: episode[3], thumnail: episode[4])
            episodeArray.append(ep)
        }
    }
    
    init(url : String, title : String ,episodes : [[String]], rating : String, author : String, discription : String) {
        let thumnailUrl = URL(string: url)!     // url 직접 제공하는거라 에러안남.
        webtoonThumNailUrl = thumnailUrl
        webtoonTitle = title
        webtoonRating = rating
        webtoonAuthor = author
        webtoonDiscription = discription
        
        for episode in episodes{
            let ep = Episode(title: episode[0], url: episode[1], rating: episode[2], date: episode[3], thumnail: episode[4])
            episodeArray.append(ep)
        }
        
        
    }
}
