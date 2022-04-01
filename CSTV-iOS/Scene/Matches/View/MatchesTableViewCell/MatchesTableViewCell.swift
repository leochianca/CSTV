//
//  MatchesTableViewCell.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import UIKit
import Kingfisher

class MatchesTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var vsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeLabelView: UIView!
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var leagueImageView: UIImageView!
    @IBOutlet weak var firstTeamImageView: UIImageView!
    @IBOutlet weak var secondTeamImageView: UIImageView!
    @IBOutlet weak var firstTeamNameLabel: UILabel!
    @IBOutlet weak var secondTeamNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupElements()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.timeLabel.text?.removeAll()
        self.leagueNameLabel.text?.removeAll()
        self.firstTeamNameLabel.text?.removeAll()
        self.secondTeamNameLabel.text?.removeAll()
        self.leagueImageView.image = nil
        self.firstTeamImageView.image = nil
        self.secondTeamImageView.image = nil
    }
    
    func setupElements() {
        self.vsLabel.font = .roboto(type: .regular, size: 12)
        self.leagueNameLabel.font = .roboto(type: .regular, size: 8)
        self.firstTeamNameLabel.font = .roboto(type: .regular, size: 10)
        self.secondTeamNameLabel.font = .roboto(type: .regular, size: 10)
        self.timeLabel.font = .roboto(type: .bold, size: 8)
        
        self.timeLabelView.layer.masksToBounds = true
        self.timeLabelView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        self.timeLabelView.layer.cornerRadius = 16
        self.containerView.layer.cornerRadius = 16
    }
    
    func setupDate(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.locale = .autoupdatingCurrent
        let matchDate = Calendar.current.startOfDay(for: date)
        let currentDate = Calendar.current.startOfDay(for: Date())
        let days = Calendar.current.dateComponents([.day], from: currentDate, to: matchDate)
        switch days.day {
        case 0:
            dateFormatter.dateFormat = "HH:mm"
            self.timeLabel.text = "Hoje, \(dateFormatter.string(from: date))"
        case 1:
            dateFormatter.dateFormat = "HH:mm"
            self.timeLabel.text = "Amanhã, \(dateFormatter.string(from: date))"
        default:
            dateFormatter.dateFormat = "dd/MM HH:mm"
            self.timeLabel.text = dateFormatter.string(from: date)
        }
    }
    
    func setupCell(match: Matches) {
        if match.status == "running" {
            self.timeLabel.text = "AGORA"
        } else if let date = match.date {
            self.setupDate(date: date)
        }
        
        let firstTeam = match.opponents[0].opponent
        let secondTeam = match.opponents[1].opponent
        
        self.leagueNameLabel.text = match.league.name
        self.leagueImageView.kf.setImage(with: match.league.imageUrl)
        self.firstTeamNameLabel.text = firstTeam.name
        self.secondTeamNameLabel.text = secondTeam.name
        
        if let imageUrl = firstTeam.imageUrl {
            self.firstTeamImageView.kf.setImage(with: imageUrl)
        } else {
            self.firstTeamImageView.image = UIImage(named: "noteam")
        }
        
        if let imageUrl = secondTeam.imageUrl {
            self.secondTeamImageView.kf.setImage(with: imageUrl)
        } else {
            self.secondTeamImageView.image = UIImage(named: "noteam")
        }
    }
}
