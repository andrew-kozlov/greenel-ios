//
//  WalletsViewController.swift
//  Greenel
//
//  Created by Andrew Kozlov on 10/11/2018.
//  Copyright © 2018 Andrew Kozlov. All rights reserved.
//

import UIKit

protocol WalletsViewControllerDelegate: class {
    
    func walletsViewController(_: WalletsViewController, didSelectWallet: String?)
    
}


class WalletsViewController: UITableViewController {
    
    weak var delegate: WalletsViewControllerDelegate?
    
    var wallets: [String] = []
    var selected: String?
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wallets.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WalletCell", for: indexPath)
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "All"
            cell.accessoryType = selected == nil ? .checkmark : .none
            
        } else {
            let wallet = wallets[indexPath.row - 1]
            
            cell.textLabel?.text = wallet
            cell.accessoryType = selected == wallet ? .checkmark : .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            selected = nil
        } else {
            selected = wallets[indexPath.row - 1]
        }
        
        delegate?.walletsViewController(self, didSelectWallet: selected)
        
        tableView.reloadData()
    }
    
}
