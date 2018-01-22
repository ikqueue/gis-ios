//
//  DownloadController.swift
//  gis-ios
//
//  Created by Riseplus on 1/16/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit

class DownloadController: UIViewController {

    @IBOutlet weak var tableVIEW: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar(barTint: UIColor.primary3(), tint: UIColor.white, titleTextAt: UIColor.white, showTitle: true, title: "ดาวน์โหลด")
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let window = UIApplication.shared.delegate?.window {
            if var viewController = window?.rootViewController {
                if(viewController is UINavigationController){
                    viewController = (viewController as! UINavigationController).visibleViewController!
                }
                checkView.thirdView = String(describing: viewController)
            }
        }
    }
    
    func setUpTableView() -> Void {
        tableVIEW.registerTableViewCell(nib: "DownloadCell", identifier: "DownloadCell")
        tableVIEW.tableFooterView = UIView(frame: .zero)
        tableVIEW.setHeightCellAutomatic(estimatedRowHeight: 90)
    }
    
}

extension DownloadController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVIEW.dequeueReusableCell(withIdentifier: "DownloadCell", for: indexPath) as! DownloadCell
        
        return cell
    }
    
}

extension DownloadController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detail", sender: nil)
    }
}
