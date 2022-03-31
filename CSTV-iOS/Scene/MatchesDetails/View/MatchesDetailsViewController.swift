//
//  MatchesDetailsViewController.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import UIKit

class MatchesDetailsViewController: UIViewController {
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var firstTeamImageView: UIImageView!
    @IBOutlet weak var secondTeamImageView: UIImageView!
    @IBOutlet weak var firstTeamNameLabel: UILabel!
    @IBOutlet weak var secondTeamNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var firstTeamTableView: UITableView!
    @IBOutlet weak var secondTeamTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
    }
}
