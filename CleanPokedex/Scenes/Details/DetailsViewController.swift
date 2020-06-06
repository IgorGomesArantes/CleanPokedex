//
//  DetailsViewController.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 06/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import UIKit

protocol DetailsDisplayLogic: class {
    func displayDetails(viewModel: Details.ShowDetails.ViewModel)
}

final class DetailsViewController: UIViewController {
    // MARK: Properties
    var interactor: DetailsBusinessLogic?
    var router: (DetailsRoutingLogic & DetailsDataPassing)?
    
    // MARK: View properties
    var customView: DetailsView {
        return view as! DetailsView
    }
}

// MARK: Initialization methods
extension DetailsViewController {
    convenience init() {
        self.init(nibName:nil, bundle:nil)
        initialConfiguration()
    }
}

// MARK: Life cycle methods
extension DetailsViewController {
    override func loadView() {
        view = DetailsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.showDetails()
    }
}

// MARK: Configuration methods
private extension DetailsViewController {
    func initialConfiguration() {
        let viewController = self
        let router = DetailsRouter()
        let presenter = DetailsPresenter()
        let interactor = DetailsInteractor()
        
        router.dataStore = interactor
        viewController.router = router
        interactor.presenter = presenter
        viewController.interactor = interactor
        router.viewController = viewController
        presenter.viewController = viewController
    }
}

// MARK: Display logic methods
extension DetailsViewController: DetailsDisplayLogic {
    func displayDetails(viewModel: Details.ShowDetails.ViewModel) {
        setupDetailsView(viewModel.displayedPokemon)
    }
}

// MARK: Private methods
private extension DetailsViewController {
    func setupDetailsView(_ displayedPokemon: Details.ShowDetails.ViewModel.DisplayedPokemon) {
        setupTags(displayedPokemon.types)
        customView.codeLabel.text = displayedPokemon.code
        customView.nameLabel.text = displayedPokemon.name
        customView.pokemonImageView.kf.setImage(with: URL(string: displayedPokemon.imageURL)!)
        customView.backgroundColor = UIColor.getPokemonBackgroundColor(withType: displayedPokemon.mainType)
    }
    
    func setupTags(_ types: [PokemonType]) {
        types.forEach { setupTag(forType: $0) }
    }
    
    func setupTag(forType type: PokemonType) {
        let imageView = UIImageView(image: UIImage.getPokemonTag(withType: type))
        customView.tagsStackView.addArrangedSubview(imageView)
    }
}

