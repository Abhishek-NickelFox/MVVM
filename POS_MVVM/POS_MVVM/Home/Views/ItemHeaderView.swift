//
//  ItemHeaderView.swift
//  POS_MVVM
//
//  Created by Abhishek on 22/04/18.
//  Copyright © 2018 Marvel. All rights reserved.
//

import UIKit

protocol ItemHeaderViewDelegate: class {
    func increaseQuantity(headerView: ItemHeaderView)
    func decreaseQuantity(headerView: ItemHeaderView)
    func didTap(headerView: ItemHeaderView)
}

class ItemHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var netPriceLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    weak var delegate: ItemHeaderViewDelegate?
    
    var item: ItemHeaderModel? {
        didSet {
            self.configure(item)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(handleTapGesture(_:)))
        self.bgView.addGestureRecognizer(gesture)
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
