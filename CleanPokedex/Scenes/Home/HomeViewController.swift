//
//  HomeViewController.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 03/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic {
    func displayFetchedPokemons(displayedPokemons: [Home.FetchPokemons.ViewModel.DisplayedPokemon])
    func displayFetchPokemonsError(displayedMessage: String)
}

final class HomeViewController: UIViewController {
    // MARK: Properties
    private var interactor: HomeInteractor?
    private var displayedPokemons: [Home.FetchPokemons.ViewModel.DisplayedPokemon] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.homeView.pokemonsTableView.reloadData()
            }
        }
    }
    
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
        viewConfiguration()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchPokemons()
    }
}

// MARK: Configuration methods
private extension HomeViewController {
    func initialConfiguration() {
        let viewController = self
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        
        interactor.presenter = presenter
        viewController.interactor = interactor
        presenter.viewController = viewController
    }
    
    func viewConfiguration() {
        homeView.pokemonsTableView.delegate = self
        homeView.pokemonsTableView.dataSource = self
    }
}

// MARK: Private methods
private extension HomeViewController {
    func showFetchPokemonsAlertError(displayedMessage: String) {
        let alert = UIAlertController(title: "Houve um erro ao buscar os Pokemons.", message: displayedMessage, preferredStyle: .alert)
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
    func displayFetchedPokemons(displayedPokemons: [Home.FetchPokemons.ViewModel.DisplayedPokemon]) {
        self.displayedPokemons = displayedPokemons
    }
    
    func displayFetchPokemonsError(displayedMessage: String) {
        showFetchPokemonsAlertError(displayedMessage: displayedMessage)
    }
}

// MARK: Table view data source methods
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedPokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = displayedPokemons[indexPath.row].name
        return cell
    }
}

// MARK: Table view delegate methods
extension HomeViewController: UITableViewDelegate {
    
}
