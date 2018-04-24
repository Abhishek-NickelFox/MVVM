//
//  ProductListViewModel.swift
//  POS_MVVM
//
//  Created by Abhishek on 22/04/18.
//  Copyright © 2018 Marvel. All rights reserved.
//

import Foundation

class BartenderCellModel {
    
    var name: String
    var time: String
    var action: String
 
    init(name: String = "Abhishek", time: String, action: String) {
        self.name = name
        self.time = time
        self.action = action
    }
}

class Product {
    
    var title: String
    var quantity: Int
    var tax: Double
    var basePrice: Double         // WITHOUT TAX
    var isSelected: Bool
    
    var netPrice: Double {        // INCLUDING TAX
        return ((1 + self.tax/100) * self.basePrice)
    }
    
    var grossPrice: Double {      // INCLUDING QUANTITY
        return Double(self.quantity) * self.netPrice
    }
    
    var taxableAmount: Double {   // TAX AMOUNT
        return (self.tax/100) * self.basePrice
    }
    
    init(title: String,
         quantity: Int,
         tax: Double,
         basePrice: Double,
         isSelected: Bool = false) {
        self.title = title
        self.quantity = quantity
        self.tax = tax
        self.basePrice = basePrice
        self.isSelected = isSelected
    }
}

protocol ProductListViewModelDelegate: class {
    func reloadData()
}

class SectionModel {
    
    var headerModel: Product
    var cellModels: [BartenderCellModel]
    var footerModel: Any?
    
    init(headerModel: Product,
         cellModels: [BartenderCellModel],
         footerModel: Any? = nil) {
        self.headerModel = headerModel
        self.cellModels = cellModels
        self.footerModel = footerModel
    }
}

class ProductListViewModel {
    
    var sections: [SectionModel] = []
    var grandTotal: Double = 0.0
    var totalTax: Double = 0.0
    
    weak var delegate: ProductListViewModelDelegate?
    
    func reloadData() {
        self.calculateBill()
        self.delegate?.reloadData()
    }
    
    func add(product: Product) {
        if let index = self.sections.index(where: { (model) -> Bool in
            return model.headerModel.title == product.title
        }) {
            let sectionModel = self.sections[index]
            sectionModel.headerModel.quantity += 1
            let bartenderModel = BartenderCellModel(time: "10:38 AM", action: "ADDED")
            sectionModel.cellModels.append(bartenderModel)
        } else {
            let bartenderModel = BartenderCellModel(time: "9:38 AM", action: "ADDED")
            let sectionModel = SectionModel(headerModel: product, cellModels: [bartenderModel])
            self.sections.append(sectionModel)
        }
        self.reloadData()
    }
    
    func remove(product: Product) {
        if let index = self.sections.index(where: { (model) -> Bool in
            return model.headerModel.title == product.title
        }) {
            let sectionModel = self.sections[index]
            sectionModel.headerModel.quantity -= 1
            if sectionModel.headerModel.quantity < 1 {
                self.sections.remove(at: index)
            } else {
                let bartenderModel = BartenderCellModel(time: "1:00 PM", action: "REMOVED")
                sectionModel.cellModels.append(bartenderModel)
            }
            self.reloadData()
        }
    }
    
    private func calculateBill() {
        self.totalTax = 0.0
        self.grandTotal = 0.0
        self.sections.forEach {
            self.totalTax += $0.headerModel.taxableAmount
            self.grandTotal += $0.headerModel.grossPrice
        }
    }
    
}
