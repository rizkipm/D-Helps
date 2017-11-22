//
//  ViewControllerFeedKonsultasi.swift
//  D-Help
//
//  Created by Rizki Syaputra on 11/22/17.
//  Copyright © 2017 Rizki Syaputra. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage


class ViewControllerFeedKonsultasi: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
     var arrayKatalogBerita = [[String:String]]()
    
    @IBOutlet weak var etPost: UITextField!
    

    @IBOutlet weak var tableFeed: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableFeed.delegate = self
        tableFeed.dataSource = self
        loadData()
        
        
        

        // Do any additional setup after loading the view.
    }
    
    func loadData() {
        Alamofire.request("http://localhost/DehelpServer/index.php/api/getFeedAllKonsulatasi").responseJSON { (response) in
            
            //check response
            if response.result.isSuccess {
                //kalau response success kita ambil json
                let json = JSON(response.result.value as Any)
                //get jsonarray dari json diatas
                self.arrayKatalogBerita = json["data"].arrayObject as! [[String : String]]
                //check di log
                // print(self.arrayberita)
                
                //check jumlah array
                if(self.arrayKatalogBerita.count > 0){
                    
                    //refresh tableview
                    self.tableFeed.reloadData()
                }
            }
            else{
                
                print("error server")
                
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayKatalogBerita.count
    }
    
    
    
    @IBAction func btnPosting(_ sender: Any) {
        
        if etPost.text == "" {
            // create the alert
            let alert = UIAlertController(title: "Warning", message: "Please write some teks", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }else{
            let nampungData = etPost.text
            let params = ["judul_post" : nampungData!]
            let url = "http://localhost/DehelpServer/index.php/api/inputPostUser"
            
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                //check response
                if response.result.isSuccess {
                    //kalau response success kita ambil json
                    let json = JSON(response.result.value as Any)
                    
                    let nResult = json["result"].stringValue
                    
                    if nResult == "true"{
                        print("Data Berhasil di post")
                        self.loadData()
                    }else{
                        let alert = UIAlertController(title: "Failed", message: "Data Gagal disimpan", preferredStyle: UIAlertControllerStyle.alert)
                        
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellFeedKonsultasi", for: indexPath) as! cellFeedKonsultasi
        
        // Configure the cell...
        
        var idServerBuku = arrayKatalogBerita[indexPath.row]

        
        var id_post =  idServerBuku["id_post"]
        let judul_post = idServerBuku["judul_post"]
        let tgl_post = idServerBuku["tgl_post"]
        let nama_user = idServerBuku["nama_user"]
        
        
        //pindahkan ke label
        cell.feedJudul.text = judul_post
        cell.feedBy.text = "By : " + nama_user!
        cell.feedTgl.text = "Tanggal : " + tgl_post!
        
        
        
        
        return cell
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
