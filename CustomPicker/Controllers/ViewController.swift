//
//  ViewController.swift
//  CustomPicker
//
//  Created by Admin on 15/08/2022.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblPlaceholder: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    func showPopUpAlert(
        title: String,
        range: Int,
        action: ((_ value: Int) -> Void)?
    ) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PickerViewController") as! PickerViewController
        
        popOverVC.mainTitle = title
        popOverVC.vc = self
        popOverVC.range = range
        popOverVC.action = action
        
        self.addChild(popOverVC)
        let keyWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        var rect = keyWindow!.frame
        rect.origin.y = 0
        popOverVC.view.frame = rect
        
        self.view.addSubview(popOverVC.view)
        
        keyWindow!.addSubview(popOverVC.view)
        keyWindow!.bringSubviewToFront(popOverVC.view)
        
    }
    
    //MARK: - IBActions
    @IBAction func pickerAction(_ sender: UIButton) {
        self.showPopUpAlert(title: "NO. of Guests", range: 6) { value in
            self.lblPlaceholder.text = "Selected Guests: \(value)"
        }
    }
    

}

