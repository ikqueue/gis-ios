//
//  DownloadCell.swift
//  gis-ios
//
//  Created by Riseplus on 1/16/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit

class DownloadCell: UITableViewCell {

    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var sizeFile: UILabel!
    @IBOutlet weak var download: UIButton!
    @IBOutlet weak var progress: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureView() -> Void {
        header.text = "ต้นทุนการผลิตอ้อย.pdf"
        header.textColor = UIColor.normalText()
        header.font = UIFont.setFont(font: "ThaiSansNeue-Regular", size: 25.0)
        
        sizeFile.text = "10.2 MB"
        sizeFile.textColor = UIColor.subtitle()
        sizeFile.font = UIFont.setFont(font: "ThaiSansNeue-Regular", size: 20.0)
    }
    
}
