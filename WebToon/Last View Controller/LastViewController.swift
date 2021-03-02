//
//  LastViewController.swift
//  WebToon
//
//  Created by Yundong Lee on 2021/02/13.
//

//
// Final View Controller showing actual webtoon contentes.
//

import UIKit
import WebKit
import Swift

class LastViewController: UIViewController, UIScrollViewDelegate {

    // webtoon's episode that's shown in the controller.
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
        
        setUpNavBar()
        setUpWebView()
    }
    
    // MARK: Setting Web View to show its content.
    private func setUpWebView(){
        webView.scrollView.delegate = self
        if let url = episode?.episodeUrl{
            let myRequest = URLRequest(url: url)
            webView.load(myRequest)
        }
    }
    
    // MARK: Setting up Navigation Bar.
    private func setUpNavBar(){
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = .gray
        if let title = episode?.episodeTitle{
            navigationController?.navigationBar.topItem?.backButtonTitle = title
        }
    }
    
    // MARK: Show Navigation Bar if scrolled to top. Hide Navigation Bar else case.
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

}
