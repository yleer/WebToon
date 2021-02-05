//
//  MainViewController.swift
//  WebToon
//
//  Created by Yundong Lee on 2021/01/23.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        upperCollectionView.dataSource = self
        upperCollectionView.delegate = self
        webtoonColectionView.dataSource = self
        webtoonColectionView.delegate = self
        webtoonColectionView.collectionViewLayout = createLayout()
        webtoonColectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webtoonColectionView?.backgroundColor = .white
        webtoonColectionView.bounces = false
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: Upper Collection View.
    
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var upperCollectionView: UICollectionView!
    let upperImage = [UIImage(named: "image1"),UIImage(named: "image2"),UIImage(named: "image3"),UIImage(named: "image4"), UIImage(named: "image5")]
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
    
    // MARK: date choosing scroll view part.
    
    var labelArray = [UILabel]()
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.contentSize = CGSize(width: 480, height: 40)
            for xCoordinate in 0..<8{
                let selectDate = UITapGestureRecognizer(target: self, action: #selector(selectDayOfWeek))
                let label = UILabel(frame: CGRect(x: xCoordinate * 60, y: 0, width: 60, height: 50))
                label.isUserInteractionEnabled = true
                label.addGestureRecognizer(selectDate)
                labelArray.append(label)
            }

            labelArray[0].text = "월" ; labelArray[0].textAlignment = .center
            labelArray[1].text = "화" ; labelArray[1].textAlignment = .center
            labelArray[2].text = "수" ; labelArray[2].textAlignment = .center
            labelArray[3].text = "목" ; labelArray[3].textAlignment = .center
            labelArray[4].text = "금" ; labelArray[4].textAlignment = .center
            labelArray[5].text = "토" ; labelArray[5].textAlignment = .center
            labelArray[6].text = "일" ; labelArray[6].textAlignment = .center
            labelArray[7].text = "완결" ; labelArray[7].textAlignment = .center
            
            for label in labelArray{
                scrollView.addSubview(label)
            }
            selectedLabel = labelArray[0]
            selectedLabel?.backgroundColor = #colorLiteral(red: 0, green: 0.6358990073, blue: 0, alpha: 1)
        }
    }
    // 기본 월.
    private var selectedLabel : UILabel?
    
    @objc func selectDayOfWeek(sender: UITapGestureRecognizer){
        switch sender.state {
        case .ended:
            if let chosenLabel = sender.view as? UILabel{
                selectedLabel?.backgroundColor = .white
                selectedLabel = chosenLabel
                selectedLabel?.backgroundColor = #colorLiteral(red: 0, green: 0.6358990073, blue: 0, alpha: 1)
                if let index = labelArray.firstIndex(of: chosenLabel){
                    chosenDate = index
                }
            }
        default:
            print("error")
        }
    }
    
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = Int(upperCollectionView.contentOffset.x / upperCollectionView.frame.size.width)
        counter = index
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == webtoonColectionView{
            performSegue(withIdentifier: "webtoon list", sender: self)
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
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = upperCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}

