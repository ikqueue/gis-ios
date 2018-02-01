//
//  FilterSectionCell.swift
//  gis-ios
//
//  Created by Riseplus on 1/30/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate: class {
    func toggleSection(header: FilterSectionCell, section: Int)
}

class FilterSectionCell: UITableViewCell {

    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var button: UIButton!
    
    weak var delegate: HeaderViewDelegate?
    var section: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()

        header.font = UIFont.setFont(font: "ThaiSansNeue_Regular", size: 20.0)
        button.addTarget(self, action: #selector(FilterSectionCell.touchSection), for: UIControlEvents.touchUpInside)
    }
    
    @objc func touchSection() -> Void {
        delegate?.toggleSection(header: self, section: section)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}
