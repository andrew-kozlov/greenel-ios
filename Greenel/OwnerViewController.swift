//
//  OwnerViewController.swift
//  Greenel
//
//  Created by Andrew Kozlov on 10/11/2018.
//  Copyright © 2018 Andrew Kozlov. All rights reserved.
//

import UIKit

class OwnerViewController: UITableViewController {
    
    var owner: String = ""
    var records: [Record] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name: Service.recordsUpdated, object: nil)
        UserDefaults.standard.addObserver(self, forKeyPath: "Owner", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        updateData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
        UserDefaults.standard.removeObserver(self, forKeyPath: "Owner")
    }
    
    @objc private func updateData() {
        owner = UserDefaults.standard.string(forKey: "Owner") ?? ""
        
        let match = owner
        
        records = Service.shared.records.filter {
            $0.ownerName.contains(match)
                || $0.ownerAddress.contains(match)
                || $0.ownerOGRN.contains(match)
        }
        
        updateView()
    }
    
    private func updateView() {
        navigationItem.title = owner
        
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
    
}
