//
//  HomeTableViewCell.swift
//  BrightskiesTask
//
//  Created by Ahmed Abo Elsood on 21/08/2023.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var cellContainerView: UIView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var recipeRate: UILabel!
    //MARK: - Variables
    static let ID = String(describing: HomeTableViewCell.self)
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupUI(){
        cellContainerView.layer.cornerRadius = 20
        cellContainerView.layer.borderColor = AppColors.green.color.cgColor
        cellContainerView.layer.borderWidth = 1
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        self.selectedBackgroundView = backgroundView
    }
}
