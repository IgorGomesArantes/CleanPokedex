//
//  HomeViewController.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 03/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: class {
    func displayFetchedPokemons(_ viewModel: Home.FetchPokemons.ViewModel)
    func displayFetchPokemonsError(_ error: Home.FetchPokemons.Error)
}

final class HomeViewController: UIViewController {
    // MARK: Properties
    private var interactor: HomeBusinessLogic?
    private var router: (HomeRoutingLogic & HomeDataPassing)?
    private var displayedPokemons: [Home.FetchPokemons.ViewModel.DisplayedPokemon] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.homeView.pokemonsTableView.reloadData()
            }
        }
    }
    
    // MARK: View properties
    var homeView: HomeView {
        return view as! HomeView
    }
}

// MARK: Initialization methods
extension HomeViewController {
    convenience init() {
        self.init(nibName:nil, bundle:nil)
        initialConfiguration()
    }
}

// MARK: View lifecycle methods
extension HomeViewController {
    override func loadView() {
        view = HomeView(frame: .zero)
        tableViewConfiguration()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationControllerConfiguration()
        interactor?.fetchPokemons()
    }
}

// MARK: Configuration methods
private extension HomeViewController {
    func initialConfiguration() {
        let viewController = self
        let router = HomeRouter()
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        
        router.dataStore = interactor
        viewController.router = router
        interactor.presenter = presenter
        viewController.interactor = interactor
        router.viewController = viewController
        presenter.viewController = viewController
    }
    
    func navigationControllerConfiguration() {
        title = "Clean Pokédex"
    }
    
    func tableViewConfiguration() {
        homeView.pokemonsTableView.delegate = self
        homeView.pokemonsTableView.dataSource = self
        
        homeView.pokemonsTableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: String(describing: PokemonTableViewCell.self))
    }
}

// MARK: Private methods
private extension HomeViewController {
    func showFetchPokemonsAlertError(message: String) {
        let alert = UIAlertController(title: "Houve um erro ao buscar os Pokemons.", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tentar novamente", style: .default, handler: { _ in
            self.interactor?.fetchPokemons()
        }))
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
}

// MARK: Display logic methods
extension HomeViewController: HomeDisplayLogic {
    func displayFetchedPokemons(_ viewModel: Home.FetchPokemons.ViewModel) {
        self.displayedPokemons = viewModel.displayedPokemons
    }
    
    func displayFetchPokemonsError(_ error: Home.FetchPokemons.Error) {
        showFetchPokemonsAlertError(message: error.message)
    }
}

// MARK: Table view data source methods
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedPokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PokemonTableViewCell.self), for: indexPath) as! PokemonTableViewCell
        cell.setup(pokemon: displayedPokemons[indexPath.row])
        return cell
    }
}

// MARK: Table view delegate methods
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToDetails(withIndex: indexPath.row)
    }
}
