//
//  TextTableViewCell.swift
//  TODO
//
//  Created by 安子和 on 2020/2/13.
//  Copyright © 2020 安子和. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    @IBOutlet var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
