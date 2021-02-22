//
//  EpisodeTableViewController.swift
//  WebToon
//
//  Created by Yundong Lee on 2021/02/02.
//

import UIKit

class EpisodeTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isStatusBarHidden = false
        navigationController?.navigationBar.isTranslucent = false
    }
    

    var webtoon : WebtoonModel?
    var date : Int?{
        didSet{
            if date == 0{
                stringDate = "월요웹툰"
            }else if date == 1{
                stringDate = "화요웹툰"
            }else if date == 2{
                stringDate = "수요웹툰"
            }else if date == 3{
                stringDate = "목요웹툰"
            }else if date == 4{
                stringDate = "금요웹툰"
            }else if date == 5{
                stringDate = "토요웹툰"
            }else if date == 6{
                stringDate = "일요웹툰"
            }
        }
    }
    
    var stringDate : String?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
//        navigationController?.navigationBar.isHidden = true
//        navigationController?.navigationBar.isHidden = false
        configureTopAndBottom()
//        print(navigationController?.navigationBar.isHidden)
        print(navigationController?.navigationBar.frame)
        self.navigationController?.additionalSafeAreaInsets = UIEdgeInsets(top:0, left: 0, bottom: 0, right: 0)
        print(navigationController?.navigationBar.frame)
    }
    
    private func configureTopAndBottom(){
        navigtionbarSetup()
        navigationController?.navigationBar.barTintColor = .brown
        tableView.addSubview(additionalSpace())
        tableView.tableHeaderView = headerView()
        tableView.tableFooterView = footerView()
        tableView.bringSubviewToFront(tableView.tableHeaderView!)
    }
    
    
    
    // MARK: Configuring navigation tab bar.
    private func navigtionbarSetup(){
        // MARK: need to fix isTranslucent part.
        navigationController?.navigationBar.isTranslucent = false
        
        
        
        navigationController?.navigationBar.topItem?.backButtonTitle = " "
        navigationItem.rightBarButtonItems = [ UIBarButtonItem(customView: moreButtonSetUp()), UIBarButtonItem(customView: interestButtonSetUp())]
    }
    
    private func interestButtonSetUp() -> UIButton{
        let interestButton = UIButton(type: .system)
        interestButton.setTitle("⊕ 관심", for: .normal)
        interestButton.titleLabel?.font = .systemFont(ofSize: 20)
        interestButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        return interestButton
    }
    
    private func moreButtonSetUp() -> UIButton{
        let moreButton = UIButton(type: .system)
        moreButton.setTitle("⋮", for: .normal)
        moreButton.titleLabel?.font = .systemFont(ofSize: 30)
        moreButton.contentHorizontalAlignment = .right
        moreButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        return moreButton
    }

    
    // MARK: Change navigation bar according to its location.
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(navigationController?.navigationBar.frame)
        
        if let titleView = tableView.tableHeaderView?.subviews[1]{
            if tableView.contentOffset.y  > titleView.frame.origin.y + titleView.frame.height - scrollView.safeAreaInsets.top{
                navigationController?.navigationBar.backItem?.backButtonTitle = webtoon!.webtoonTitle
            }else{
                navigationController?.navigationBar.backItem?.backButtonTitle = ""
            }
        }
        
        let viewToAdd = additionalSpace()
        if scrollView.contentOffset.y == -scrollView.safeAreaInsets.top{
            navigationController?.navigationBar.barTintColor = .brown
            tableView.addSubview(viewToAdd)
            navigationController?.navigationBar.tintColor = .white
        }else{
            for view in tableView.subviews{
                if view.frame.height == 75{
                    view.removeFromSuperview()
                }
            }
            navigationController?.navigationBar.barTintColor = .white
            navigationController?.navigationBar.tintColor = .black
        }
        
        tableView.bringSubviewToFront(tableView.tableHeaderView!)
    }
    
    private func additionalSpace() -> UIView{
        let endOfNavigationBar = CGFloat(0)

        let view = UIView(frame: CGRect(x: 0, y: endOfNavigationBar, width: tableView.frame.width, height: 75))
        view.backgroundColor = .brown

        return view
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // for all episodes need to add m.
//        performSegue(withIdentifier: "showWebtoon", sender: self)
        changeNavigationBarHeight(height: 0)
        print("did selected: \(navigationController?.navigationBar.frame)")
        
    }
    
    func changeNavigationBarHeight(height : CGFloat ) {
        self.navigationController?.additionalSafeAreaInsets = UIEdgeInsets(top: min(0,height), left: 0, bottom: 0, right: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! LastViewController
        if let index = tableView.indexPathForSelectedRow{
            destinationVC.episode = webtoon?.episodeArray[index.row]
        }
    }
    


    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return webtoon?.episodeArray.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as! EpisodeTableViewCell
        
        cell.episodeImage.layer.cornerRadius = 5
        
        cell.episodeTitle.font = UIFont.systemFont(ofSize: 15)
        cell.episodeRating.font = UIFont.systemFont(ofSize: 13)
        cell.episodeRating.textColor = .gray
        cell.episodeDate.font = UIFont.systemFont(ofSize: 13)
        cell.episodeDate.textColor = .gray
        
        cell.thumnailUrl = webtoon?.episodeArray[indexPath.row].episodeThumnailImageUrl
        cell.episodeDate.text = webtoon?.episodeArray[indexPath.row].episodeDate
        cell.episodeTitle.text = webtoon?.episodeArray[indexPath.row].episodeTitle
        if let rating = webtoon?.episodeArray[indexPath.row].episodeRaiting{
            cell.episodeRating.text = "★" + rating
        }
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
        
        
        title.font = UIFont.boldSystemFont(ofSize: 20)
        author.font = UIFont.systemFont(ofSize: 15)
        date.font = UIFont.systemFont(ofSize: 15)
        date.textColor = .gray
        description.font = UIFont.systemFont(ofSize: 15)
        description.textColor = .gray
        
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
            imageView.heightAnchor.constraint(equalToConstant: header.frame.height * (3/5)),
            
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
        
        imageView.image = UIImage(named: "1")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 3
        title.text = webtoon?.webtoonTitle
        author.text = webtoon?.webtoonAuthor
        date.text = stringDate
        
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



// 되긴 하는데 에러 나네.
extension UINavigationController{
    func pushAnimation(controller : UIViewController){
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        pushViewController(controller, animated: false)
    }
}
