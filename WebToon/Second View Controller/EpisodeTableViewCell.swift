//
//  EpisodeTableViewCell.swift
//  WebToon
//
//  Created by Yundong Lee on 2021/02/02.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeTitle: UILabel!
    @IBOutlet weak var episodeRating: UILabel!
    @IBOutlet weak var episodeDate: UILabel!
    
    
    // thumnailUrl if set call fetchImage.
    var thumnailUrl : URL?{
        didSet {
            if thumnailUrl != nil && (oldValue != thumnailUrl) {
                fetchImage()
            }
        }
    }

    // fetching image from thumnailUrl and assgint image to episodeImage.
    private func fetchImage() {
        if let url = thumnailUrl {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let imageData = urlContents {
                        if let imag = UIImage(data: imageData){
                            self?.episodeImage.image = imag
                        }else{
                            print("no image available")
                        }
                        
                        
                    }
                }
            }
        }
    }
}
