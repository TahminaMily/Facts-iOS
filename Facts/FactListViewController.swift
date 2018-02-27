//
//  FactListViewController.swift
//  Facts
//
//  Created by Tahmina Khanam on 22/2/18.
//  Copyright © 2018 Cognizant. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class FactListViewController: UITableViewController {
    let datasource = FactsDataSource()
    var factum: Factum? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FactTableViewCell.self, forCellReuseIdentifier: FactTableViewCell.reuseIdentifier)
        tableView.estimatedRowHeight = 999
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
        loadData()
    }
    
    @objc func loadData() {
        self.refreshControl?.beginRefreshing()
        datasource.fetch { [weak self] result in
            DispatchQueue.main.async {
                self?.refreshControl?.endRefreshing()
            }
            switch result {
            case .success(var factum):
                factum.facts = factum.facts.filter() {
                    return $0.title != nil
                }
                self?.factum = factum
                DispatchQueue.main.async {
                    self?.title = factum.title
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
                //TODO: show an alert here
            }
        }
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return factum?.facts.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: FactTableViewCell.reuseIdentifier, for: indexPath)
        guard
            let cell = tableViewCell as? FactTableViewCell,
            let fact = factum?.facts[indexPath.row]
        else { return tableViewCell }
        
        cell.configure(fact)
        return cell
    }
}
