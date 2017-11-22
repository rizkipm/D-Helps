//
//  KategoriBukuTableController.swift
//  D-Help
//
//  Created by Rizki Syaputra on 11/22/17.
//  Copyright © 2017 Rizki Syaputra. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage


class KategoriBukuTableController: UITableViewController {
    
    var arrayKategoriBuku = [[String:String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("http://localhost/DehelpServer/index.php/api/getKategoriBuku").responseJSON { (response) in
            
            //check response
            if response.result.isSuccess {
                //kalau response success kita ambil json
                let json = JSON(response.result.value as Any)
                //get jsonarray dari json diatas
                self.arrayKategoriBuku = json["data"].arrayObject as! [[String : String]]
                //check di log
                // print(self.arrayberita)
                
                //check jumlah array
                if(self.arrayKategoriBuku.count > 0){
                    
                    //refresh tableview
                    self.tableView.reloadData()
                }
            }
            else{
                
                print("error server")
                
            }
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayKategoriBuku.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellBuku", for: indexPath) as! CellBukuTableViewCell

        // Configure the cell...
        
        var idServerBuku = arrayKategoriBuku[indexPath.row]
        
        
        var id_kategori =  idServerBuku["id_kategori"]
        let kategori = idServerBuku["nama_kategori"]
        var gambar = idServerBuku["img_kategori"]
        
        //pindahkan ke label
        cell.labelKategori.text = kategori
        
        //download gambar dari server
        Alamofire.request("http://localhost/DehelpServer/foto/"+gambar!).responseImage { (datagambar) in
            
            //check response
            if datagambar.result.isSuccess {
                
                //ambil gambar yang udah dikirim server
                let gambarserver = datagambar.result.value
                
                //tempelin ke image di cell tableview
                cell.imgCoverKat.image = gambarserver
                
            }
                //if error
            else{
                
            }
        }
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
