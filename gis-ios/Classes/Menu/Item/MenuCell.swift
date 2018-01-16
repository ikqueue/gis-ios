//
//  MenuCell.swift
//  gis-ios
//
//  Created by Riseplus on 1/15/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var textTItle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    func configureView() -> Void {
        layer.cornerRadius = 5.0
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        
        logo.contentMode = .center
        
        textTItle.textColor = UIColor.normalText()
        textTItle.font = UIFont.setFont(font: "ThaiSansNeue-Regular", size: 20.0)
    }

}
