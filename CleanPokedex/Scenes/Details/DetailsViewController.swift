//
//  DetailsViewController.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 06/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import UIKit

protocol DetailsDisplayLogic: class {
    func displayDetails(_ viewModel: Details.ShowDetails.ViewModel)
    func displaySelectTab(_ viewModel: Details.SelectTab.ViewModel)
}

final class DetailsViewController: UIViewController {
    // MARK: Properties
    var interactor: DetailsBusinessLogic?
    var router: (DetailsRoutingLogic & DetailsDataPassing)?
    
    private var displayedSections: [Details.SelectTab.ViewModel.SectionType] = [] {
        didSet {
            customView.informationTableView.reloadData()
        }
    }
    
    private var displayedTabs: [String] = [] {
        didSet {
            customView.tabsCollectionView.performBatchUpdates({
                self.customView.tabsCollectionView.reloadData()
            }) { _ in
                self.interactor?.selectTab(Details.SelectTab.Request(selectedTab: IndexPath(row: 0, section: 0)))
            }
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
        interactor?.showDetails(Details.ShowDetails.Request())
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
        
        customView.informationTableView.register(StatsTableViewCell.self, forCellReuseIdentifier: String(describing: StatsTableViewCell.self))
        customView.informationTableView.register(OverviewTableViewCell.self, forCellReuseIdentifier: String(describing: OverviewTableViewCell.self))
        customView.informationTableView.register(AboutTableViewCell.self, forCellReuseIdentifier: String(describing: AboutTableViewCell.self))
        customView.informationTableView.register(EvolutionTableViewCell.self, forCellReuseIdentifier: String(describing: EvolutionTableViewCell.self))
    }
}

// MARK: Display logic methods
extension DetailsViewController: DetailsDisplayLogic {
    func displayDetails(_ viewModel: Details.ShowDetails.ViewModel) {
        title = viewModel.title
        displayedTabs = viewModel.displayedTabs
        setupDetailsView(viewModel.displayedPokemon)
    }
    
    func displaySelectTab(_ viewModel: Details.SelectTab.ViewModel) {
        setTabCellAsSelected(viewModel.selectedTab)
        setTabCellAsDeselected(viewModel.deselectedTab)
        
        displayedSections = viewModel.displayedSections
    }
}

// MARK: Setup methods
private extension DetailsViewController {
    func setupDetailsView(_ displayedPokemon: Details.ShowDetails.ViewModel.DisplayedPokemon) {
        setupTags(displayedPokemon.types)
        customView.codeLabel.text = displayedPokemon.code
        customView.nameLabel.text = displayedPokemon.name
        customView.backgroundColor = displayedPokemon.backgroundColor
        customView.pokemonImageView.kf.setImage(with: URL(string: displayedPokemon.imageURL)!)
    }
    
    func setupTags(_ types: [PokemonType]) {
        types.forEach { customView.tagsStackView.addArrangedSubview(UIImageView(image: $0.tagImage)) }
    }
}

// MARK: Table view data source methods
extension DetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return displayedSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch displayedSections[section] {
        case .overview:
            return 1
        case .stats(let stats):
            return stats.data.count
        case .about(let about):
            return about.data.count
        case .evolution(let evolution):
            return evolution.data.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch displayedSections[indexPath.section] {
        case .overview(let data):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: OverviewTableViewCell.self), for: indexPath) as! OverviewTableViewCell
            cell.setup(overview: data.text)
            return cell
        case .about(let about):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AboutTableViewCell.self), for: indexPath) as! AboutTableViewCell
            cell.setup(about.data[indexPath.row])
            return cell
        case .stats(let stats):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: StatsTableViewCell.self), for: indexPath) as! StatsTableViewCell
            cell.setup(stats.data[indexPath.row])
            return cell
        case .evolution(let evolution):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EvolutionTableViewCell.self), for: indexPath) as! EvolutionTableViewCell
            cell.setup(evolution.data[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch displayedSections[section] {
        case .evolution(let data):
            return data.headerTitle
        case .about(let data):
            return data.headerTitle
        case .stats(let data):
            return data.headerTitle
        case .overview:
            return nil
        }
    }
}

// MARK: Table view delegate methods
extension DetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        
        switch displayedSections[section] {
        case .evolution(let data):
            header.textLabel?.textColor = data.headerTitleColor
        case .about(let data):
            header.textLabel?.textColor = data.headerTitleColor
        case .stats(let data):
            header.textLabel?.textColor = data.headerTitleColor
        case .overview:
            break
        }
        
        header.tintColor = .white
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
        interactor?.selectTab(Details.SelectTab.Request(selectedTab: indexPath))
    }
}

// MARK: Private methods
private extension DetailsViewController {
    func setTabCellAsSelected(_ indexPath: IndexPath) {
        guard let selectedCell = customView.tabsCollectionView.cellForItem(at: indexPath) as? TabCollectionViewCell else { return }
        selectedCell.setAsSelected()
    }
    
    func setTabCellAsDeselected(_ indexPath: IndexPath) {
        guard let deselectedCell = customView.tabsCollectionView.cellForItem(at: indexPath) as? TabCollectionViewCell else { return }
        deselectedCell.setAsDeselected()
    }
}
