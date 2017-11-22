//
//  RegisterVC.swift
//  D-Help
//
//  Created by Rizki Syaputra on 11/23/17.
//  Copyright © 2017 Rizki Syaputra. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisterVC: UIViewController {

    @IBOutlet weak var etNoHp: UITextField!
    @IBOutlet weak var etAlamat: UITextField!
    @IBOutlet weak var etInputPassword: UITextField!
    @IBOutlet weak var etInputEmail: UITextField!
    @IBOutlet weak var etInputUsername: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnSubmit(_ sender: Any) {
        
        if etNoHp.text == "" || etAlamat.text == "" || etInputEmail.text == "" || etInputUsername.text == "" || etInputPassword.text == ""
        
        {
            // create the alert
            let alert = UIAlertController(title: "Warning", message: "Required", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }else{
//            let nampungData = etPost.text
            let params = ["no_hp" : etNoHp.text!, "nama_user" : etInputUsername.text!, "email_user" : etInputEmail.text!, "lokasi" : etAlamat.text!]
            let url = "http://localhost/DehelpServer/index.php/api/daftar"
            
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                //check response
                if response.result.isSuccess {
                    //kalau response success kita ambil json
                    let json = JSON(response.result.value as Any)
                    
                    let nResult = json["result"].stringValue
                    
                    if nResult == "true"{
                        print("Data Berhasil di post")
                        
                        let alert = UIAlertController(title: "Success", message: "Selamat, Register Berhasil. Silahkan login", preferredStyle: UIAlertControllerStyle.alert)
                        
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                        
                         self.performSegue(withIdentifier: "nextLogin", sender: self)
                       
                    }else{
                        let alert = UIAlertController(title: "Failed", message: "Register Gagal, Silahkan Coba Lagi", preferredStyle: UIAlertControllerStyle.alert)
                        
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
