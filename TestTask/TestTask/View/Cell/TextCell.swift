//
//  TextCell.swift
//  TestTask
//
//  Created by Ruslan Khanov on 07.04.2021.
//

import UIKit

enum TextCellStyle: Int {
    case normalText
    case largeText
}

class TextCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private var descriptionLabel: UILabel!
    
    // MARK: - Vars & Lets
    var style: TextCellStyle? {
        didSet {
            guard let style = style else { return }
            
            switch style {
            case .normalText:
                descriptionLabel.font = descriptionLabel.font.withSize(18)
            case .largeText:
                descriptionLabel.font = descriptionLabel.font.withSize(32)
            }
        }
    }
    
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
    
    func configure(text: String, style: TextCellStyle) {
        descriptionLabel.text = text
        self.style = style
    }

}
