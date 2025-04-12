//
//  UserViewController.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/11/25.
//

import UIKit
import L10n_swift

class UserViewController: MainController, UserViewProtocol , UISearchBarDelegate {

    @IBOutlet weak var langStack: UIStackView!
    @IBOutlet weak var langLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var presenter: UserPresenter!

    private var userProfile: UserProfile?
    private var products: [Product] = []
    private var filteredProducts: [Product] = []
    private var ads: [Advertisement] = []
    private var tags: [Tag] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupPresenter()
        changeLang(isArabic() ? .ar : .en)
        presenter.loadInitialData()
        setViewsWithSelectors(
            .init(arrayLiteral:
                    .init(langStack, #selector(showLangSheet))
            )
        )
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: "ProfileCell")
        
    }
    
    private func setupPresenter() {
        let userInteractor = UserInteractorNetworkManager()
        let productsInteractor = ProductsInteractorNetworkManager()
        let adsInteractor = AdsInteractorNetworkManager()
        let tagsInteractor = TagsInteractorNetworkManager()
        
        presenter = UserPresenter(
            view: self,
            userInteractor: userInteractor,
            productsInteractor: productsInteractor,
            adsInteractor: adsInteractor,
            tagsInteractor: tagsInteractor
        )
    }

    //MARK: - Search Methods
    private var searchText: String = "" {
        didSet {
            if searchText.count > 2 {
                filteredProducts = products.filter { ($0.name ?? "").lowercased().contains(searchText.lowercased()) }
            } else {
                filteredProducts = products
            }
            tableView.reloadSections(IndexSet(integer: 2), with: .automatic)
        }
    }
    
    // MARK: - UserViewProtocol Methods
    func showUserProfile(_ profile: UserProfile) {
        print("User: \(profile.name ?? "")")
        self.userProfile = profile
        tableView.reloadData()
    }

    func showProducts(_ products: [Product]) {
        print("Loaded \(products.count) products")
        print("FILTERED \(filteredProducts.count) filteredProducts")
        self.products = products
        self.filteredProducts = products
        tableView.reloadData()
    }


    func showAds(_ ads: [Advertisement]) {
        print("Loaded \(ads.count) ads")
        self.ads = ads
        tableView.reloadData()
    }

    func showTags(_ tags: [Tag]) {
        print("Loaded \(tags.count) tags")
        self.tags = tags
        tableView.reloadData()
    }

    func showError(_ error: String) {
        print("Error: \(error)")
        // TODO: show error alert
    }
    
    //MARK: CHANGE LANG
    
    func changeLang(_ lang: Lang) {
        if(L10n.shared.language != lang.rawValue) {
            L10n.shared.language = lang.rawValue
        }
        
        langLabel.text = isArabic() ? "العربيه" : "English"
        langLabel.font = UIFont(name: "Nunito-Regular", size: 12)
        langLabel.textColor = UIColor(named: "gray4")
        
        presenter.loadInitialData()
    }
    
    @objc
    func showLangSheet() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let arabicAction = UIAlertAction(title: "العربية", style: .default) { _ in
            self.changeLang(.ar)
        }
        
        let englishAction = UIAlertAction(title: "English", style: .default) { _ in
            self.changeLang(.en)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alertController.addAction(arabicAction)
        alertController.addAction(englishAction)
        alertController.addAction(cancelAction)

        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }

        present(alertController, animated: true)
    }
    
}

enum Lang : String {
    case ar = "ar"
    case en = "en"
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension UserViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 5 // Profile, Search, Products, Ads, Tags
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return userProfile == nil ? 0 : 1
        case 1: return 1 // Search
        case 2: return filteredProducts.count
        case 3: return ads.count
        case 4: return tags.count
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0, let profile = userProfile {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
            cell.configure(with: profile)
            return cell
        } else if indexPath.section == 1 {
            let cell = UITableViewCell()
            let searchBar = UISearchBar()
            searchBar.delegate = self
            searchBar.placeholder = "Search products"
            cell.contentView.addSubview(searchBar)
            searchBar.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                searchBar.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                searchBar.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
                searchBar.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
                searchBar.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor)
            ])
            return cell
        }

        let cell = UITableViewCell()
        cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        return cell
    }
}
