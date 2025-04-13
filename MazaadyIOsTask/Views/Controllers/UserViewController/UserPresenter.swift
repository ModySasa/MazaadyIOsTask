//
//  UserPresenter.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/12/25.
//

import Foundation

protocol UserViewProtocol: AnyObject {
    func showUserProfile(_ profile: UserProfile)
    func showProducts(_ products: [Product])
    func showAds(_ ads: [Advertisement])
    func showTags(_ tags: [Tag])
    func showError(_ error: String)
}

class UserPresenter {
    
    weak var view: UserViewProtocol?
    
    private let userInteractor: UserInteractorMethod
    private let productsInteractor: ProductsInteractorMethod
    private let adsInteractor: AdsInteractorMethod
    private let tagsInteractor: TagsInteractorMethod
    
    init(
        view: UserViewProtocol,
        userInteractor: UserInteractorMethod,
        productsInteractor: ProductsInteractorMethod,
        adsInteractor: AdsInteractorMethod,
        tagsInteractor: TagsInteractorMethod
    ) {
        self.view = view
        self.userInteractor = userInteractor
        self.productsInteractor = productsInteractor
        self.adsInteractor = adsInteractor
        self.tagsInteractor = tagsInteractor
    }
    
    func loadInitialData() {
        Task {
            await fetchUserProfile()
            await fetchProducts()
            await fetchAds()
            await fetchTags()
        }
    }
    
    func searchProducts(searchText keyword: String) {
        Task {
            await fetchProducts(by: keyword)
        }
    }
    @MainActor
    private func fetchUserProfile() async {
        let result = await userInteractor.getUser()
        switch result {
        case .success(let response):
            view?.showUserProfile(response)
        case .failure(let error):
            view?.showError("Failed to load user: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    private func fetchProducts(by searchText : String? = nil) async {
        let result = await productsInteractor.getProducts(.init(name: searchText))
        switch result {
        case .success(let response):
            view?.showProducts(response)
        case .failure(let error):
            view?.showError("Failed to load products: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    private func fetchAds() async {
        let result = await adsInteractor.getAds()
        switch result {
        case .success(let response):
            if let ads = response.advertisements {
                view?.showAds(ads)
            }
        case .failure(let error):
            view?.showError("Failed to load ads: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    private func fetchTags() async {
        let result = await tagsInteractor.getTags()
        switch result {
        case .success(let response):
            if let tags = response.tags {
                view?.showTags(tags)
            }
        case .failure(let error):
            view?.showError("Failed to load tags: \(error.localizedDescription)")
        }
    }
}
