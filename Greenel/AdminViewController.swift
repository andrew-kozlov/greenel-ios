//
//  AdminViewController.swift
//  Greenel
//
//  Created by Andrew Kozlov on 10/11/2018.
//  Copyright © 2018 Andrew Kozlov. All rights reserved.
//

import UIKit

class AdminViewController: UITableViewController {
    
    var records: [Record] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateRecords), name: Service.recordsUpdated, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func updateRecords() {
        records = Service.shared.records
        
        updateView()
    }
    
    private func updateView() {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let record = records[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath)
        cell.textLabel?.text = "\(record.certificateNumber) (\(record.type))"
        cell.detailTextLabel?.text = record.ownerName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowRecord", sender: nil)
    }
    
    @IBAction private func emit() {
        Service.shared.emit()
    }
    
    @IBAction private func revoke() {
        Service.shared.revoke()
    }
    
}
