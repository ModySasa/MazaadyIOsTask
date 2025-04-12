//
//  MainController.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/12/25.
//

import UIKit
import L10n_swift

class MainController: UIViewController {
    var className : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        #if DEBUG
//        
//        #else
//        registerNetworkNotification()
//        #endif
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(onChangeLang), name: .L10nLanguageChanged, object: nil
        )
    }
    
    @objc func onChangeLang() {
        print("Lang changed to : \(L10n.shared.language)")
        
        var semantic: UISemanticContentAttribute = .forceLeftToRight
        
        if isArabic() {
            semantic = .forceRightToLeft
        }
        
        UIView.appearance().semanticContentAttribute = semantic
        
        // Update Tab Bar Item Titles
        if let customTabBarController = self.tabBarController as? CustomTabBar {
            customTabBarController.setText()
            customTabBarController.setRTL(isArabic())
        }
        
        // Update the view hierarchy to reflect the changes
        let window = self.view.superview
        self.view.removeFromSuperview()
        window?.addSubview(self.view)
    }
    
    func changeColorAndStatusBarColor(_ isDark : Bool = false ) {
        if(isDark){
            changeStatusToBlack()
            self.view.backgroundColor = UIColor(named: "background")
        } else {
            changeStatusToWhite()
            self.view.backgroundColor = UIColor(named: "background")
        }
    }
    
    func isArabic() -> Bool {
        L10n.shared.language == "ar"
    }
    
    func setupPage(
        _ medium : ProjectStrings ,
        reuseIdentifier : String = "" ,
        viewBackground : UIColor? = UIColor(named: "background"),
        background : UIColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ,
        isDarkPage : Bool = false
    ){
        self.view.backgroundColor = viewBackground
        
        if(isDarkPage){
            changeStatusToWhite()
        } else {
            changeStatusToBlack()
        }
        
        className = medium.rawValue
    }
    
    func changeStatusToWhite() {
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    func changeStatusToBlack() {
        UIApplication.shared.statusBarStyle = .darkContent
    }
    
    func setViewsWithSelectors(_ views:[ViewsWithSelectors]) {
        for v in views {
            let singleTap = UITapGestureRecognizer(target: self, action: v.action)
            
            v.view.isUserInteractionEnabled = true
            v.view.addGestureRecognizer(singleTap)
        }
    }
}
