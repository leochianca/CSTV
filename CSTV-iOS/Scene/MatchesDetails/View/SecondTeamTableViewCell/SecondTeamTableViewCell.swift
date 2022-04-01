//
//  SecondTeamTableViewCell.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import UIKit

class SecondTeamTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var realNameLabel: UILabel!
    @IBOutlet weak var playerPictureImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupElements()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.playerPictureImageView.image = nil
        self.nicknameLabel.text?.removeAll()
        self.realNameLabel.text?.removeAll()
    }
    
    func setupElements() {
        self.containerView.layer.masksToBounds = true
        self.containerView.layer.cornerRadius = 16
        self.containerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        
        self.playerPictureImageView.layer.cornerRadius = 8
        self.playerPictureImageView.kf.setImage(with: URL(string: "https://media.istockphoto.com/vectors/man-avatar-profile-male-face-silhouette-or-icon-isolated-on-white-vector-id1142192548?k=20&m=1142192548&s=612x612&w=0&h=cJkeszGQom2gYCSRlJO9e5yis2NlHBrzu2B9Zr9B6TI="))
        
        self.nicknameLabel.text = "Unknown"
        self.realNameLabel.text = "Unknown"
    }
    
    func setupCell(team: Teams, index: Int) {
        if let firstName = team.players[index].firstName, let lastName = team.players[index].lastName {
            self.realNameLabel.text = "\(firstName) \(lastName)"
        }
        
        self.nicknameLabel.text = team.players[index].nickname
        
        if let imageUrl = team.players[index].imageUrl {
            self.playerPictureImageView.kf.setImage(with: imageUrl)
        }
    }
}
