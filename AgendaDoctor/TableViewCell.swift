//
//  TableViewCell.swift
//  AgendaDoctor
//
//  Created by TecNM on 06/03/20.
//  Copyright © 2020 TecNM. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var lbTitulo: UILabel!
    @IBOutlet weak var lblSubtitulo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
