//
//  MainViewController.swift
//  WebToon
//
//  Created by Yundong Lee on 2021/01/23.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBOutlet weak var upperView: UIView!
    
    // 내일 이거 좀 배열 사용해서 깔끔하게 해결.
    
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            
            scrollView.contentSize = CGSize(width: 475, height: 50)
            let mondayLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 75, height: 50))
            let thuesdayLabel = UILabel(frame: CGRect(x: 75, y: 0, width: 75, height: 50))
            let wendsdayLabel = UILabel(frame: CGRect(x: 150, y: 0, width: 75, height: 50))
            let thursdayLabel = UILabel(frame: CGRect(x: 225, y: 0, width: 75, height: 50))
            let fridayLabel = UILabel(frame: CGRect(x: 300, y: 0, width: 75, height: 50))
            let saturdayLabel = UILabel(frame: CGRect(x: 375, y: 0, width: 75, height: 50))
            let sundayLabel = UILabel(frame: CGRect(x: 450, y: 0, width: 75, height: 50))
            
            

            mondayLabel.text = "월"
            thuesdayLabel.text = "화"
            wendsdayLabel.text = "수"
            thursdayLabel.text = "목"
            fridayLabel.text = "금"
            saturdayLabel.text = "토"
            sundayLabel.text = "일"
            
            let selectDate = UITapGestureRecognizer(target: self, action: #selector(selectDayOfWeek))
            let m = UITapGestureRecognizer(target: self, action: #selector(selectDayOfWeek))
            let t = UITapGestureRecognizer(target: self, action: #selector(selectDayOfWeek))
            let t2 = UITapGestureRecognizer(target: self, action: #selector(selectDayOfWeek))
            let w = UITapGestureRecognizer(target: self, action: #selector(selectDayOfWeek))
            let f = UITapGestureRecognizer(target: self, action: #selector(selectDayOfWeek))
            let s = UITapGestureRecognizer(target: self, action: #selector(selectDayOfWeek))
            
            mondayLabel.isUserInteractionEnabled = true
            thuesdayLabel.isUserInteractionEnabled = true
            wendsdayLabel.isUserInteractionEnabled = true
            thursdayLabel.isUserInteractionEnabled = true
            fridayLabel.isUserInteractionEnabled = true
            saturdayLabel.isUserInteractionEnabled = true
            sundayLabel.isUserInteractionEnabled = true
            
            mondayLabel.addGestureRecognizer(m)
            thuesdayLabel.addGestureRecognizer(t)
            wendsdayLabel.addGestureRecognizer(w)
            thursdayLabel.addGestureRecognizer(t2)
            fridayLabel.addGestureRecognizer(f)
            saturdayLabel.addGestureRecognizer(s)
            sundayLabel.addGestureRecognizer(selectDate)
            
            scrollView.addSubview(mondayLabel)
            scrollView.addSubview(thuesdayLabel)
            scrollView.addSubview(wendsdayLabel)
            scrollView.addSubview(thursdayLabel)
            scrollView.addSubview(fridayLabel)
            scrollView.addSubview(saturdayLabel)
            scrollView.addSubview(sundayLabel)
        }
    }
    
    @objc func selectDayOfWeek(sender: UITapGestureRecognizer){
        switch sender.state {
        case .ended:
            if let chosenLabel = sender.view as? UILabel{
                if let choseDate = chosenLabel.text{
                    print(choseDate)
                }
            }
        default:
            print("error")
        }
    }
}
