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
}
