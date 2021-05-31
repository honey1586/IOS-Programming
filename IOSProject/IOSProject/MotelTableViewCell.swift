//
//  MotelTableViewCell.swift
//  IOSProject
//
//  Created by Jaeyeong on 2021/05/31.
//

import UIKit

class MotelTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cellView.layer.cornerRadius = 15
//        cellView.layer.shadowColor = UIColor.black.cgColor
//        cellView.layer.shadowOffset = CGSize(width: 0, height: 0)
//        cellView.layer.shadowRadius = 2
//        cellView.layer.shadowOpacity = 0.15
        //cellView.layer.shouldRasterize = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            cellView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        } else {
            cellView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        }
    }
}
