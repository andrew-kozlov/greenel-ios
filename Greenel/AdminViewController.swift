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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateRecords()
    }
    
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
        cell.textLabel?.text = record.certificateNumber
        cell.detailTextLabel?.text = record.ownerName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowRecord", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow, let recordViewController = segue.destination as? RecordViewController {
            recordViewController.record = records[indexPath.row]
        }
    }
    
    @IBAction private func emit() {
        Service.shared.emit()
    }
    
    @IBAction private func revoke() {
        Service.shared.revoke()
    }
    
}
