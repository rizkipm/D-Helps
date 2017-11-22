//
//  BacaLengkapVC.swift
//  D-Help
//
//  Created by Rizki Syaputra on 11/22/17.
//  Copyright © 2017 Rizki Syaputra. All rights reserved.
//

import UIKit
import AVFoundation

class BacaLengkapVC: UIViewController {
    
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")

    @IBOutlet weak var blIsi: UITextView!
    @IBOutlet weak var blPenulis: UILabel!
    @IBOutlet weak var blKategori: UILabel!
    @IBOutlet weak var blJudul: UILabel!
    
    var nIsi = ""
    var nPenulis = ""
    var nKategori = ""
    var nJudul = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        blIsi.text = nIsi
        blPenulis.text = nPenulis
        blKategori.text = nKategori
        blJudul.text = nJudul
        
        myUtterance = AVSpeechUtterance(string: blJudul.text! + blPenulis.text! + blKategori.text! +  blIsi.text)
        myUtterance.rate = 0.4
        synth.speak(myUtterance)
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
