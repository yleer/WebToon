//
//  DateHeaderReusableView.swift
//  WebToon
//
//  Created by Yundong Lee on 2021/02/16.
//

import UIKit

class DateHeaderReusableView: UICollectionReusableView {
    
    @IBOutlet weak var blankView: UIView!{
        didSet{
            print("blankViewSize : \(blankView.frame)")
        }
    }
    @IBOutlet weak var dateScroll: UIScrollView!{
        didSet{
            dateScroll.contentSize = CGSize(width: 480, height: 40)
            for xCoordinate in 0..<8{
                let selectDate = UITapGestureRecognizer(target: self, action: #selector(selectDayOfWeek))
                let label = UILabel(frame: CGRect(x: xCoordinate * 60, y: 0, width: 60, height: 40))
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
    
    var labelArray = [UILabel]()
    private var selectedLabel : UILabel?
    
    var chosenDate : Int = 5
    
    @objc func selectDayOfWeek(sender: UITapGestureRecognizer){
        switch sender.state {
        case .ended:
            if let chosenLabel = sender.view as? UILabel{
                selectedLabel?.backgroundColor = .white
                selectedLabel = chosenLabel
                selectedLabel?.backgroundColor = #colorLiteral(red: 0, green: 0.6358990073, blue: 0, alpha: 1)
                if let index = labelArray.firstIndex(of: chosenLabel){
                    delegate?.changeDate(index: index)
                    chosenDate = index
                }
            }
        default:
            print("error")
        }
    }
    
    
    var delegate : headerDelegate?
}



protocol headerDelegate {
    func changeDate(index : Int)
}
