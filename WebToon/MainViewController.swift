//
//  MainViewController.swift
//  WebToon
//
//  Created by Yundong Lee on 2021/01/23.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    var model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webtoonColectionView.dataSource = self
        webtoonColectionView.delegate = self
        webtoonColectionView.collectionViewLayout = createLayout()
        webtoonColectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webtoonColectionView?.backgroundColor = .white
    }
    
    @IBOutlet weak var upperView: UIView!
    
    
    // MARK: date choosing scroll view part.
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            var labelArray = [UILabel]()
            scrollView.contentSize = CGSize(width: 475, height: 50)
            for xCoordinate in 0..<7{
                let selectDate = UITapGestureRecognizer(target: self, action: #selector(selectDayOfWeek))
                let label = UILabel(frame: CGRect(x: xCoordinate * 75, y: 0, width: 75, height: 50))
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
                if let choseDate = chosenLabel.text{
                    print(choseDate)
                }
            }
        default:
            print("error")
        }
    }
    
    //MARK: collection view part.
    @IBOutlet weak var webtoonColectionView: UICollectionView!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.mondayWebtoon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "webtoon thumnail", for: indexPath) as! WebToonCollectionViewCell
        
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.4
        
        cell.thumnailUrl = model.mondayWebtoon[indexPath.row].webtoonThumNailUrl
        cell.title.text = model.mondayWebtoon[indexPath.row].webtoonTitle
        cell.author.text = model.mondayWebtoon[indexPath.row].webtoonAuthor
        cell.rating.text = "⭐︎" + model.mondayWebtoon[indexPath.row].webtoonRating
        cell.rating.textColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
    
    // 200 => 14 6   ->  7 : 3 비율
    
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
    }}

