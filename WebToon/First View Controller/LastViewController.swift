//
//  LastViewController.swift
//  WebToon
//
//  Created by Yundong Lee on 2021/02/13.
//

import UIKit
import WebKit
import Swift

class LastViewController: UIViewController, UIScrollViewDelegate {

    var episode : Episode?
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet var webView: WKWebView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = .gray
        if let url = episode?.episodeUrl{
            let myRequest = URLRequest(url: url)
            webView.load(myRequest)
        }
        webView.scrollView.delegate = self
        navigationController?.navigationBar.isHidden = true
        
        if let title = episode?.episodeTitle{
            navigationController?.navigationBar.topItem?.backButtonTitle = title
        }
        
        let tap = UISwipeGestureRecognizer(target: self, action: #selector(Tap))
        let ll = UIPanGestureRecognizer(target: self, action: #selector(Tap))
        parentView.addGestureRecognizer(tap)
        parentView.addGestureRecognizer(ll)
        webView.scrollView.addGestureRecognizer(tap)
        

    }
    
    @objc func Tap(){
        print("Hdfg")
    }
    
    

    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentInsetAdjustmentBehavior = .never
        if scrollView.bounds.origin.y > 0{
            navigationController?.navigationBar.isHidden = true
            UIApplication.shared.isStatusBarHidden = true
            
        }else{
            navigationController?.navigationBar.isHidden = false
            UIApplication.shared.isStatusBarHidden = false
        }
    }
    
    
    // tap gesture need to be changed. -> show nav bar and status bar.

}
