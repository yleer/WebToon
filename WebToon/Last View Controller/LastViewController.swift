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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isStatusBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
      
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = .gray
        if let url = episode?.episodeUrl{
            let myRequest = URLRequest(url: url)
            webView.load(myRequest)
        }
        webView.scrollView.delegate = self
        
        if let title = episode?.episodeTitle{
            navigationController?.navigationBar.topItem?.backButtonTitle = title
        }
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
