//
//  TodoCell.swift
//  FireTodo
//
//  Created by Tarokh on 10/5/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import UIKit
import DLRadioButton

class TodoCell: UITableViewCell {
    
    //MARK: - @IBOutlets
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var checkButton: DLRadioButton!
    @IBOutlet var todoView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
