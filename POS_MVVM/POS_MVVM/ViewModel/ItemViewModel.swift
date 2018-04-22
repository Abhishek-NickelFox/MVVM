//
//  ItemViewModel.swift
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

class ItemHeaderModel {
    
    var title: String
    var quantity: Int
    var tax: Double
    var basePrice: Double // without tax
    
    var netPrice: Double {
        return ((1 + self.tax/100) * self.basePrice)
    }
    
    var grossPrice: Double {    // INCLUDING TAX
        return Double(self.quantity) * self.netPrice
    }
    
    init(title: String,
         quantity: Int,
         tax: Double,
         basePrice: Double) {
        self.title = title
        self.quantity = quantity
        self.tax = tax
        self.basePrice = basePrice
    }
}

protocol ItemViewModelDelegate: class {
    func reloadData()
}

class SectionModel {
    
    var headerModel: ItemHeaderModel
    var cellModels: [BartenderCellModel]
    var footerModel: Any?
    
    init(headerModel: ItemHeaderModel,
         cellModels: [BartenderCellModel],
         footerModel: Any? = nil) {
        self.headerModel = headerModel
        self.cellModels = cellModels
        self.footerModel = footerModel
    }
}

class ItemViewModel {
    
    var sections: [SectionModel] = []
    private var grandTotal: Double = 0.0
    private var totalTax: Double = 0.0
    
    weak var delegate: ItemViewModelDelegate?
    
    func reloadData() {
        self.delegate?.reloadData()
    }
    
    func add(item: ItemHeaderModel) {
        if let index = self.sections.index(where: { (model) -> Bool in
            return model.headerModel.title == item.title
        }) {
            let sectionModel = self.sections[index]
            sectionModel.headerModel.quantity += 1
            let bartenderModel = BartenderCellModel(time: "10:38 AM", action: "ADDED")
            sectionModel.cellModels.append(bartenderModel)
        } else {
            let bartenderModel = BartenderCellModel(time: "9:38 AM", action: "ADDED")
            let sectionModel = SectionModel(headerModel: item, cellModels: [bartenderModel])
            self.sections.append(sectionModel)
        }
        self.reloadData()
    }
    
    func remove(item: ItemHeaderModel) {
        if let index = self.sections.index(where: { (model) -> Bool in
            return model.headerModel.title == item.title
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
        
    }
    
}
