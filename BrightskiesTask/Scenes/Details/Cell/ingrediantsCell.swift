//
//  ingrediantsCell.swift
//  BrightskiesTask
//
//  Created by Ahmed Abo Elsood on 23/08/2023.
//

import UIKit

class ingrediantsCell: UITableViewCell {

    @IBOutlet weak var ingrediant: UILabel!
    static let ID = String(describing: ingrediantsCell.self)
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated) 
    } 
}
