//
//  DetailsVC.swift
//  BrightskiesTask
//
//  Created by Ahmed Abo Elsood on 23/08/2023.
//

import UIKit
import Kingfisher
import Cosmos
class DetailsVC: UIViewController {
    //MARK: - IBOutlets 
    @IBOutlet weak var ratingStars: CosmosView!
    @IBOutlet weak var recipeHeadLineLbl: UILabel!
    @IBOutlet weak var ingrediantsTableView: UITableView!
    @IBOutlet weak var descriptionTxtView: UITextView!
    @IBOutlet weak var fatsLbl: UILabel!
    @IBOutlet weak var protineLbl: UILabel!
    @IBOutlet weak var carbLbl: UILabel!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var recipeTimeLbl: UILabel!
    @IBOutlet weak var recipeNameLbl: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    //MARK: - Variables
    var ingrediant : [String]!
    var cellHeight = 20
    var viewModel : DetailsViewModel
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
  
    func setupUI(){
        title = "Details"
        ingrediantsTableView.dataSource = self
        ingrediantsTableView.delegate = self
        ingrediantsTableView.register(UINib(nibName: ingrediantsCell.ID, bundle: nil), forCellReuseIdentifier: ingrediantsCell.ID)
        recipeImage.layer.cornerRadius = recipeImage.bounds.height / 2
        recipeImage.kf.setImage(with: URL(string: viewModel.recipeImage))
        recipeNameLbl.text = viewModel.recipeName
        recipeHeadLineLbl.text = viewModel.recipeHeadline
        if let rate = viewModel.recipeRating {
            ratingStars.isUserInteractionEnabled = false
            ratingStars.rating = rate
            rateView.isHidden = false
        }else{
            rateView.isHidden = true
        }
        if viewModel.recipeCalories == "" {
            caloriesLbl.text = "Calories \n" + "--"
            carbLbl.text = "Carbs \n" + "--"
            fatsLbl.text = "Fats \n" + "--"
            protineLbl.text = "Proteins \n" + "--"
        }else{
            caloriesLbl.text = "Calories \n" + viewModel.recipeCalories
            carbLbl.text = "Carbs \n" + viewModel.recipeCarbs
            fatsLbl.text = "Fats \n" + viewModel.recipeFats
            protineLbl.text = "Proteins \n" + viewModel.recipeProtien
        }
       
        descriptionTxtView.text = viewModel.recipeDescription
        recipeTimeLbl.text = viewModel.recipeTime + " Min"
        ingrediant = viewModel.recipeIngrediants
        tableViewHeight.constant = CGFloat((ingrediant.count * cellHeight)+35)
    }
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "DetailsVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailsVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingrediant.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ingrediantsCell.ID) as! ingrediantsCell
        cell.ingrediant.text = ingrediant[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    } 
}
