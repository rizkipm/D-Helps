//
//  KatalogBukuTC.swift
//  D-Help
//
//  Created by Rizki Syaputra on 11/22/17.
//  Copyright © 2017 Rizki Syaputra. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage


class KatalogBukuTC: UITableViewController {
     var nampungId : String? = nil
    var arrayKatalogBerita = [[String:String]]()
    
    var nKategori:String?
    var nJudulBuku:String?
    
    var nCoverBuku:String?
    var nSynopsis:String?
    var nPenulisbuku:String?
    var nTglKategori:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("id + " + nampungId!)
        let params = ["id_kategori" : nampungId!]
        let url = "http://localhost/DehelpServer/index.php/api/getBukuByKategori"
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            //check response
            if response.result.isSuccess {
                //kalau response success kita ambil json
                let json = JSON(response.result.value as Any)
                print(json)
                //get jsonarray dari json diatas
                self.arrayKatalogBerita = json["data"].arrayObject as! [[String : String]]
                //check di log
                // print(self.arrayberita)
                
                //check jumlah array
                if(self.arrayKatalogBerita.count > 0){
                    
                    //refresh tableview
                    self.tableView.reloadData()
                }
            }
            else{
                print("error server")
            }
        })

        
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
        return arrayKatalogBerita.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellKatalog", for: indexPath) as! CellKatalogBuku

        // Configure the cell...
        
        var serverid = arrayKatalogBerita[indexPath.row]
        
        var id =  serverid["id_berita"]
        let judulbuku = serverid["judul_buku"]
        let nama_kategori = serverid["nama_kategori"]
        let synopsis = serverid["synopsis"]
        let penulis_buku = serverid["penulis_buku"]
        let tglTerbit = serverid["tanggal_terbit"]
        // print(judul)
        let gambarbuku = serverid["cover_buku"]
        
        //pindahkan ke label
        cell.labelJudulBuku.text = judulbuku
        cell.labelKategori.text = nama_kategori
        cell.labelPenulis.text = penulis_buku
        
        
        
        //download gambar dari server
        
        //download gambar dari server
        Alamofire.request("http://localhost/DehelpServer/foto/"+gambarbuku!).responseImage { (datagambar) in
            
            //check response
            if datagambar.result.isSuccess {
                
                //ambil gambar yang udah dikirim server
                let gambarserver = datagambar.result.value
                
                //tempelin ke image di cell tableview
                cell.imgKatalogBuku.image = gambarserver
                
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
