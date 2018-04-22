//
//  BartenderTableViewCell.swift
//  POS_MVVM
//
//  Created by Abhishek on 22/04/18.
//  Copyright © 2018 Marvel. All rights reserved.
//

import UIKit

class BartenderTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var actionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var item: BartenderCellModel? {
        didSet {
            self.configure(item)
        }
    }
    
    private func configure(_ item: BartenderCellModel?) {
        if let model = item {
            self.nameLabel.text = model.name
            self.timeLabel.text = model.time
            self.actionLabel.text = model.action
        }
    }
    
}
