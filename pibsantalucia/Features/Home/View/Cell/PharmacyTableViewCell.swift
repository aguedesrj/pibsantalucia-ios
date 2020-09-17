//
//  PharmacyTableViewCell.swift
//  pibsantalucia

//  Copyright © 2020 André Lessa Guedes. All rights reserved.
//

import UIKit
import Kingfisher

class PharmacyTableViewCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var imageViewIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelName.textColor = Color.primary.value
    }
    
    func setValues(pharmacy: PharmacyModel) {
        labelName.text = pharmacy.name
        labelAddress.text = pharmacy.address
        
        let sizeImageView: CGSize = imageViewIcon.frame.size
        imageViewIcon.layer.cornerRadius = sizeImageView.width / 2
        imageViewIcon.layer.borderColor = Color.primary.value.cgColor
        imageViewIcon.layer.borderWidth = 2
        imageViewIcon.kf.indicatorType = .activity
        
        imageViewIcon.kf.setImage(
            with: URL(string: pharmacy.icon),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.1))
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Sucesso: \(value.source.url?.absoluteString ?? "")")
                self.imageViewIcon.image = value.image
            case .failure(let error):
                print("Erro: \(error.localizedDescription)")
            }
        }
    }
}
