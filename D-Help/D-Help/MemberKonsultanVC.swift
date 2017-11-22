//
//  MemberKonsultanVC.swift
//  D-Help
//
//  Created by Rizki Syaputra on 11/22/17.
//  Copyright © 2017 Rizki Syaputra. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON
import MessageUI
import AlamofireImage

class MemberKonsultanVC: UIViewController, UITableViewDelegate, UITableViewDataSource , MFMessageComposeViewControllerDelegate{
     var arrayMember = [[String:String]]()
    
    @IBOutlet weak var tableMember: UITableView!
    
    var nNoHp:String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableMember.delegate = self
        tableMember.dataSource = self
        
        loadData()

        // Do any additional setup after loading the view.
    }
    
    func loadData() {
        Alamofire.request("http://localhost/DehelpServer/index.php/api/getAllKonsultan").responseJSON { (response) in
            
            //check response
            if response.result.isSuccess {
                //kalau response success kita ambil json
                let json = JSON(response.result.value as Any)
                //get jsonarray dari json diatas
                self.arrayMember = json["data"].arrayObject as! [[String : String]]
                //check di log
                // print(self.arrayberita)
                
                //check jumlah array
                if(self.arrayMember.count > 0){
                    
                    //refresh tableview
                    self.tableMember.reloadData()
                }
            }
            else{
                
                print("error server")
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMember.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMember", for: indexPath) as! CellMemberKonsultan
        
        // Configure the cell...
        
        var idServerBuku = arrayMember[indexPath.row]
        
        
        let nama_user =  idServerBuku["nama_user"]
        let lokasi = idServerBuku["lokasi"]
       
        let point = idServerBuku["point"]
        
        cell.labelNama.text = nama_user
        cell.labelAsal.text = lokasi
        cell.labelPoint.text = "Point : " + point!
        
        // print(judul)
        let foto_user = idServerBuku["foto_user"]
        
        
        
        
        //download gambar dari server
        
        //download gambar dari server
        Alamofire.request("http://localhost/DehelpServer/foto/"+foto_user!).responseImage { (datagambar) in
            
            //check response
            if datagambar.result.isSuccess {
                
                //ambil gambar yang udah dikirim server
                let gambarserver = datagambar.result.value
                
                //tempelin ke image di cell tableview
                cell.nAvatar.image = gambarserver
                
            }
                //if error
            else{
                
            }
        }
        
      
       
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let task = arrayMember[indexPath.row]
        //memasukan data ke variable namaSelected dan image selected ke masing masing variable nya
        nNoHp = task["no_hp"] as? String
        //  gambarSelcetd = task["gambar"] as! String
        let noHpM : Int? = Int(nNoHp!)
       
        
        
        let more = UITableViewRowAction(style: .normal, title: "SMS") { action, index in
            //self.isEditing = false
           
            // Check if the device is capable of sending text message
            guard MFMessageComposeViewController.canSendText() else {
                let alertMessage = UIAlertController(title: "SMS Unavailable", message: "Your device is not capable of sending SMS.", preferredStyle: .alert)
                alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertMessage, animated: true, completion: nil)
                return
            }
            
            // Prefill the SMS
            let messageController = MFMessageComposeViewController()
            messageController.messageComposeDelegate = self
            messageController.recipients = [self.nNoHp!]
            messageController.body = "Hello,I need your hel"
            
            // Adding file attachment
//            let fileparts = attachment.components(separatedBy: ".")
//            let filename = fileparts[0]
//            let fileExtension = fileparts[1]
//            let filePath = Bundle.main.path(forResource: filename, ofType: fileExtension)
//            let fileUrl = NSURL.fileURL(withPath: filePath!)
//            messageController.addAttachmentURL(fileUrl, withAlternateFilename: nil)
            
            // Present message view controller on screen
//            self.present(messageController, animated: true, completion: nil)
        }
        more.backgroundColor = UIColor.orange
        
        let favorite = UITableViewRowAction(style: .normal, title: "Telp") { action, index in
            //self.isEditing = false
            print("favorite button tapped")
            
            if let url = URL(string: "tel://\(noHpM)"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
            else {
                print("Your device doesn't support this feature.")
            }
        }
        favorite.backgroundColor = UIColor.green
        
        let share = UITableViewRowAction(style: .normal, title: "Chat") { action, index in
            //self.isEditing = false
            print("share button tapped")
        }
        share.backgroundColor = UIColor.blue
        
        return [share, favorite, more]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedFile = arrayMember[indexPath.row]
//        sendSMS(attachment: selectedFile)
    }
    
    // MARK: - MFMessageComposeViewControllerDelegate Methods
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        switch(result) {
        case MessageComposeResult.cancelled:
            print("SMS cancelled")
            
        case MessageComposeResult.failed:
            let alertMessage = UIAlertController(title: "Failure", message: "Failed to send the message.", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertMessage, animated: true, completion: nil)
            
        case MessageComposeResult.sent:
            print("SMS sent")
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Help Methods
    
    

    

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
