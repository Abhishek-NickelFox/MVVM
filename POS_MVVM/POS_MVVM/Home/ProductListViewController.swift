//
//  ProductListViewController.swift
//  POS_MVVM
//
//  Created by Abhishek on 22/04/18.
//  Copyright © 2018 Marvel. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    var viewModel = ProductListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func addWine(_ sender: UIButton) {
        self.addModel(title: "Wine")
    }
    
    @IBAction func addBeer(_ sender: UIButton) {
        self.addModel(title: "Beer")
    }
    
    @IBAction func addScotch(_ sender: UIButton) {
        self.addModel(title: "Scotch")
    }
    
    private func addModel(title: String) {
        let product = Product(title: title,
                              quantity: 1,
                              tax: 2.5,
                              basePrice: 100.0)
        let headerModel = ProductHeaderModel(product: product, handler: nil)
        self.viewModel.add(headerModel: headerModel)
    }
    
    private func updateBill() {
        self.taxLabel.text = "$ \(self.viewModel.totalTax)"
        self.totalLabel.text = "$ \(self.viewModel.grandTotal)"
    }
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
 
    func setup() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.viewModel.delegate = self
        self.tableView.register(UINib(nibName: "BartenderTableViewCell",
                                      bundle: nil),
                                forCellReuseIdentifier: "BartenderTableViewCell")
        self.tableView.register(UINib(nibName: "ProductHeaderView",
                                      bundle: nil),
                                forHeaderFooterViewReuseIdentifier: "ProductHeaderView")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModel = self.viewModel.sections[section]
        return sectionModel.headerModel.isSelected ? sectionModel.cellModels.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "BartenderTableViewCell"
        ) as! BartenderTableViewCell
        cell.item = self.viewModel.sections[indexPath.section].cellModels[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: "ProductHeaderView"
        ) as! ProductHeaderView
        headerView.item = self.viewModel.sections[section].headerModel
        headerView.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
}

extension ProductListViewController: ProductListViewModelDelegate {
    
    func reloadData() {
        self.updateBill()
        self.tableView.reloadData()
    }
}

extension ProductListViewController: ProductHeaderViewDelegate {
    
    func increaseQuantity(headerView: ProductHeaderView) {
        guard let headerModel = headerView.item else { return }
        self.viewModel.add(headerModel: headerModel)
    }
    
    func decreaseQuantity(headerView: ProductHeaderView) {
        guard let product = headerView.item else { return }
        self.viewModel.remove(headerModel: product)
    }
    
    func didTap(headerView: ProductHeaderView) {
        guard let headerModel = headerView.item else { return }
        headerModel.isSelected = !headerModel.isSelected
        self.tableView.reloadData()
    }
}
