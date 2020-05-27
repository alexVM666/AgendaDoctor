//
//  TableViewCellPac.swift
//  AgendaDoctor
//
//  Created by alex on 22/05/20.
//  Copyright © 2020 TecNM. All rights reserved.
//

import UIKit

class TableViewCellPac: UITableViewCell {

    @IBOutlet weak var lblTitulo: UILabel!
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
