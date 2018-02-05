//
//  FilterSectionCell.swift
//  gis-ios
//
//  Created by Riseplus on 1/30/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit
import BEMCheckBox

protocol HeaderViewDelegate: class {
    func toggleSection(header: FilterSectionCell, section: Int)
}

protocol CheckBoxDelegate {
    func didTabCheckBox(checkbox: BEMCheckBox)
}

class FilterSectionCell: UITableViewCell {

    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var checkBox: BEMCheckBox!
    
    var delegate: HeaderViewDelegate?
    var delegateCheckBox: CheckBoxDelegate?
    
    var section: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCheckBox()

        backgroundColor = UIColor.white
        header.font = UIFont.setFont(font: "ThaiSansNeue-Regular", size: 22.0)
        header.textColor = UIColor.normalText()
        button.addTarget(self, action: #selector(FilterSectionCell.touchSection), for: UIControlEvents.touchUpInside)
        
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
    
    @objc func touchSection() -> Void {
        delegate?.toggleSection(header: self, section: section)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension FilterSectionCell: BEMCheckBoxDelegate {
    
    func animationDidStop(for checkBox: BEMCheckBox) {
        delegateCheckBox?.didTabCheckBox(checkbox: checkBox)
    }
}
