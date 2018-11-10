//
//  RecordViewController.swift
//  Greenel
//
//  Created by Andrew Kozlov on 10/11/2018.
//  Copyright © 2018 Andrew Kozlov. All rights reserved.
//

import UIKit

class RecordViewController: UITableViewController {
    
    struct Row {
        let title: String
        let details: String
    }
    
    var record: Record? {
        didSet {
            updateData()
        }
    }
    
    private var rows: [Row] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateData()
    }
    
    private func updateData() {
        var rows: [Row] = []
        
        if let record = record {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            
            
            rows.append(Row(
                title: "Certificate number",
                details: record.certificateNumber
            ))
            
            rows.append(Row(
                title: "Type",
                details: record.type
            ))
            
            rows.append(Row(
                title: "Creation date",
                details: dateFormatter.string(from: record.creationDate)
            ))
            
            rows.append(Row(
                title: "Lifetime",
                details: String(describing: record.lifeTime)
            ))
            
            
            
            rows.append(Row(
                title: "Owner",
                details: record.ownerName
            ))
            
            rows.append(Row(
                title: "OGRN",
                details: record.ownerOGRN
            ))
            
            rows.append(Row(
                title: "Address",
                details: record.ownerAddress
            ))
            
            rows.append(Row(
                title: "Wallet address",
                details: record.wallet
            ))
            
            
            
            rows.append(Row(
                title: "Volume",
                details: String(describing: record.volume)
            ))
            
            rows.append(Row(
                title: "Period",
                details: record.period
            ))
            
            rows.append(Row(
                title: "CO2",
                details: String(describing: record.emissionVolume)
            ))
        }
        
        self.rows = rows
        
        updateView()
    }
    
    private func updateView() {
        guard isViewLoaded else { return }
        
        title = record?.certificateNumber
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = rows[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath)
        cell.textLabel?.text = row.title
        cell.detailTextLabel?.text = row.details
        
        return cell
    }
    
}
