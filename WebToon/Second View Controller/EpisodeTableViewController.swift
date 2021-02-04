//
//  EpisodeTableViewController.swift
//  WebToon
//
//  Created by Yundong Lee on 2021/02/02.
//

import UIKit

class EpisodeTableViewController: UITableViewController {
    
    var webtoon : WebtoonModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView = headerView()
        tableView.tableFooterView = footerView()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return webtoon?.episodeArray.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as! EpisodeTableViewCell
        
        cell.thumnailUrl = webtoon?.episodeArray[indexPath.row].episodeThumnailImageUrl
        cell.episodeDate.text = webtoon?.episodeArray[indexPath.row].episodeDate
        cell.episodeTitle.text = webtoon?.episodeArray[indexPath.row].episodeTitle
        cell.episodeRating.text = webtoon?.episodeArray[indexPath.row].episodeRaiting
        
        return cell
    }
    
    // MARK: configuring table view header.
    
    private func headerView() -> UIView{
        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height / 3))
        
        let imageView = UIImageView()
        let title = UILabel()
        let author = UILabel()
        let date = UILabel()
        let description = UILabel()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        author.translatesAutoresizingMaskIntoConstraints = false
        author.translatesAutoresizingMaskIntoConstraints = false
        date.translatesAutoresizingMaskIntoConstraints = false
        description.translatesAutoresizingMaskIntoConstraints = false
        
        header.addSubview(imageView)
        header.addSubview(title)
        header.addSubview(author)
        header.addSubview(date)
        header.addSubview(description)

        NSLayoutConstraint.activate([
            // image View constraints.
            imageView.topAnchor.constraint(equalTo: header.layoutMarginsGuide.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: header.layoutMarginsGuide.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: header.layoutMarginsGuide.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            // title constraints.
            title.topAnchor.constraint(equalTo: imageView.layoutMarginsGuide.bottomAnchor, constant: 20),
            title.heightAnchor.constraint(equalToConstant: 20),
            title.leadingAnchor.constraint(equalTo: header.layoutMarginsGuide.leadingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: header.layoutMarginsGuide.trailingAnchor, constant: 0),
            
            // author constraints.
            author.topAnchor.constraint(equalTo: title.layoutMarginsGuide.bottomAnchor, constant: 15),
            author.leadingAnchor.constraint(equalTo: header.layoutMarginsGuide.leadingAnchor, constant: 8),
            author.heightAnchor.constraint(equalToConstant: 15),
            author.trailingAnchor.constraint(equalTo: date.layoutMarginsGuide.leadingAnchor, constant: -20),

            // date constraints.
            date.topAnchor.constraint(equalTo: title.layoutMarginsGuide.bottomAnchor, constant: 15),
            date.trailingAnchor.constraint(equalTo: header.layoutMarginsGuide.trailingAnchor, constant: 0),
            date.heightAnchor.constraint(equalToConstant: 15),
            date.leadingAnchor.constraint(equalTo: author.layoutMarginsGuide.trailingAnchor, constant: 20),
            
            // description constraints.
            description.topAnchor.constraint(equalTo: author.layoutMarginsGuide.bottomAnchor, constant: 15),
            description.leadingAnchor.constraint(equalTo: header.layoutMarginsGuide.leadingAnchor, constant: 8),
            description.heightAnchor.constraint(equalToConstant: 15),
            description.trailingAnchor.constraint(equalTo: header.layoutMarginsGuide.trailingAnchor)
            
        ])
        
        author.setContentHuggingPriority(.defaultHigh + 1 , for: .horizontal)
        date.setContentHuggingPriority(.defaultHigh - 1, for: .horizontal)
        
        imageView.image = UIImage(named: "image3")
        title.text = webtoon?.webtoonTitle
        author.text = webtoon?.webtoonAuthor
        date.text = "화요일"
        if let dis = webtoon?.webtoonDiscription{
            description.text = dis
        }
        return header
    }
    
    // MARK: configuring table view footer.
    
    private func footerView() -> UIView{
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height / 6))
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "This app is made by me.\nClonning Naver Webtoon for practice."
        label.numberOfLines = 0
        
        footer.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: footer.layoutMarginsGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: footer.layoutMarginsGuide.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: footer.layoutMarginsGuide.trailingAnchor, constant: 0)
        ])
        footer.backgroundColor = .cyan
        return footer
    }
}
