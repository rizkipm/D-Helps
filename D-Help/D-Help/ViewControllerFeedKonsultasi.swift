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
    
    

    @IBOutlet weak var tableFeed: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableFeed.delegate = self
        tableFeed.dataSource = self
        
        Alamofire.request("http://localhost/DehelpServer/index.php/api/getKategoriBuku").responseJSON { (response) in
            
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
        
        

        // Do any additional setup after loading the view.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayKatalogBerita.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellFeedKonsultasi", for: indexPath) as! cellFeedKonsultasi
        
        // Configure the cell...
        
        var idServerBuku = arrayKatalogBerita[indexPath.row]
        
        
        var id_kategori =  idServerBuku["id_kategori"]
        let kategori = idServerBuku["nama_kategori"]
        
        
        //pindahkan ke label
        cell.feedJudul.text = kategori
        
        
        
        
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
