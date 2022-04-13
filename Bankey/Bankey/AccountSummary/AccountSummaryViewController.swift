//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by PandaH on 4/13/22.
//

import Foundation
import UIKit

class AccountSummaryViewController: UIViewController {
    
    //data represented as an array of account summary cells of type view model
    var accounts: [AccountSummaryCell.ViewModel] = []
    
    
    //instantiate table view as a control
    var tableView = UITableView()
    
    //standard setup and layout
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension AccountSummaryViewController {
    private func setup() {
        setupTableView()
        setupTableHeaderView()
        fetchData()
    }
    
    
    private func setupTableView() {
        //set self as protocol delegate for supplied data
        tableView.delegate = self
        //set self as protocol data source if cell selected for callback action
        tableView.dataSource = self
        
        
        //register tableView cell, takes cell we created and passes the reuseID that we defined in our cell
        //registers this cell with this reuseID in our table
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        //specify row height
        tableView.rowHeight = AccountSummaryCell.rowHeight
        //set a blank view on table foot view
        tableView.tableFooterView = UIView()
        
        //set tableView background color to app Color
        tableView.backgroundColor = appColor
        
        //turn off constraints mask
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //add table view to view subview
        view.addSubview(tableView)
        
        //set tableview constraints
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableHeaderView() {
        //instantiate and set to frame of zer
        let header = AccountSummaryHeaderView(frame: .zero)
        
        //header lays itself in the smallest form as possible
        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        //set width, which changes depending on phone screen
        size.width = UIScreen.main.bounds.width
        //set header size to the size it lay out
        header.frame.size = size
        
        //set header as tableView's header
        tableView.tableHeaderView = header
    }
}

//Data source
extension AccountSummaryViewController: UITableViewDataSource {
    //** cells are reusable
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //if we dont have any data return empty UITableViewCell
        guard !accounts.isEmpty else{return UITableViewCell()}
        
        //Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table.
        //downcasts to Account Summary cell
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
        
        //instantiate and assign account with current account at corresponding indexPath row
        let account = accounts[indexPath.row]
        
        //pass in each account as view model into our cell, cell is downcasted to AccountSummaryCell, so can make call to
        //configure function under AccountSummaryCell
        cell.configure(with: account)
        
        //instantiate table view cell
        //let cell = UITableViewCell()
        //for the particular indexpath.row, access the game name at that index in the games array and set to cell text
        //cell.textLabel?.text = games[indexPath.row]
        //return the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return the number of rows in the section (number of items in the array)
        return accounts.count
    }
}

extension AccountSummaryViewController: UITableViewDelegate {
    //delegate that gets called everytime we select a cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension AccountSummaryViewController{
    //create function to simulate JSON data call from web
    private func fetchData(){
        let savings = AccountSummaryCell.ViewModel(accountType: .Banking, accountName: "Basic Savings", balance: 929466.23)
        let checking = AccountSummaryCell.ViewModel(accountType: .Banking, accountName: "No-Fee All-In Checking", balance: 17562.44)
        let visa = AccountSummaryCell.ViewModel(accountType: .CreditCard, accountName: "Visa Avion Card", balance: 412.83)
        let mastercard = AccountSummaryCell.ViewModel(accountType: .CreditCard, accountName: "Student Mastercard", balance: 50.83)
        let investment1 = AccountSummaryCell.ViewModel(accountType: .Investment, accountName: "Tax-Free Saver", balance: 2000.00)
        let investment2 = AccountSummaryCell.ViewModel(accountType: .Investment, accountName: "Growth Fund", balance: 15000.00)
        
        accounts.append(savings)
        accounts.append(checking)
        accounts.append(visa)
        accounts.append(mastercard)
        accounts.append(investment1)
        accounts.append(investment2)
    }
}
    
   
