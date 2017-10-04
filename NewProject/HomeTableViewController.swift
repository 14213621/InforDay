//
//  HomeTableViewController.swift
//  NewProject
//
//  Created by XDeveloper on 20/9/2017.
//  Copyright © 2017 monkey. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift


class HomeTableViewController: UITableViewController {
var firedJson:JSON?;
    var realmResults:Results<WebNews>?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("http://localhost:8080/backend/index.php/Welcome/", method: .get).responseJSON { response in

            switch response.result{

            case .success(let data) :

                print("Hello!! \(response.result)")
                print("Request: \(String(describing: response.request))")   // original url request
                print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(response.result)")                         // response serialization result

                let json = JSON(data)
                print("JSON: \(json)") // serialized json response

                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)") // original server data as UTF8 string
                }

            case .failure(let error):
                print("Error : \(error)" )

            }
        }

        let realm = try! Realm()
        realmResults = realm.objects(WebNews.self)
        
        let url = "https://api.myjson.com/bins/xeerx"
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            
           // print("Result: \(response.result)") // response serialization result
            
            switch response.result {
                
            case .success(let value):
                //print("JSON: \(value)") // serialized json response
              //  self.firedJson = JSON(value);

                let json = JSON(value)
                
                let jsonString = "{\"id\":\"1\",\"name\":\"Shanghai Commercial Bank Hackathon\",\"image\":\"https://cslinux0.comp.hkbu.edu.hk/~mtchoy/sh.jpg\"}";
                
                realm.beginWrite()
                
                let entry: WebNews = WebNews(JSONString: jsonString)!
                realm.add(entry, update: true)
                
                do {
                    try realm.commitWrite()
                } catch {
                }
                
                
               //let jsonString = "{\"id\":\"1\",\"name\":\"Shanghai Commercial Bank Hackathon\",\"image\":\"https://cslinux0.comp.hkbu.edu.hk/~mtchoy/sh.jpg\"}";
                
                realm.beginWrite()
                
                //let entry: WebNews = WebNews(JSONString: jsonString)!
                //realm.add(entry, update: true)
                
                for (index,subJson):(String, JSON) in json {
                    let entry: WebNews = WebNews(JSONString: subJson.rawString()!)!
                    realm.add(entry, update: true)
                //    print(index);
                }
                
                do {
                    try realm.commitWrite()
                } catch {
                }
                
                self.realmResults = realm.objects(WebNews.self)
               // print("A record: \(self.firedJson?[0]["name"].stringValue ?? "No Data" )")
               self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let results = realmResults {
            return results.count
        } else {
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath)
        
        // Configure the cell...
        print("table view")
        
        if let cellImage = cell.viewWithTag(100) as? UIImageView {
            
           // let firedUrl = firedJson?[indexPath.row]["image"].stringValue
            let firedUrl = realmResults?[indexPath.row].image

            if let url = firedUrl {
                
                Alamofire.request(url).responseData {
                    response in
                    
                    if let data = response.result.value {
                        cellImage.image = UIImage(data: data, scale:1)
                    }
                }
            }
        }
        
        if let cellLabel = cell.viewWithTag(101) as? UILabel {
            //cellLabel.text = firedJson?[indexPath.row]["name"].stringValue
            cellLabel.text = realmResults?[indexPath.row].name

        }
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
