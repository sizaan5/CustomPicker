//
//  PickerViewController.swift
//  CustomPicker
//
//  Created by Admin on 15/08/2022.
//

import UIKit
import CollectionViewPagingLayout

class PickerViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    
    //MARK: - Properties
    private let layout = CollectionViewPagingLayout()
    private var didScrollCollectionViewToMiddle = false
    var vc: UIViewController?
    var range: Int = 1
    var items: [Int] = []
    var action: ((_ value: Int) -> Void)?
    var mainTitle: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for i in 1...range {
            items.append(i)
        }
        self.items.reverse()
        self.setupCollectionView()
        self.showAnimate()
        self.lblTitle.text = self.mainTitle
        self.view.backgroundColor = .black.withAlphaComponent(0.6)
    }
    
    //MARK: - Helper Methods
    func setupCollectionView() {
        self.collectionView.isPagingEnabled = true
        self.collectionView.collectionViewLayout = self.layout
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.clipsToBounds = false
        self.collectionView.backgroundColor = .clear
        
        self.collectionView.register(
            UINib(
                nibName: "PickerCollectionViewCell",
                bundle: nil
            ),
            forCellWithReuseIdentifier: "PickerCollectionViewCell"
        )
    }
    
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion:{(finished : Bool)  in
            if (finished) {
                self.view.removeFromSuperview()
            }
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - IBAction
    @IBAction func cancelAction(_ sender: UIButton) {
        self.removeAnimate()
    }
    

}

extension PickerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view.endEditing(true)
        let obj = self.items[indexPath.row]
        if let cell = self.collectionView.cellForItem(at: indexPath) as? PickerCollectionViewCell {
            cell.bgView.backgroundColor = .blue
        }
        self.action?(obj)
        Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { timer in
            self.removeAnimate()
        }
    }
}

extension PickerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "PickerCollectionViewCell", for: indexPath) as? PickerCollectionViewCell {
            let obj = self.items[indexPath.row]
            cell.lblTitle.text = "\(obj)"
            return cell
        }
        return UICollectionViewCell()
    }
}
