//
//  CustomBottomSheet.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/13/25.
//

import UIKit

class LangChangeBottomSheet: MainController {

    @IBOutlet weak var langLabel: UILabel!
    @IBOutlet weak var closeSheetImage: UIImageView!
    @IBOutlet weak var bottomSheet: UIView!
    @IBOutlet weak var englishStack: UIStackView!
    @IBOutlet weak var arabicStack: UIStackView!
    
    @IBOutlet weak var englishLabel: UILabel!
    @IBOutlet weak var englishRadioImage: UIImageView!
    
    @IBOutlet weak var arabicLabel: UILabel!
    @IBOutlet weak var arabicRadioImage: UIImageView!
    
    @IBOutlet weak var searchField: UITextField!
    
    var didSelectLanguage: ((Lang) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.layer.cornerRadius = 10
        searchField.borderStyle = .roundedRect
        searchField.layer.borderWidth = 1
        searchField.layer.borderColor = UIColor(named: "field_border")!.cgColor
        
        
        langLabel.text = strings(key: .language)
        langLabel.font = UIFont(name: "Nunito-Bold", size: 24)
        langLabel.textColor = UIColor(named: "text_black")
        
        setViewsWithSelectors(
            .init(arrayLiteral:
                    .init(arabicStack, #selector(selectArabic)),
                    .init(englishStack, #selector(selectEnglish)),
                    .init(closeSheetImage, #selector(cancel))
                 )
        
        )
        
        // Start sheet off-screen
        bottomSheet.transform = CGAffineTransform(translationX: 0, y: view.bounds.height)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        
        arabicLabel.text = "العربية"
        arabicLabel.font = UIFont(name: "Nunito-Regular", size: 16)
        arabicLabel.textColor = UIColor(named: "gray3")
        
        englishLabel.text = "English"
        englishLabel.font = UIFont(name: "Nunito-Regular", size: 16)
        englishLabel.textColor = UIColor(named: "gray3")
        
        if(isArabic()) {
            arabicRadioImage.image = UIImage(named: "radio_on")
            englishRadioImage.image = UIImage(named: "radio_off")
        } else {
            englishRadioImage.image = UIImage(named: "radio_on")
            arabicRadioImage.image = UIImage(named: "radio_off")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            self.bottomSheet.transform = .identity
        }
    }
    
    @objc func selectArabic() {
        didSelectLanguage?(.ar)
        cancel()
    }
    
    @objc func selectEnglish() {
        didSelectLanguage?(.en)
        cancel()
    }
    
    @objc func cancel() {
        UIView.animate(withDuration: 0.3, animations: {
            self.bottomSheet.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.height)
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        }) { _ in
            self.dismiss(animated: false)
        }
    }

}
