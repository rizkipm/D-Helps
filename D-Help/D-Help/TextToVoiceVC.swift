//
//  TextToVoiceVC.swift
//  D-Help
//
//  Created by Rizki Syaputra on 11/22/17.
//  Copyright © 2017 Rizki Syaputra. All rights reserved.
//

import UIKit
import AVFoundation

class TextToVoiceVC: UIViewController {
    
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")

    @IBOutlet weak var teksHasil: UITextView!
    @IBOutlet weak var etInputTeks: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnDengar(_ sender: Any) {
        
        if etInputTeks.text == "" {
            // create the alert
            let alert = UIAlertController(title: "Warning", message: "Please write some teks", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        }else{
            teksHasil.text = etInputTeks.text!
            
            myUtterance = AVSpeechUtterance(string: etInputTeks.text!)
            myUtterance.rate = 0.4
            synth.speak(myUtterance)
            etInputTeks.text = ""
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
