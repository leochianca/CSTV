//
//  MatchesTableViewCell.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import UIKit

class MatchesTableViewCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var leagueImageView: UIImageView!
    @IBOutlet weak var firstTeamImageView: UIImageView!
    @IBOutlet weak var secondTeamImageView: UIImageView!
    @IBOutlet weak var firstTeamNameLabel: UILabel!
    @IBOutlet weak var secondTeamNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
