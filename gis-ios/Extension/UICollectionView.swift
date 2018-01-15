//
//  UICollectionView.swift
//  gis-ios
//
//  Created by Riseplus on 1/15/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    // MARK: - register Cell
    func registerCollectionViewCell(nibName: String!, identifier: String!) -> Void {
        let cell = UINib(nibName: nibName, bundle:nil)
        self.register(cell, forCellWithReuseIdentifier: identifier)
    }
    
    // MARK: - UIEdgeInsetsMake
    func UIEdgeInsetsZero() -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func UIEdgeInsetsCell() -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
    func ImageUIEdgeInsetsCell() -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
    // MARK: - size
    func sizeCell() -> CGSize {
        return CGSize(width: self.frame.size.width/2-15, height: 300)
    }
    func sizeImageCell() -> CGSize {
        return CGSize(width: self.frame.size.width/3-10, height: 70)
    }
    
}
