//
//  FilterItemCell.swift
//  gis-ios
//
//  Created by Riseplus on 1/30/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit
import BEMCheckBox

protocol DetailViewDelegate: class {
    func toggleSection(header: FilterItemCell, section: Int)
}

class FilterItemCell: UITableViewCell {

    @IBOutlet weak var checkBox: BEMCheckBox!
    @IBOutlet weak var message: UILabel!
    
    var delegate: DetailViewDelegate?
    var section: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCheckBox()
        message.font = UIFont.setFont(font: "ThaiSansNeue-Regular", size: 25.0)
    }
    
    func configureCheckBox() -> Void {
        
        checkBox.delegate = self
        checkBox.boxType = .square
        checkBox.onAnimationType = .bounce
        checkBox.offAnimationType = .bounce
        
        checkBox.tintColor = UIColor.black
        checkBox.offFillColor = UIColor.white
        
        checkBox.onTintColor = UIColor.success()
        checkBox.onFillColor = UIColor.success()
        checkBox.onCheckColor = UIColor.white
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension FilterItemCell: BEMCheckBoxDelegate {
    
    
    
}
