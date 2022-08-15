//
//  PickerCollectionViewCell.swift
//  CustomPicker
//
//  Created by Admin on 15/08/2022.
//

import UIKit
import CollectionViewPagingLayout

class PickerCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblTitle: UILabel!

    //MARK: - Properties
    private var edgeConstraints: [NSLayoutConstraint]?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.bgView.layer.cornerRadius = self.bgView.layer.frame.height / 2
    }
}

extension PickerCollectionViewCell: StackTransformView {
    //scale
//    var scaleOptions: ScaleTransformViewOptions {
//        .layout(.rotary)
//    }
    //stack
    var stackOptions: StackTransformViewOptions {
        .layout(.transparent)
    }
}
