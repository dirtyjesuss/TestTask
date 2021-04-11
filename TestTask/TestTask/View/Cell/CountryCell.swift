//
//  CountryCell.swift
//  TestTask
//
//  Created by Ruslan Khanov on 07.04.2021.
//

import UIKit

class CountryCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var capitalLabel: UILabel!
    @IBOutlet private var flagImageView: UIImageView!
    @IBOutlet private var shortDescriptionLabel: UILabel!
    
    func configure(name: String, capital: String, flagImage: UIImage?, shortDescription: String) {
        nameLabel.text = name
        capitalLabel.text = capital
        flagImageView.image = flagImage
        shortDescriptionLabel.text = shortDescription
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
