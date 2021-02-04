//
//  EpisodeHeader.swift
//  WebToon
//
//  Created by Yundong Lee on 2021/02/03.
//

import UIKit

class EpisodeHeader: UITableViewHeaderFooterView {
    
    let thumnailImage = UIImageView()
    let webtoonTitle = UILabel()
    let author = UILabel()
    let webtoonDescription = UILabel()
    
    override init(reuseIdentifier: String?) {
           super.init(reuseIdentifier: reuseIdentifier)
           configureContents()
    }
    
    func returnContent()->UIView{
        return contentView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    init(image : UIImage, title : String) {
//        thumnailImage.image = image
//        webtoonTitle.text = title
//    }
    
    func configureContents() {
        // making views to be positioned by auto layout.
        thumnailImage.translatesAutoresizingMaskIntoConstraints = false
        webtoonTitle.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(thumnailImage)
        contentView.addSubview(webtoonTitle)

        // Center the image vertically and place it near the leading
        // edge of the view. Constrain its width and height to 50 points.
        NSLayoutConstraint.activate([
            thumnailImage.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 20),
            thumnailImage.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: 20),//or -20
            thumnailImage.heightAnchor.constraint(equalToConstant: 100), // 높이 50
            thumnailImage.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            
        // Center the label vertically, and use it to fill the remaining
        // space in the header view.
            webtoonTitle.topAnchor.constraint(equalTo: thumnailImage.layoutMarginsGuide.bottomAnchor, constant: 8),
            webtoonTitle.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 10),
            webtoonTitle.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            webtoonTitle.heightAnchor.constraint(equalToConstant: 20)
            ])
        }
    
    
    

}
