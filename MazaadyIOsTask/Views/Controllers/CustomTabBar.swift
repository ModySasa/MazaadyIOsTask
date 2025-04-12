//
//  CustomTabBar.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/12/25.
//

import UIKit

var itemIndex = 3

class CustomTabBar : UITabBarController, UITabBarControllerDelegate {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setText()
        setupInitilView()
        
        self.selectedIndex = itemIndex
    }
    
    func setRTL(_ isArabic : Bool = false){
        var semantic: UISemanticContentAttribute = .forceLeftToRight
        
        if isArabic {
            semantic = .forceRightToLeft
        }
        
        UIView.appearance().semanticContentAttribute = semantic
        
        let window = self.view.superview
        self.view.removeFromSuperview()
        window?.addSubview(self.view)
    }
    
 
    @objc func setText() {
          
        tabBar.items?[0].title = strings(key: .home , preName: .navBar)
        tabBar.items?[1].title = strings(key: .search , preName: .navBar)
        tabBar.items?[2].title = strings(key: .cart , preName: .navBar)
        tabBar.items?[3].title = strings(key: .user , preName: .navBar)

        tabBar.items?[0].image = UIImage(named: "tab_bar_home")
        
        tabBar.items?[1].image = UIImage(named: "tab_bar_search")
         
        tabBar.items?[2].image = UIImage(named: "tab_bar_cart")
        
        tabBar.items?[3].image = UIImage(named: "tab_bar_user")
        
//        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -8)
        
//        tabBar.items?[0].imageInsets = UIEdgeInsets(top: 22.5, left: 22.5, bottom: 22.5, right: 22.5)
//        tabBar.items?[1].imageInsets = UIEdgeInsets(top: 22.5, left: 22.5, bottom: 22.5, right: 22.5)
//        tabBar.items?[2].imageInsets = UIEdgeInsets(top: 22.5, left: 22.5, bottom: 22.5, right: 22.5)
//        tabBar.items?[3].imageInsets = UIEdgeInsets(top: 22.5, left: 22.5, bottom: 22.5, right: 22.5)
//        tabBar.items?[4].imageInsets = UIEdgeInsets(top: 22.5, left: 22.5, bottom: 22.5, right: 22.5)
        
       
        for tab in tabBar.items! {
            tab.imageInsets = UIEdgeInsets(top: -1, left: 22.5, bottom: 1, right: 22.5)
        }
        
        tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        tabBar.layer.shadowOpacity = 0.10
        tabBar.layer.shadowOffset = CGSize.zero
        tabBar.layer.shadowRadius = 5
        self.tabBar.layer.borderColor = UIColor.clear.cgColor
        self.tabBar.layer.borderWidth = 0
        self.tabBar.clipsToBounds = false
        self.tabBar.backgroundColor = UIColor.white
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        
      }
 
    
    
    @objc func menuButtonAction(sender: UIButton) {
        self.selectedIndex = 3
    }
    
    // MARK: - setup Initial View Methode.
    private func setupInitilView() {
        
        delegate = self
        
        // Sets the default color of the icon of the selected UITabBarItem and Title
        UITabBar.appearance().tintColor = UIColor(named: "nav_bar_selected")
        
        // Sets the default color of the background of the UITabBar
        UITabBar.appearance().barTintColor = UIColor.white
        
        //            UITabBar.appearance().selectionIndicatorImage = UIImage(named: "selected_icon")
        
        self.tabBar.unselectedItemTintColor = UIColor(named: "nav_bar_unselected")
        
        
        let itemIndex:CGFloat = 2.0
        
        let bgColor = UIColor.black
        let itemWidth = tabBar.frame.width / CGFloat(tabBar.items!.count)
        let bgView = UIView(frame: CGRect.init(x: itemWidth * itemIndex, y: 0, width: itemWidth, height: tabBar.frame.height))
        
    }
    
    // MARK: - UITabbarController Override Methods .
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }
    
    
    // MARK: - UITabBarControllerDelegate Methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        return true
    }
    
    
    
}
