//
//  CellMemberKonsultan.swift
//  D-Help
//
//  Created by Rizki Syaputra on 11/22/17.
//  Copyright © 2017 Rizki Syaputra. All rights reserved.
//

import UIKit

class CellMemberKonsultan: UITableViewCell {
    
    @IBOutlet weak var labelAsal: UILabel!
    @IBOutlet weak var labelPoint: UILabel!
    @IBOutlet weak var labelNama: UILabel!
    @IBOutlet weak var nAvatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
