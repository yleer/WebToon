//
//  WebToonCollectionViewCell.swift
//  WebToon
//
//  Created by Yundong Lee on 2021/01/24.
//

//
// webtoon collection view webtoon thumnail.
//
import UIKit

class WebToonCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumnailImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var author: UILabel!
    
    var thumnailUrl : URL?{
        didSet {
            if thumnailUrl != nil && (oldValue != thumnailUrl) {
                fetchImage()
            }
        }
    }

    private func fetchImage() {
        if let url = thumnailUrl {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let imageData = urlContents {
                        if let imag = UIImage(data: imageData){
                            self?.thumnailImage.image = imag
                        }else{
                            print("no image available")
                        }
                    }
                }
            }
        }
    }

}
