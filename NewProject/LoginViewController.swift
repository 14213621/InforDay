//
//  LoginViewController.swift
//  
//
//  Created by Monkey on 27/9/2017.
//

import UIKit
import Alamofire


class LoginViewController: UIViewController {
    @IBOutlet weak var userid: UITextField!
    @IBOutlet weak var password: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonClicked(_ sender: Any) {
        let parameters : Parameters = ["userid": userid.text!, "password": password.text!]
    //    let parameters : Parameters = ["userid":"hello", "password":"monkey"];

        print("login")
        print(parameters);
        //
        Alamofire.request("http://localhost:8080/backend/index.php/Welcome/getExhibInfo").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
//        Alamofire.request("https://httpbin.org/post", method: .post, parameters: parameters)
//
//            .responseString { response in
//                
//                print("Response String: \(response.result.value ?? "No data")")
//
//
//
//                let alertController = UIAlertController(title: "Title", message: response.result.value, preferredStyle: .alert)
//
//                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
//
//
//
//                self.present(alertController, animated: true, completion: nil)
//        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
