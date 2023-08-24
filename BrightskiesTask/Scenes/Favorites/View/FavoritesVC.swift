//
//  FavoritesVC.swift
//  BrightskiesTask
//
//  Created by Ahmed Abo Elsood on 24/08/2023.
//

import UIKit
import Kingfisher

class FavoritesVC: UIViewController {
//MARK: - IBOutlets
    @IBOutlet weak var emptyFavLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    //MARK: - Variables
    var viewModel = FavoraitsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchData()
        checkEmptyList()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        viewModel.removeDuplication()
    }
    
    
    //MARK: - Functions
    func setupUI(){
        setupTableView()
    }
    
    func regesterCell(){
        tableView.register(UINib(nibName: HomeTableViewCell.ID, bundle: nil), forCellReuseIdentifier: HomeTableViewCell.ID)
    }
    
    func setupTableView(){
        regesterCell()
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.delegate = self
    }
    
    func checkEmptyList(){
        if viewModel.recipesArray.isEmpty{
            emptyFavLbl.isHidden = false
        }else{
            emptyFavLbl.isHidden = true
        }
    }
}

extension FavoritesVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.ID) as! HomeTableViewCell
        let recipe = viewModel.recipesArray[indexPath.row]
        cell.recipeImage.kf.setImage(with: URL(string: recipe.image))
        cell.recipeRate.text = recipe.rating == 0 ? "n/a" : "\(recipe.rating)"
        cell.recipeTitle.text = recipe.name
        cell.recipeTime.text = "\(extractNumbersManuallyFromString(recipe.time).first ?? 0) Min"
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") { action, view, completionHandler in
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.viewModel.deleteFromCoreData(indexPath: indexPath)
            tableView.endUpdates()
            self.checkEmptyList()
            completionHandler(true)
        }
        deleteAction.title = "Delete"
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension FavoritesVC : FavoraitsViewModelDelegate{
    func deletionDone(message: String) {
        showALert(message: message)
    }
    
    func deletionFail(message: String) {
        showALert(message: message)
    }
}
