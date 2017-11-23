//
//  FaceScanVc.swift
//  D-Help
//
//  Created by Rizki Syaputra on 11/23/17.
//  Copyright © 2017 Rizki Syaputra. All rights reserved.
//

import UIKit
import CoreImage
import AVFoundation


class FaceScanVc: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    @IBOutlet weak var labelInfo: UITextView!
    @IBOutlet weak var myImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detect()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnOpenGaleri(_ sender: Any) {
        
        //membuat image picker
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        //display imagePicker
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    // pick up the liblary
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            
            myImageView.image = image
            
        }
        
        detect()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func detect(){
        
        //get image from imageview
        let myImage = CIImage(image: myImageView.image!)!
        
        //set up the detector
        let accuracy = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuracy)
        let faces = faceDetector?.features(in: myImage, options: [CIDetectorSmile:true])
        
        
        if !(faces?.isEmpty)!
        {
            for face in faces as! [CIFaceFeature]
            {
                let mouthShowing = "\nMouth is showing: \(face.hasMouthPosition)"
                let isSmilling = "\nMouth is smilling: \(face.hasSmile)"
                var bothEyesShowing = "\n Both eyes showing: true"
                
                if !face.hasRightEyePosition || !face.hasLeftEyePosition
                {
                    bothEyesShowing = "\n Both eyes showing: false"
                }
                
                //Degree of supnicess
                let array = ["Low", "Medium", "High", "VeryHigh"]
                var supspectDegree = 0
                
                if !face.hasMouthPosition {supspectDegree += 1}
                if !face.hasSmile {supspectDegree += 1}
                if !bothEyesShowing.contains("false") {supspectDegree += 1}
                if face.faceAngle < 10 || face.faceAngle < -10 {supspectDegree += 1}
                
                let suspectText = "\nSuspiciousness: \(array[supspectDegree])"
                
                
                labelInfo.text = "\(suspectText) \n\(mouthShowing) \(isSmilling) \(bothEyesShowing)"
                
                myUtterance = AVSpeechUtterance(string: labelInfo.text!)
                myUtterance.rate = 0.4
                synth.speak(myUtterance)
                
                
            }
        }else
        {
            labelInfo.text = "No faces found"
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
