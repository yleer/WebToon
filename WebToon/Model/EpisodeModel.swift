//
//  EpisodeModel.swift
//  WebToon
//
//  Created by Yundong Lee on 2021/01/26.
//

import Foundation

struct Episode {
    let episodeThumnailImageUrl : URL
    let episodeTitle : String
    let episodeDate : String
    let episodeRaiting : String
    let episodeUrl : URL
    
    
    init(title : String, url : String, rating : String, date : String, thumnail : String) {
        episodeTitle = title
        episodeUrl = URL(string: url)!
        episodeRaiting = rating
        episodeDate = date
        episodeThumnailImageUrl = URL(string: thumnail)!
        
    }
    
}
