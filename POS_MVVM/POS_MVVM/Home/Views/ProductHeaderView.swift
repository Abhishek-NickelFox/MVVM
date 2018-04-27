//
//  ProductHeaderView.swift
//  POS_MVVM
//
//  Created by Abhishek on 22/04/18.
//  Copyright © 2018 Marvel. All rights reserved.
//

import UIKit

protocol ProductHeaderViewDelegate: class {
    func increaseQuantity(headerView: ProductHeaderView)
    func decreaseQuantity(headerView: ProductHeaderView)
    func didTap(headerView: ProductHeaderView)
}

class ProductHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var netPriceLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    weak var delegate: ProductHeaderViewDelegate?
    
    var item: ProductHeaderModel? {
        didSet {
            self.configure(item: item)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(handleTapGesture(_:)))
        self.bgView.addGestureRecognizer(gesture)
    }
    
    private func configure(item: ProductHeaderModel?) {
        if let headerModel = item {
            self.titleLabel.text = headerModel.product.title
            self.quantityLabel.text = String(headerModel.product.quantity)
            self.netPriceLabel.text = String(headerModel.product.netPrice)
            self.taxLabel.text = String(headerModel.product.tax)
            self.totalLabel.text = String(headerModel.product.grossPrice)
        }
    }
    
    @objc func handleTapGesture(_ gesture: UITapGestureRecognizer) {
       self.delegate?.didTap(headerView: self)
    }
    
    @IBAction func increaseQuantity(_ sender: UIButton) {
        self.delegate?.increaseQuantity(headerView: self)
    }
    
    @IBAction func decreaseQuantity(_ sender: UIButton) {
        self.delegate?.decreaseQuantity(headerView: self)
    }
}
