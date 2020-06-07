//
//  DetailsViewController.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 06/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import UIKit

protocol DetailsDisplayLogic: class {
    func displayTabs(_ viewModel: Details.ShowTabs.ViewModel)
    func displayDetails(_ viewModel: Details.ShowDetails.ViewModel)
    func displaySelectTab(_ viewModel: Details.SelectTab.ViewModel)
    func displayDeselectTab(_ viewModel: Details.SelectTab.ViewModel)
    func displayTabInformations(_ viewModel: Details.ShowTabInformations.ViewModel)
}

final class DetailsViewController: UIViewController {
    // MARK: Properties
    var interactor: DetailsBusinessLogic?
    var router: (DetailsRoutingLogic & DetailsDataPassing)?
    
    private var displayedCells: [Details.ShowTabInformations.ViewModel.CellType] = [] {
        didSet {
            customView.informationTableView.reloadData()
        }
    }
    
    private var displayedTabs: [String] = [] {
        didSet {
            customView.tabsCollectionView.reloadData()
        }
    }
    
    // MARK: View properties
    var customView: DetailsView {
        return view as! DetailsView
    }
}

// MARK: Initialization methods
extension DetailsViewController {
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        initialConfiguration()
        viewConfiguration()
    }
}

// MARK: Life cycle methods
extension DetailsViewController {
    override func loadView() {
        view = DetailsView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.start()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor?.selectTab(withIndexPath: IndexPath(row: 0, section: 0))
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
    
    func viewConfiguration() {
        tabsCollectionConfigurationView()
        informationTableViewConfiguration()
    }
    
    func tabsCollectionConfigurationView() {
        customView.tabsCollectionView.delegate = self
        customView.tabsCollectionView.dataSource = self
        
        customView.tabsCollectionView.register(TabCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: TabCollectionViewCell.self))
    }
    
    func informationTableViewConfiguration() {
        customView.informationTableView.delegate = self
        customView.informationTableView.dataSource = self
        
        customView.informationTableView.register(OverviewTableViewCell.self, forCellReuseIdentifier: String(describing: OverviewTableViewCell.self))
        customView.informationTableView.register(KeyValueTableViewCell.self, forCellReuseIdentifier: String(describing: KeyValueTableViewCell.self))
    }
}

// MARK: Display logic methods
extension DetailsViewController: DetailsDisplayLogic {
    func displayTabs(_ viewModel: Details.ShowTabs.ViewModel) {
        displayedTabs = viewModel.displayedTabs
    }
    
    func displayDetails(_ viewModel: Details.ShowDetails.ViewModel) {
        setupDetailsView(viewModel.displayedPokemon)
    }
    
    func displaySelectTab(_ viewModel: Details.SelectTab.ViewModel) {
        guard let cell = customView.tabsCollectionView.cellForItem(at: viewModel.indexPath) as? TabCollectionViewCell else { return }
        cell.setAsSelected()
    }
    
    func displayDeselectTab(_ viewModel: Details.SelectTab.ViewModel) {
        guard let cell = customView.tabsCollectionView.cellForItem(at: viewModel.indexPath) as? TabCollectionViewCell else { return }
        cell.setAsDeselected()
    }
    
    func displayTabInformations(_ viewModel: Details.ShowTabInformations.ViewModel) {
        displayedCells = viewModel.displayedCells
    }
}

// MARK: Setup methods
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

// MARK: Table view data source methods
extension DetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return displayedCells.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch displayedCells[section] {
        case .overview:
            return 1
        case .baseStats(let data):
            return data.1.count
        case .keyValue(let data):
            return data.1.count
        case .evolution(let data):
            return data.1.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch displayedCells[indexPath.section] {
        case .overview(let data):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: OverviewTableViewCell.self), for: indexPath) as! OverviewTableViewCell
            cell.setup(overview: data.text)
            return cell
        case .keyValue(let data):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: KeyValueTableViewCell.self), for: indexPath) as! KeyValueTableViewCell
            cell.setup(data: data.1[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch displayedCells[section] {
        case .evolution(let data):
            return data.0
        case .keyValue(let data):
            return data.0
        case .baseStats(let data):
            return data.0
        case .overview:
            return nil
        }
    }
}

// MARK: Table view delegate methods
extension DetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.tintColor = .white
        header.textLabel?.textColor = UIColor(red: 98/255, green: 185/255, blue: 87/255, alpha: 1)
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    }
}

// MARK: Collection view data source methods
extension DetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedTabs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TabCollectionViewCell.self), for: indexPath) as! TabCollectionViewCell
        cell.setup(title: displayedTabs[indexPath.row])
        return cell
    }
}

// MARK: Collection view flow layout methods
extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / CGFloat(displayedTabs.count), height: 50)
    }
}

// MARK: Collection view delegate methods
extension DetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor?.selectTab(withIndexPath: indexPath)
    }
}
