//
//  ViewController.swift
//  POS_MVVM
//
//  Created by Abhishek on 22/04/18.
//  Copyright © 2018 Marvel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = ItemViewModel()
    
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
        let itemModel = ItemHeaderModel(title: title,
                                        quantity: 1,
                                        tax: 2.5,
                                        basePrice: 100.0)
        self.viewModel.add(item: itemModel)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
 
    func setup() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.viewModel.delegate = self
        self.tableView.register(UINib(nibName: "BartenderTableViewCell",
                                      bundle: nil),
                                forCellReuseIdentifier: "BartenderTableViewCell")
        self.tableView.register(UINib(nibName: "ItemHeaderView",
                                      bundle: nil),
                                forHeaderFooterViewReuseIdentifier: "ItemHeaderView")
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
            withIdentifier: "ItemHeaderView"
        ) as! ItemHeaderView
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

extension ViewController: ItemViewModelDelegate {
    
    func reloadData() {
        self.tableView.reloadData()
    }
}

extension ViewController: ItemHeaderViewDelegate {
    
    func increaseQuantity(headerView: ItemHeaderView) {
        guard let model = headerView.item else { return }
        self.viewModel.add(item: model)
    }
    
    func decreaseQuantity(headerView: ItemHeaderView) {
        guard let model = headerView.item else { return }
        self.viewModel.remove(item: model)
    }
    
    func didTap(headerView: ItemHeaderView) {
        guard let model = headerView.item else { return }
        model.isSelected = !model.isSelected
        self.tableView.reloadData()
    }
}
