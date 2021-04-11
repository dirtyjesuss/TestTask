//
//  IconDetailTextCell.swift
//  TestTask
//
//  Created by Ruslan Khanov on 07.04.2021.
//

import UIKit

class IconRightDetailTextCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var shortTextLabel: UILabel!
    @IBOutlet private var rightDetailTextLabel: UILabel!
    
    // MARK: - View

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Configure
    
    func configure(icon: UIImage, text: String, detailText: String) {
        iconImageView.image = icon
        shortTextLabel.text = text
        rightDetailTextLabel.text = detailText
    }

}
