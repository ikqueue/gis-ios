//
//  ExtensionMenu.swift
//  gis-ios
//
//  Created by Riseplus on 1/15/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit

extension MenuController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: menuCollection.frame.size.width/3-10, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return collectionView.UIEdgeInsetsCell()
        
    }
}

extension MenuController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let menuCell = menuCollection.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! MenuCell
        menuCell.logo.image = menuIogo[indexPath.row]
        menuCell.textTItle.text = menuTitle[indexPath.row]
        return menuCell
    }
    
        
}
    
extension MenuController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        case 1:
            
            if let vc = UIStoryboard(name: "Knowledge", bundle: nil).instantiateViewController(withIdentifier: "Knowledge") as? UINavigationController {
                present(vc, animated: true, completion: nil)
            }
            
        case 2:
            print(indexPath.row)
        default:
            print(indexPath)
        }
    }
}

