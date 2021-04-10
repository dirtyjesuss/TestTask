//
//  Cell.swift
//  TestTask
//
//  Created by Ruslan Khanov on 10.04.2021.
//

import UIKit

enum Cell {
    case textCell(text: String, style: TextCellStyle)
    case iconRightDetailTextCell(icon: UIImage, text: String, detailText: String)
}
