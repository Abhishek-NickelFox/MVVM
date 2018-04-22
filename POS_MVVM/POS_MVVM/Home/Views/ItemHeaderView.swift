//
//  ItemHeaderView.swift
//  POS_MVVM
//
//  Created by Abhishek on 22/04/18.
//  Copyright © 2018 Marvel. All rights reserved.
//

import UIKit

class ItemHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var netPriceLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    var item: ItemHeaderModel? {
        didSet {
            self.configure(item)
        }
    }
    
    private func configure(_ item: ItemHeaderModel?) {
        if let model = item {
            self.titleLabel.text = model.title
            self.quantityLabel.text = String(model.quantity)
            self.netPriceLabel.text = String(model.netPrice)
            self.taxLabel.text = String(model.tax)
            self.totalLabel.text = String(model.grossPrice)
        }
    }
    
    @IBAction func increaseQuantity(_ sender: UIButton) {
        
    }
    
    @IBAction func decreaseQuantity(_ sender: UIButton) {
        
    }
}
