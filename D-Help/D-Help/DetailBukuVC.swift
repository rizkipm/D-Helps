//
//  DetailBukuVC.swift
//  D-Help
//
//  Created by Rizki Syaputra on 11/22/17.
//  Copyright © 2017 Rizki Syaputra. All rights reserved.
//

import UIKit

class DetailBukuVC: UIViewController {

    @IBOutlet weak var dtlSynopsis: UITextView!
    @IBOutlet weak var dtlTglTerbit: UILabel!
    @IBOutlet weak var dtlPenulis: UILabel!
    @IBOutlet weak var dtlKategori: UILabel!
    @IBOutlet weak var dtlImageBuku: UIImageView!
    @IBOutlet weak var dtlJudulBuku: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
