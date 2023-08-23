//
//  HomeVC.swift
//  BrightskiesTask
//
//  Created by Ahmed Abo Elsood on 21/08/2023.
//

import UIKit

class HomeVC: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    //MARK: - Variables
    let viewModel = HomeViewModel()
    var cellDataSource : [HomeCellViewModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindLoadingIndicator()
        bindRemoteData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = AppColors.green.color
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    //MARK: - Functions
    func setupUI(){
        title = "Recipes"
        tableView.register(UINib(nibName: HomeTableViewCell.ID, bundle: nil), forCellReuseIdentifier: HomeTableViewCell.ID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
        viewModel.delegate = self
    }
    
    func bindLoadingIndicator(){
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self else{return}
            guard let isLoading = isLoading else {return}
            if isLoading {
                self.activityIndicator.startAnimating()
            }else{
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func bindRemoteData(){
        viewModel.cellDataSourse.bind { [weak self] recipe in
            guard let self = self else{return}
            guard let recipes = recipe else {return}
            print(recipes,"on sucsess")
            self.cellDataSource = recipes
            self.tableView.reloadData()
        }
    }
    
    func openRecipeDetails(recipeID : String){
        guard let recipe = viewModel.retrieRecipe(recipeID: recipeID) else {return}
        let detailsViewModel = DetailsViewModel(recipe: recipe)
        let detailsVC = DetailsVC(viewModel: detailsViewModel)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}


extension HomeVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.ID) as! HomeTableViewCell
        cell.setupCellData(viewModel: cellDataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.openRecipeDetails(recipeID: cellDataSource[indexPath.row].id)  
    }

}

extension HomeVC : HomeViewModelDelegate{
    func requestFail(error: NetworkError) {
        switch error{
        case .urlError , .cantParseData , .not200:
            showALert(message: "Something went wrong")
        case .internetConnection:
            showALert(message: "Check your internet connection")
        }
    }
}
