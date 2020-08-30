//
//  ViewController.swift
//  The News
//
//  Created by MacBook Pro on 27/8/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
   
    @IBOutlet weak var loading: UIActivityIndicatorView!
    var getdata = [DbForLates]()

    @IBOutlet weak var tblView: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Latest News"
        
    
        
        // Start indicator
        loading.startAnimating()
        
        
        //Hide the seoaretor line
        tblView.separatorColor = .clear
        
        // this is the base url of
        let url = URL(string: "https://newsapi.org/v2/everything?q=latest&apiKey=0472a1c18ebf4b01b17ae65d9cb5481f")
       
        // instance create in realm
        let realmm = try! Realm()
        getdata = Array(realmm.objects(DbForLates.self)) // retrive the data from Database
        
      //  Check data empty or nil for api calling
        if getdata.count == 0 || getdata.count == nil{
            apiCalling(url: url!)
        }else {
            resetDefaults() // set the data empty on database
            
            apiCalling(url: url!) // api calling
        }
        

        
        // loading indicator hide when data successfully set in tableview
        loading.hidesWhenStopped = true
        loading.stopAnimating()
        
    }
    
    
    
    @IBAction func unwind(_ sender: UIStoryboardSegue) {
       
        
    }
    
    func apiCalling(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { (rawData, response, err) in
            
            if err == nil{
                
                var imgArray = [String]()
                
                do {
                    
                    let data = try JSONDecoder().decode(TheNews.self, from: rawData!)

                    
                     let r = try! Realm()

                    for i in 0..<data.articles.count{

                        let db = DbForLates()
                                db.title = data.articles[i].title
                                db.desc = "\(data.articles[i].description)"
                                db.url = "\(data.articles[i].url)"

                        if data.articles[i].urlToImage != nil{
                        imgArray.append(data.articles[i].urlToImage!)
                        
                        do{
                            try! r.write{
                                r.add(db)
                            }
                        }
                    }
                }
                    
              
                    // store imgUrl
                    UserDefaults.standard.set(imgArray, forKey: "imgArray")
            
                    
                    DispatchQueue.main.async {
                        self.tblView.reloadData()
                    }
                    
         
                } catch  {
                    print(error.localizedDescription)
                }
            }
    
        }.resume()
        
       
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
     

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
      
        
        // Segmented Control
        customSegment()
       
        

    }
    func customSegment(){
        
    
        let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: (navigationController?.navigationBar.frame.size.height)! + 20, width: self.view.frame.width, height: 50), buttonTitle: ["Latest","Bangladesh","Sports"])
        
        codeSegmented.delegate = self
        codeSegmented.accessibilityScroll(.right)
        codeSegmented.backgroundColor = .clear
        view.addSubview(codeSegmented)
    }
}

func resetDefaults() {
    
     let realm = try! Realm()
     try! realm.write {
     realm.deleteAll()
    }
     let defaults = UserDefaults.standard
     let dictionary = defaults.dictionaryRepresentation()
    dictionary.keys.forEach { key in
        defaults.removeObject(forKey: key)
    }

}

extension ViewController: CustomSegmentedControlDelegate{

    
    func change(to index: Int) {

        if index == 0{
            
            navigationItem.title = "Latest News"
            
            loading.startAnimating()
                 
                 resetDefaults()
                 
                 let latestUrl = "https://newsapi.org/v2/everything?q=latest&apiKey=0472a1c18ebf4b01b17ae65d9cb5481f"
                 
                 let url1 = URL(string: latestUrl)
                 
                 apiCalling(url: url1!)
                 
                 DispatchQueue.main.async {
                     self.tblView.reloadData()
                 }
            
            loading.hidesWhenStopped = true
            loading.stopAnimating()
             }
        
        
        if index == 1{
            
            navigationItem.title = "Bangladesh News"
            
            loading.startAnimating()
            
            
            resetDefaults()
            
            let bangladeshUrl = "https://newsapi.org/v2/everything?q=bangladesh&apiKey=0472a1c18ebf4b01b17ae65d9cb5481f"
            
            let url1 = URL(string: bangladeshUrl)
            
            apiCalling(url: url1!)
            
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
            
            loading.hidesWhenStopped = true
            loading.stopAnimating()
        }
        
        if index == 2{
            
            navigationItem.title = "Sports News"
            
            loading.startAnimating()
            
            resetDefaults()
            
            let sportsUrl = "https://newsapi.org/v2/everything?q=sport&apiKey=0472a1c18ebf4b01b17ae65d9cb5481f"
            
            let url1 = URL(string: sportsUrl)
            
            apiCalling(url: url1!)
            
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
            loading.hidesWhenStopped = true
            loading.stopAnimating()
        }
    }
    

}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realmm = try! Realm()
               
        getdata = Array(realmm.objects(DbForLates.self))
        
        return getdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! customTableViewCell
        

        
        cell.lvl.text = getdata[indexPath.row].title

        let defaults = UserDefaults.standard
        let imgarray = defaults.stringArray(forKey: "imgArray") ?? [String]()
     
        
     
        let url = URL(string: imgarray[indexPath.row])
                   // data task
                   URLSession.shared.dataTask(with: url!) { [weak self] data, response, error in
                   guard let data = data else {
                   return
                   }
                   DispatchQueue.main.async {
                    cell.img.image = UIImage(data: data)
                   }
                }.resume()
      
        return cell
    }
    
    
}

extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        260
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "detailsVC") as! DetailsVC
        
        nextViewController.detailsLink = indexPath.row
        
        self.present(nextViewController, animated:true, completion:nil)
    }
}

