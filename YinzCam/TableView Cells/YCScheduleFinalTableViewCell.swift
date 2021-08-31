//
//  YCScheduleFinalTableViewCell.swift
//  YinzCam
//
//  Created by Saumya Lahera on 8/31/21.
//

import UIKit

class YCScheduleFinalTableViewCell: UITableViewCell {

    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var homeTeamScore: UILabel!
    @IBOutlet weak var homeTeamTriCode: UIImageView!
    @IBOutlet weak var awayTeamName: UILabel!
    @IBOutlet weak var awayTeamScore: UILabel!
    @IBOutlet weak var awayTeamTriCode: UIImageView!
    @IBOutlet weak var gameDate: UILabel!
    @IBOutlet weak var gameWeek: UILabel!
    @IBOutlet weak var gameType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
