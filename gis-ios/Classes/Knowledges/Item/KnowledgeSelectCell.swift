//
//  KnowledgeSelectCell.swift
//  gis-ios
//
//  Created by Riseplus on 1/24/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit

class KnowledgeSelectCell: UITableViewCell {

    @IBOutlet weak var message: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        message.font = UIFont.setFont(font: "ThaiSansNeue-Regular", size: 20.0)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
