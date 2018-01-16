//
//  KnowledgeCell.swift
//  gis-ios
//
//  Created by Riseplus on 1/15/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit

class KnowledgeCell: UITableViewCell {

    @IBOutlet weak var scaleView: UIView!
    @IBOutlet weak var scaleText: UILabel!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var detail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureView() -> Void {
        
        backgroundColor = UIColor.clear
        scaleView.layer.cornerRadius = 8.0
        scaleView.backgroundColor = UIColor.success()
        
        scaleText.text = "S1"
        scaleText.font = UIFont.setFont(font: "ThaiSansNeue-Regular", size: 100.0)
        scaleText.textColor = UIColor.white
        
        header.text = "เหมาะสมมากที่สุด"
        header.font = UIFont.setFont(font: "ThaiSansNeue-Regular", size: 30.0)
        header.textColor = UIColor.normalText()
        
        detail.text = "ระดับที่แนะนำให้ปลูกมากที่สุด"
        detail.font = UIFont.setFont(font: "ThaiSansNeue-Regular", size: 20.0)
        detail.textColor = UIColor.subtitle()
    }
    
}
