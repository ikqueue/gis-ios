//
//  UITableView.swift
//  gis-ios
//
//  Created by Riseplus on 1/15/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit

extension UITableView {
    
    // MARK: - Register Cell
    func registerTableViewCell(nib: String!, identifier: String!) -> Void {
        let cell = UINib(nibName: nib, bundle:nil)
        self.register(cell, forCellReuseIdentifier: identifier)
    }
    
    // MARK: - Auto Hegiht Cell
    func setHeightCellAutomatic(estimatedRowHeight:CGFloat?) {
        if let temp = estimatedRowHeight {
            self.estimatedRowHeight = temp
        } else {
            self.estimatedRowHeight = 44
        }
        self.rowHeight = UITableViewAutomaticDimension
    }
    
    
}
