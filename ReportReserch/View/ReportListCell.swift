//
//  reportTableViewCell.swift
//  ReportReserch
//
//  Created by 神野成紀 on 2020/05/25.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit

class ReportListCell: UITableViewCell {

    @IBOutlet weak var reportTitleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
