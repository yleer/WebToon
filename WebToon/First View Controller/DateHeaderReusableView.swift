//
//  DateHeaderReusableView.swift
//  WebToon
//
//  Created by Yundong Lee on 2021/02/16.
//

//
// webtoon collection view header.
//

import UIKit

class DateHeaderReusableView: UICollectionReusableView {
    
    @IBOutlet weak var blankView: UIView!
    
    // scroll view setup.
    @IBOutlet weak var dateScroll: UIScrollView!{
        didSet{
            dateScroll.contentSize = CGSize(width: MainViewControllerConstraints.dateScrollViewContentWidth, height: MainViewControllerConstraints.dateLabelViewHeight)
            for xCoordinate in 0..<8{
                let selectDate = UITapGestureRecognizer(target: self, action: #selector(selectDayOfWeek))
                let label = UILabel(frame: CGRect(x: CGFloat(xCoordinate) * MainViewControllerConstraints.dateLabelViewWidth, y: 0, width: MainViewControllerConstraints.dateLabelViewWidth, height: MainViewControllerConstraints.dateLabelViewHeight))
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
                dateScroll.addSubview(label)
            }
            selectedLabel = labelArray[0]
            selectedLabel?.backgroundColor = #colorLiteral(red: 0, green: 0.6358990073, blue: 0, alpha: 1)
            print("scrollView : \(dateScroll.frame)")
        }
        
    }
    
    private var labelArray = [UILabel]()
    private var selectedLabel : UILabel?
    
    // show the chosen date.
    @objc func selectDayOfWeek(sender: UITapGestureRecognizer){
        switch sender.state {
        case .ended:
            if let chosenLabel = sender.view as? UILabel{
                selectedLabel?.backgroundColor = .white
                selectedLabel = chosenLabel
                selectedLabel?.backgroundColor = #colorLiteral(red: 0, green: 0.6358990073, blue: 0, alpha: 1)
                if let index = labelArray.firstIndex(of: chosenLabel){
                    delegate?.changeDate(index: index)
                }
            }
        default:
            print("error")
        }
    }
    var delegate : headerDelegate?
}


// delegate to communicate with MainController.
protocol headerDelegate {
    func changeDate(index : Int)
}
