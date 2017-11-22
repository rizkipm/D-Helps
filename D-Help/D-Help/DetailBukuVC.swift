//
//  DetailBukuVC.swift
//  D-Help
//
//  Created by Rizki Syaputra on 11/22/17.
//  Copyright © 2017 Rizki Syaputra. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
import AlamofireImage

class DetailBukuVC: UIViewController {
    
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    
    var passKategori:String?
    var passJudulBuku:String?
    
    var passCoverBuku:String?
    var passIsiBuku:String?
    var passSynpsis:String?
    var passPenulisBuku:String?
    var passTglKategori:String?

    @IBOutlet weak var dtlSynopsis: UITextView!
    @IBOutlet weak var dtlTglTerbit: UILabel!
    @IBOutlet weak var dtlPenulis: UILabel!
    @IBOutlet weak var dtlKategori: UILabel!
    @IBOutlet weak var dtlImageBuku: UIImageView!
    @IBOutlet weak var dtlJudulBuku: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
        dtlJudulBuku.text = passJudulBuku!
        dtlPenulis.text = "Penulis : " + passPenulisBuku!
        dtlKategori.text = "Kategori : " + passKategori!
        dtlTglTerbit.text = "Tanggal Terbit : " + passTglKategori!
        dtlSynopsis.text = "Synopsis : " + passSynpsis!
        
        myUtterance = AVSpeechUtterance(string: dtlJudulBuku.text! + dtlPenulis.text! + dtlKategori.text! +  dtlSynopsis.text)
        myUtterance.rate = 0.4
        synth.speak(myUtterance)
        
        Alamofire.request("http://localhost/DehelpServer/foto/"+passCoverBuku!).responseImage { (datagambar) in
            
            //check response
            if datagambar.result.isSuccess {
                
                //ambil gambar yang udah dikirim server
                let gambarserver = datagambar.result.value
                
                //tempelin ke image di cell tableview
                self.dtlImageBuku.image = gambarserver
                
                
            }
                //if error
            else{
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBacaLengkap(_ sender: Any) {
        
       
            
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //mengecek apakah segue dengan nama passData ada atau tidak
        if (segue.identifier == "detailLengkap"){
            //deklarasi kirimData sebagai destinasi segue dengan nama view controller : GetDataViewController
            let kirimData = segue.destination as! BacaLengkapVC
            
            kirimData.nJudul = dtlJudulBuku.text!
            kirimData.nKategori = dtlKategori.text!
            kirimData.nIsi = passIsiBuku!
            kirimData.nPenulis = dtlPenulis.text!
            
           
            
            
        }
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
