//
//  MainViewController.swift
//  WebToon
//
//  Created by Yundong Lee on 2021/01/23.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isStatusBarHidden = false
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = .white
    }
    
    @IBOutlet weak var upperCollectionViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUpperView()
        configureWebtoonCollectionView()
        changeNavigationBarHeight(height: -500)
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
        view.bringSubviewToFront(upperCollectionView)
        
        for sub in view.subviews{
            print(sub.frame)
        }
    }
    
    private func configureUpperView(){
        upperCollectionView.dataSource = self
        upperCollectionView.delegate = self
    }
    
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
    private let statusbarHeight = UIApplication.shared.statusBarFrame.height

    
    func changeNavigationBarHeight(height : CGFloat ) {
        self.navigationController?.additionalSafeAreaInsets = UIEdgeInsets(top: min(0,height), left: 0, bottom: 0, right: 0   )
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == upperCollectionView{
            let index = Int(upperCollectionView.contentOffset.x / upperCollectionView.frame.size.width)
            counter = index
        }
        else if scrollView == webtoonColectionView{
            
            
            
            
//            // 스크롤 뷰가 맨 위 일떄 더 안 올라가게 막는거. top Bounce 없애기.
//            if scrollView.contentOffset.y < 0 && abs(scrollView.contentOffset.y) > 260 {
//                scrollView.contentInset.top = defaultUpperViewHeight
//            }
//
            // nav bar frame : (0.0, 48.0, 414.0, 44.0)     y ends at 92.
            
            // if scrollview.contentOffset.y == -92.
//            print(navigationController?.navigationBar.frame.maxY)
            if scrollView.contentOffset.y < 0  && scrollView.contentOffset.y > -defaultUpperViewHeight{
                // nav bar 상황에 따라.
//                print("first if : \(scrollView.contentOffset.y)")
                if abs(scrollView.contentOffset.y) <= navigationController!.navigationBar.frame.maxY{
                    // scrollview의 bound.y가 navigationController!.navigationBar.frame.maxY 보다 작거나 할때 inset 항상 유지.
//                    print("should stop scrolling")
                    scrollView.contentInset.top = navigationController!.navigationBar.frame.maxY
                }else{
                    // 아직 scrollview bound y가 네비게이션 바 위치까지 안왔을때. 네비베이션 바 위치 조정해야됨.
                    // 여기서만 네비게이션 바 inset 조정하면 될듯.
                    
                    // MARK: 이 수치만 맞게 하자.
                    changeNavigationBarHeight(height: scrollView.contentOffset.y + 92) //
                    upperCollectionViewHeight.constant = -scrollView.contentOffset.y
//                    print("first if : \(scrollView.contentOffset.y)")
//                    print(upperCollectionViewHeight.constant)
                    scrollView.contentInset.top = -scrollView.contentOffset.y
                }
                
            }else if scrollView.contentOffset.y < -defaultUpperViewHeight{
                // nav bar 항상 안 보여야 됨
//                print("second if : \(scrollView.contentOffset.y)")
                upperCollectionViewHeight.constant = defaultUpperViewHeight
                scrollView.contentInset.top = defaultUpperViewHeight
            }else if scrollView.contentOffset.y >= 0{
                // nav bar 항상 보여야 됨
                upperCollectionViewHeight.constant = 0
//                print("last if : \(scrollView.contentOffset.y)")
                scrollView.contentInset.top = navigationController!.navigationBar.frame.maxY
            }
            upperCollectionView.reloadData()
        }
    }
    
    // MARK: Upper Collection View.
        
        @IBOutlet weak var upperView: UIView!
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
        
        // 기본 월.
        private var selectedLabel : UILabel?
        
        
        //MARK: collection view part.
        
        var model = Model()
        var chosenDate : Int = 0{
            didSet{
                webtoonColectionView.reloadData()
            }
        }
        @IBOutlet weak var webtoonColectionView: UICollectionView!
        
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
                cell.layer.borderWidth = 0.3
                
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
        
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if collectionView == webtoonColectionView{
                performSegue(withIdentifier: "webtoon list", sender: self)
                //            navigationController?.pushAnimation(controller: self)
            }
        }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destinationVC = segue.destination as! EpisodeTableViewController
            if let index = webtoonColectionView.indexPathsForSelectedItems?.first?.item{
                destinationVC.webtoon = model.webtoon[chosenDate][index]
                destinationVC.date = chosenDate
            }
        }
        
        private func createLayout() -> UICollectionViewLayout {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                                  heightDimension: .fractionalHeight(1.0))
            
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalWidth(0.459))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            
            let layout = UICollectionViewCompositionalLayout(section: section)
            return layout
        }
    }
    
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
                
                return CGSize(width: widthForLayout, height: 200)
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
                
                
                return headerView
            default:
                // 4
                assert(false, "Invalid element type")
            }
        }
        
}

