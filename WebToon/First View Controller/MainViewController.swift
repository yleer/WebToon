//
//  MainViewController.swift
//  WebToon
//
//  Created by Yundong Lee on 2021/01/23.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, headerDelegate  {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isStatusBarHidden = false
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
        if webtoonColectionView.contentOffset.y > -defaultUpperViewHeight + additionalSpaceForNavBarShow{

            navigationController?.setNavigationBarHidden(false, animated: true)
        }else{
            navigationController?.setNavigationBarHidden(true, animated: true)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUpperView()
        navigtionbarSetup()
        configureWebtoonCollectionView()
        slideUpperView()
        view.bringSubviewToFront(upperCollectionView)
    }
    
    // Set up Nav bar.
    private func navigtionbarSetup(){
        navigationItem.title = MainViewControllerConstraints.navigationTitle
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cookieButton())
        navigationItem.rightBarButtonItems = [ UIBarButtonItem(customView: searchButton()), UIBarButtonItem(customView: smileButton())]
    }
    // Nav bar cookie Button
    private func cookieButton() -> UIButton{
        let cookieButton = UIButton(type: .system)
        cookieButton.setTitle("🍪", for: .normal)
        cookieButton.titleLabel?.font = .systemFont(ofSize: MainViewControllerConstraints.navigationBarButtonFontSize)
        cookieButton.frame = CGRect(x: MainViewControllerConstraints.navigationBarFrameOrigin.x, y: MainViewControllerConstraints.navigationBarFrameOrigin.y, width: MainViewControllerConstraints.navigationBarButtonFrameSize, height: MainViewControllerConstraints.navigationBarButtonFrameSize)
        return cookieButton
    }
    // Nav bar smile Button
    private func smileButton() -> UIButton{
        let interestButton = UIButton(type: .system)
        interestButton.setTitle("😀", for: .normal)
        interestButton.titleLabel?.font = .systemFont(ofSize: MainViewControllerConstraints.navigationBarButtonFontSize)
        interestButton.frame = CGRect(x: MainViewControllerConstraints.navigationBarFrameOrigin.x
                                      , y: MainViewControllerConstraints.navigationBarFrameOrigin.y, width: MainViewControllerConstraints.navigationBarButtonFrameSize, height: MainViewControllerConstraints.navigationBarButtonFrameSize)
        return interestButton
    }
    // Nav bar search Button
    private func searchButton() -> UIButton{
        let moreButton = UIButton(type: .system)
        moreButton.setTitle("🔍", for: .normal)
        moreButton.titleLabel?.font = .systemFont(ofSize: MainViewControllerConstraints.navigationBarButtonFontSize)
        moreButton.contentHorizontalAlignment = .right
        moreButton.frame = CGRect(x: MainViewControllerConstraints.navigationBarFrameOrigin.x, y: MainViewControllerConstraints.navigationBarFrameOrigin.y, width: MainViewControllerConstraints.navigationBarButtonFrameSize, height: MainViewControllerConstraints.navigationBarButtonFrameSize)
        return moreButton
    }
    
    
    // MARK: Setting Upper Collection View and Webtoon Collection View.
    
    
    // automatic scrolling upperView image to next image.
    private func slideUpperView(){
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(MainViewControllerConstraints.upperViewTimeInterval), target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    // configureing UpperView
    private func configureUpperView(){
        upperCollectionView.dataSource = self
        upperCollectionView.delegate = self
    }
    
    // configureing webtoon collectionView.
    private func configureWebtoonCollectionView(){
        webtoonColectionView.dataSource = self
        webtoonColectionView.delegate = self
        let layout = webtoonColectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionHeadersPinToVisibleBounds = true
        webtoonColectionView?.backgroundColor = .white
        webtoonColectionView.contentInsetAdjustmentBehavior = .never
        
        // top inset part.
        webtoonColectionView.contentInset.top = defaultUpperViewHeight
        
    }
    
    private let defaultUpperViewHeight : CGFloat = 260
    private let additionalSpaceForNavBarShow : CGFloat = 20
    
    @IBOutlet weak var upperCollectionViewHeight: NSLayoutConstraint!
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == upperCollectionView{
            let index = Int(upperCollectionView.contentOffset.x / upperCollectionView.frame.size.width)
            counter = index
        }
        else if scrollView == webtoonColectionView{
            
            // 스크롤 뷰가 맨 위 일떄 더 안 올라가게 막는거. top Bounce 없애기.
            if scrollView.contentOffset.y < 0 && abs(scrollView.contentOffset.y) > defaultUpperViewHeight {
                scrollView.contentOffset.y = -defaultUpperViewHeight
                upperCollectionViewHeight.constant = defaultUpperViewHeight
            }
              
           
            // nav bar sliding.
            if scrollView.contentOffset.y > -defaultUpperViewHeight + additionalSpaceForNavBarShow{
                navigationController?.setNavigationBarHidden(false, animated: true)
            }else{
                navigationController?.setNavigationBarHidden(true, animated: true)
            }

            

            if scrollView.contentOffset.y < 0  && scrollView.contentOffset.y > -defaultUpperViewHeight{
                if scrollView.safeAreaInsets.top >= -scrollView.contentOffset.y{
                    upperCollectionViewHeight.constant = 0
                    scrollView.contentInset.top = navigationController!.navigationBar.frame.maxY
                }else{
                    upperCollectionViewHeight.constant = -scrollView.contentOffset.y
                    scrollView.contentInset.top = -scrollView.contentOffset.y
                }
                
            }else if scrollView.contentOffset.y >= 0{
                // nav bar 항상 보여야 됨
                upperCollectionViewHeight.constant = 0
                scrollView.contentInset.top = navigationController!.navigationBar.frame.maxY
            }
            upperCollectionView.reloadData()
        }
    }
    
    // MARK: Configure Upper Collection View.
    @IBOutlet weak var upperCollectionView: UICollectionView!
    let upperImage = [UIImage(named: "1"),UIImage(named: "2"),UIImage(named: "3"),UIImage(named: "4"), UIImage(named: "5")]
    var timer = Timer()
    var counter = 0
    
    @objc func changeImage(){
        if counter < upperImage.count{
            let index = IndexPath(item: counter, section: 0)
            upperCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            counter += 1
        }else{
            counter = 0
            let index = IndexPath(item: counter, section: 0)
            upperCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        }
    }
    
    // MARK: Configure Webtoon collection view.
    @IBOutlet weak var webtoonColectionView: UICollectionView!
    
    var model = Model()
    
    // headerDelegate to change WebtoonCollection view data source.
    func changeDate(index: Int) {
        chosenDate = index
    }
    
    // control WebtoonCollection view's data source.
    var chosenDate : Int = 0{
        didSet{
            webtoonColectionView.reloadData()
        }
    }
    
    // MARK: Collection Views data source and delegate methods.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == webtoonColectionView{
            return model.webtoon[chosenDate].count
        }else{
            return upperImage.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == webtoonColectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "webtoon thumnail", for: indexPath) as! WebToonCollectionViewCell
            
            cell.layer.borderColor = UIColor.gray.cgColor
            cell.layer.borderWidth = MainViewControllerConstraints.webtoonCollectionViewBorderWidth
            
            cell.thumnailUrl = model.webtoon[chosenDate][indexPath.row].webtoonThumNailUrl
            cell.title.text = model.webtoon[chosenDate][indexPath.row].webtoonTitle
            cell.author.text = model.webtoon[chosenDate][indexPath.row].webtoonAuthor
            cell.rating.text = "★" + model.webtoon[chosenDate][indexPath.row].webtoonRating
            cell.rating.textColor = .red
            cell.author.textColor = .gray
            return cell
        }else{
            let itemToShow = upperImage[indexPath.row % upperImage.count]
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upper view cell", for: indexPath) as! UpperCollectionViewCell
            
            cell.imageView.image = itemToShow
            cell.imageView.sizeToFit()
            
            return cell
        }
    }
    
    // Segue Part.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == webtoonColectionView{
            performSegue(withIdentifier: "webtoon list", sender: self)
            
            //                 navigationController?.pushAnimation(controller: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! EpisodeTableViewController
        destinationVC.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        if let index = webtoonColectionView.indexPathsForSelectedItems?.first?.item{
            destinationVC.webtoon = model.webtoon[chosenDate][index]
            destinationVC.date = chosenDate
        }
    }
}


// MARK: Collection View FlowLayout part.
extension MainViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == upperCollectionView{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }else{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == upperCollectionView{
            let size = upperCollectionView.frame.size
            return CGSize(width: size.width, height: size.height)
        }else{
            let widthForLayout = webtoonColectionView.frame.maxX / 3
            
            return CGSize(width: widthForLayout, height: MainViewControllerConstraints.webtoonCollectionViewCellHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == upperCollectionView{
            return 0.0
        }else{
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == upperCollectionView{
            return 0.0
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard
                let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "dateID",
                    for: indexPath) as? DateHeaderReusableView
            
            else {
                fatalError("Invalid view type")
            }
            
            headerView.delegate = self
            return headerView
        default:
            // 4
            assert(false, "Invalid element type")
        }
    }
}
