//
//  DetailsVC.swift
//  The News
//
//  Created by MacBook Pro on 29/8/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import UIKit
import WebKit
import RealmSwift

class DetailsVC: UIViewController {
    @IBOutlet var webkit: WKWebView!
    
    var detailsLink: Int?
    
  //  fileprivate var indicatorView = UIView?.self
    
    let container: UIView = UIView()
    
    
     let activityView = UIActivityIndicatorView(style: .large)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivityIndicatory()
        
     let realm = try! Realm()
       let  getdata = Array(realm.objects(DbForLates.self)) 
        
        let urlLink = UserDefaults.standard.array(forKey: "imgArray")
       


        webkit.load(URLRequest(url: URL(string: getdata[detailsLink!].url)!))
        
        stopActivityIndicator()

    }
    

  func showActivityIndicatory() {
        
        container.frame = CGRect(x: 0, y: 0, width: 80, height: 80) // Set X and Y whatever you want
        container.backgroundColor = .clear
    

        container.center = view.center
    
   
        activityView.center = view.center

        container.addSubview(activityView)
        self.view.addSubview(container)
        activityView.startAnimating()
    }
    
    
  
    
    func stopActivityIndicator(){
        
        activityView.stopAnimating()
    
    }

}
