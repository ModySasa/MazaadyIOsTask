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
        
        tableView.register(UINib(nibName: "ProductsCell", bundle: nil), forCellReuseIdentifier: "ProductsCell")
        tableView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: "ProfileCell")
        tableView.register(UINib(nibName: "AdsCell", bundle: nil), forCellReuseIdentifier: "AdsCell")
        tableView.register(UINib(nibName: "TagsCell", bundle: nil), forCellReuseIdentifier: "TagsCell")
        tableView.register(UINib(nibName: "TabsCell", bundle: nil), forCellReuseIdentifier: "TabsCell")
        
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
            presenter.searchProducts(searchText: searchText)
            searchText = ""
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                self.tableView.reloadData()
//                self.tableView.layoutIfNeeded()
//            }
        }
    }
    
    // MARK: - UserViewProtocol Methods
    func showUserProfile(_ profile: UserProfile) {
        self.userProfile = profile
        tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }

    func showProducts(_ products: [Product]) {
        self.products = products
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.tableView.reloadSections(IndexSet(integer: 2), with: .automatic)
            self.tableView.layoutIfNeeded()
        }
    }

    func showAds(_ ads: [Advertisement]) {
        self.ads = ads
        tableView.reloadSections(IndexSet(integer: 3), with: .automatic)
    }

    func showTags(_ tags: [Tag]) {
        self.tags = tags
        tableView.reloadSections(IndexSet(integer: 4), with: .automatic)
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
        let bottomSheetVC = LangChangeBottomSheet()
        
        // Handle language selection
        bottomSheetVC.didSelectLanguage = { lang in
            self.changeLang(lang)
        }

        // Start with a transparent background to animate later
        bottomSheetVC.modalPresentationStyle = .overFullScreen
        bottomSheetVC.modalTransitionStyle = .crossDissolve
        
        present(bottomSheetVC, animated: false)
    }
    
    var isNotProductTab = false
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension UserViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 5 // Profile, Search, Products, Ads, Tags
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return userProfile == nil ? 0 : 1
        case 1: return 1
        case 2: return 1
        case 3: return ads.count > 0 ? 1 : 0
        case 4: return tags.count > 0 ? 1 : 0
        default: return 0
        }
    }
    
    func calculateHeight(for tags: [Tag], width: CGFloat) -> CGFloat {
        let spacing: CGFloat = 8
        let sectionInsets: CGFloat = 16  // Assuming 8 leading + 8 trailing

        var totalHeight: CGFloat = 0
        var currentRowWidth: CGFloat = 0
        var maxHeightInRow: CGFloat = 0

        for tag in tags {
            let text = tag.name ?? ""
            let size = text.size(with: UIFont(name: "Nunito-Bold", size: 12)!)
            let itemWidth = size.width + 46
            let itemHeight = size.height + 8

            if currentRowWidth + itemWidth + spacing > width - sectionInsets {
                // Move to next row
                totalHeight += maxHeightInRow + spacing
                currentRowWidth = 0
                maxHeightInRow = 0
            }

            currentRowWidth += itemWidth + spacing
            maxHeightInRow = max(maxHeightInRow, itemHeight)
        }

        totalHeight += maxHeightInRow // Add height of last row
        return totalHeight + 32 // Add topTagsLabel + padding
    }
    
    func calculateProductsHeight() -> CGFloat {
        if isNotProductTab {
            return 0
        } else {
            var leadingProducts : [Product] = []
            var middleProducts : [Product] = []
            var trailingProducts : [Product] = []
            
            var leadingProductsHeight : CGFloat = 0
            var middleProductsHeight : CGFloat = 0
            var trailingProductsHeight : CGFloat = 0
            
            for (index, product) in products.enumerated() {
                var itemHeight: CGFloat = 160
                
                if product.offer != nil {
                    itemHeight += (209 - 160)
                }
                if product.endDate != nil {
                    itemHeight += (265 - 209)
                }
                
                if index % 3 == 0 {
                    leadingProducts.append(product)
                    leadingProductsHeight += itemHeight
                } else if index % 3 == 1 {
                    middleProducts.append(product)
                    middleProductsHeight += itemHeight
                } else {
                    trailingProducts.append(product)
                    trailingProductsHeight += itemHeight
                }
            }
            
            leadingProductsHeight += CGFloat(8 * (leadingProducts.count - 1))
            middleProductsHeight += CGFloat(8 * (middleProducts.count - 1))
            trailingProductsHeight += CGFloat(8 * (trailingProducts.count - 1))
            
            let totalHeight = 172 + max(leadingProductsHeight , middleProductsHeight, trailingProductsHeight)
            
            return totalHeight
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return calculateProductsHeight()
        } else if indexPath.section == 0 {
            return 250
        } else if indexPath.section == 1 {
            return 35
        } else if indexPath.section == 3 {
            return CGFloat(ads.count) * (150.0 + 16.0) + 60
        } else {
            return calculateHeight(for: tags, width: tableView.frame.width) + 50
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
            if let profile = userProfile {
                cell.configure(with: profile)
            }
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TabsCell", for: indexPath) as! TabsCell
            cell.configure { tab in
                self.isNotProductTab = tab != .products
                if(self.isNotProductTab) {
                    self.products.removeAll()
                    self.ads.removeAll()
                    self.tags.removeAll()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.tableView.reloadData()
                        self.tableView.layoutIfNeeded()
                    }
                } else {
                    self.presenter.loadInitialData()
                }
            }
            return cell
            
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsCell", for: indexPath) as! ProductsCell
            cell.configure(with: products) { searchText in
                self.searchText = searchText
            }
            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdsCell", for: indexPath) as! AdsCell
            cell.configure(with: ads)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TagsCell", for: indexPath) as! TagsCell
            cell.configure(with: tags)
            return cell
        }
    }
}
