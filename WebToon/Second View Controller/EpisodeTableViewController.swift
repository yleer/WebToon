//
//  EpisodeTableViewController.swift
//  WebToon
//
//  Created by Yundong Lee on 2021/02/02.
//

import UIKit

class EpisodeTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = .brown
        super.viewWillAppear(animated)
        UIApplication.shared.isStatusBarHidden = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    

    // Webtoon model.
    var webtoon : WebtoonModel?
    // Webtoon Info.
    var stringDate : String?
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
    
    lazy var additionalView = additionalSpace()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.contentInsetAdjustmentBehavior = .never
        configureTopAndBottom()

        navigationController?.additionalSafeAreaInsets = .zero
    }
    
    private func configureTopAndBottom(){
        navigtionbarSetup()
        tableView.addSubview(additionalView)
        tableView.tableHeaderView = headerView()
        tableView.tableFooterView = footerView()
        tableView.bringSubviewToFront(tableView.tableHeaderView!)
    }
    
    // MARK: Configuring navigation bar.
    private func navigtionbarSetup(){
        navigationController?.navigationBar.barTintColor = .brown
        navigationController?.navigationBar.topItem?.backButtonTitle = " "
        navigationItem.rightBarButtonItems = [ UIBarButtonItem(customView: moreButtonSetUp()), UIBarButtonItem(customView: interestButtonSetUp())]
    }
    
    // Navigation Bar : interest button.
    private func interestButtonSetUp() -> UIButton{
        let interestButton = UIButton(type: .system)
        interestButton.setTitle("⊕ 관심", for: .normal)
        interestButton.titleLabel?.font = .systemFont(ofSize: EpisodeTableViewControllerConstraints.navigationBarButtonFontSize)
        interestButton.frame = EpisodeTableViewControllerConstraints.navigationBarButtonFrame
        return interestButton
    }
    
    // Navigation Bar : more button.
    private func moreButtonSetUp() -> UIButton{
        let moreButton = UIButton(type: .system)
        moreButton.setTitle("⋮", for: .normal)
        moreButton.titleLabel?.font = .systemFont(ofSize: EpisodeTableViewControllerConstraints.navigationBarButtonFontSize)
        moreButton.contentHorizontalAlignment = .right
        moreButton.frame = EpisodeTableViewControllerConstraints.navigationBarButtonFrame
        return moreButton
    }

    
    // MARK: Change navigation bar according to its location.
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // Make Nav bar Back Button's title to be webtoon's title if, if condition.
        // Make Nav bar Back Button's title to be  "" if, else condition.
        if let titleView = tableView.tableHeaderView?.subviews[1]{
            if tableView.contentOffset.y  > titleView.frame.origin.y + titleView.frame.height - scrollView.safeAreaInsets.top{
                navigationController?.navigationBar.backItem?.backButtonTitle = webtoon!.webtoonTitle
            }else{
                navigationController?.navigationBar.backItem?.backButtonTitle = ""
            }
        }
        
        // Change UI according to scroll view's offset.
        if scrollView.contentOffset.y == -scrollView.safeAreaInsets.top{
            additionalView.isHidden = false
            navigationController?.navigationBar.barTintColor = .brown
            navigationController?.navigationBar.tintColor = .white
        }else{
            additionalView.isHidden = true
            navigationController?.navigationBar.barTintColor = .white
            navigationController?.navigationBar.tintColor = .black
        }
        
        tableView.bringSubviewToFront(tableView.tableHeaderView!)
    }
    
    // Return a view that have same color with nav bar to look like real app.
    private func additionalSpace() -> UIView{
        let endOfNavigationBar = CGFloat(0)
        let view = UIView(frame: CGRect(x: 0, y: endOfNavigationBar, width: tableView.frame.width, height: EpisodeTableViewControllerConstraints.additionalSpaceHeight))
        view.backgroundColor = .brown
        return view
    }
    
    
    // If table selected, segue to its episode.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showWebtoon", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! LastViewController
        if let index = tableView.indexPathForSelectedRow{
            destinationVC.episode = webtoon?.episodeArray[index.row]
        }
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return webtoon!.episodeArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as! EpisodeTableViewCell
        
        // setting cell's desgin?
        cell.episodeImage.layer.cornerRadius = EpisodeTableViewControllerConstraints.tabelViewCellImageCornerRadius
        cell.episodeTitle.font = UIFont.systemFont(ofSize: EpisodeTableViewControllerConstraints.tabelViewCellTitleFont)
        cell.episodeRating.font = UIFont.systemFont(ofSize: EpisodeTableViewControllerConstraints.tableViewCellOtherFonts)
        cell.episodeRating.textColor = .gray
        cell.episodeDate.font = UIFont.systemFont(ofSize: EpisodeTableViewControllerConstraints.tableViewCellOtherFonts)
        cell.episodeDate.textColor = .gray
        
        // putting actual info to properties.
        cell.thumnailUrl = webtoon!.episodeArray[indexPath.row].episodeThumnailImageUrl
        cell.episodeDate.text = webtoon!.episodeArray[indexPath.row].episodeDate
        cell.episodeTitle.text = webtoon!.episodeArray[indexPath.row].episodeTitle
        cell.episodeRating.text = "★" + webtoon!.episodeArray[indexPath.row].episodeRaiting

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
        
        label.text = "I made this.\nClonning Naver Webtoon for practice."
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
