//
//  ActivityTableViewCell.swift
//  LifeLevel
//
//  Created by Mac on 25/09/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var activityImageView: UIImageView!
    @IBOutlet weak var decriptionLabel: UILabel!
    @IBOutlet weak var activityTypeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
