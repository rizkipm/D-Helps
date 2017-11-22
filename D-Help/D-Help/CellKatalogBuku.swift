//
//  CellKatalogBuku.swift
//  D-Help
//
//  Created by Rizki Syaputra on 11/22/17.
//  Copyright © 2017 Rizki Syaputra. All rights reserved.
//

import UIKit

class CellKatalogBuku: UITableViewCell {
    @IBOutlet weak var imgKatalogBuku: UIImageView!
    
    @IBOutlet weak var labelTglTerbit: UILabel!
    @IBOutlet weak var labelPenulis: UILabel!
    @IBOutlet weak var labelKategori: UILabel!
    @IBOutlet weak var labelJudulBuku: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
