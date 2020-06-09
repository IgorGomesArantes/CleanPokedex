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
}

final class HomeViewController: UIViewController {
    // MARK: Properties
    private var interactor: HomeBusinessLogic?
    private var router: (HomeRoutingLogic & HomeDataPassing)?
    private var displayedPokemons: [Home.FetchPokemons.ViewModel.DisplayedPokemon] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.customView.pokemonsTableView.reloadData()
            }
        }
    }
    
    // MARK: View properties
    var customView: HomeView {
        return view as! HomeView
    }
}

// MARK: Initialization methods
extension HomeViewController {
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        initialConfiguration()
    }
}

// MARK: View lifecycle methods
extension HomeViewController {
    override func loadView() {
        view = HomeView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfiguration()
        navigationControllerConfiguration()
        interactor?.fetchPokemons(Home.FetchPokemons.Request())
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
        router.viewController = viewController
        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    func navigationControllerConfiguration() {
        title = "Clean Pokédex"
    }
    
    func tableViewConfiguration() {
        customView.pokemonsTableView.delegate = self
        customView.pokemonsTableView.dataSource = self
        
        customView.pokemonsTableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: String(describing: PokemonTableViewCell.self))
    }
}

// MARK: Display logic methods
extension HomeViewController: HomeDisplayLogic {
    func displayFetchedPokemons(_ viewModel: Home.FetchPokemons.ViewModel) {
        switch viewModel {
        case .success(let displayedPokemons):
            self.displayedPokemons = displayedPokemons
        case .failure(let displayedError):
            showAlertError(displayedError)
        }
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

// MARK: Private methods
private extension HomeViewController {
    func showAlertError(_ displayedError: Home.FetchPokemons.ViewModel.DisplayedError) {
        let alert = UIAlertController(title: displayedError.title, message: displayedError.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: displayedError.buttonTitle, style: .default, handler: { _ in
            self.interactor?.fetchPokemons(Home.FetchPokemons.Request())
        }))
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
}
