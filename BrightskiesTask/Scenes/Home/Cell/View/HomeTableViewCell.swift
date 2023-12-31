//
//  HomeTableViewCell.swift
//  BrightskiesTask
//
//  Created by Ahmed Abo Elsood on 21/08/2023.
//

import UIKit
import Kingfisher

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
        recipeImage.layer.cornerRadius = recipeImage.bounds.height / 2
        self.selectionStyle = .none
    }
    
    func setupCellData(viewModel: HomeCellViewModel){
        recipeImage.kf.indicatorType = .activity
        recipeImage.kf.setImage(with: URL(string:viewModel.image))
        if let rate = viewModel.rating {
            recipeRate.text = "\(rate)"
        }else{
            recipeRate.text = "n/a"
        }
        recipeTitle.text = viewModel.name
        let time = extractNumbersManuallyFromString(viewModel.time).first
        recipeTime.text = "\(time ?? 0) Min"
    }
}
