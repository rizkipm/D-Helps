//
//  LoginVC.swift
//  D-Help
//
//  Created by Rizki Syaputra on 11/23/17.
//  Copyright © 2017 Rizki Syaputra. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON
class LoginVC: UIViewController {

    @IBOutlet weak var etInputUsername: UITextField!
    
    @IBOutlet weak var etInputPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnLogin(_ sender: Any) {
        
        if etInputPassword.text == "" || etInputUsername.text == ""
            {
            // create the alert
            let alert = UIAlertController(title: "Warning", message: "Required", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }else{
            //            let nampungData = etPost.text
            let params = ["password_user" : etInputPassword.text!, "nama_user" : etInputUsername.text!]
            let url = "http://localhost/DehelpServer/index.php/api/login"
            
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                //check response
                if response.result.isSuccess {
                    //kalau response success kita ambil json
                    let json = JSON(response.result.value as Any)
                    
                    let nResult = json["result"].stringValue
                    
                    if nResult == "true"{
                        print("Berhasil login")
                        
//                        let alert = UIAlertController(title: "Success", message: "Selamat anda berhasil login", preferredStyle: UIAlertControllerStyle.alert)
//
//                        // add an action (button)
//                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//
//                        // show the alert
//                        self.present(alert, animated: true, completion: nil)
                        
                        self.performSegue(withIdentifier: "nextMenu", sender: self)
                        
                    }else if nResult == "false" {
                        let alert = UIAlertController(title: "Failed", message: "Username atau Password tidak cocok", preferredStyle: UIAlertControllerStyle.alert)
                        
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    
                    
                    
                    
                    
                    
                }
                else{
                    print("error server")
                }
            })
            
        }
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
