//
//  MatchesDetailsViewController.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import UIKit

class MatchesDetailsViewController: UIViewController, ViewModelBindable {
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var firstTeamImageView: UIImageView!
    @IBOutlet weak var secondTeamImageView: UIImageView!
    @IBOutlet weak var firstTeamNameLabel: UILabel!
    @IBOutlet weak var secondTeamNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var firstTeamTableView: UITableView!
    @IBOutlet weak var secondTeamTableView: UITableView!
    
    var viewModel: MatchesDetailsViewModel?
    var teams: [Teams] = []
    var leagueName: String = ""
    var time: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupElements()
    }
    
    init(teams: [Teams], leagueName: String, time: String) {
        super.init(nibName: nil, bundle: nil)
        self.teams = teams
        self.leagueName = leagueName
        self.time = time
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindViewModel() {}
    
    func setupTableView() {
        self.firstTeamTableView.register(UINib(nibName: "FirstTeamTableViewCell", bundle: nil), forCellReuseIdentifier: "firstTeamCell")
        self.firstTeamTableView.delegate = self
        self.firstTeamTableView.dataSource = self
        
        self.secondTeamTableView.register(UINib(nibName: "SecondTeamTableViewCell", bundle: nil), forCellReuseIdentifier: "secondTeamCell")
        self.secondTeamTableView.delegate = self
        self.secondTeamTableView.dataSource = self
    }
    
    func setupElements() {
        if let imageUrl = self.teams[0].imageUrl {
            self.firstTeamImageView.kf.setImage(with: imageUrl)
        } else {
            self.firstTeamImageView.image = UIImage(named: "noteam")
        }
        
        if let imageUrl = self.teams[1].imageUrl {
            self.secondTeamImageView.kf.setImage(with: imageUrl)
        } else {
            self.secondTeamImageView.image = UIImage(named: "noteam")
        }
        
        self.leagueNameLabel.text = self.leagueName
        self.firstTeamNameLabel.text = self.teams[0].name
        self.secondTeamNameLabel.text = self.teams[1].name
        self.timeLabel.text = self.time
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.viewModel?.goBack()
    }
    
    var index1: Int = 0
    var index2: Int = 0
}

extension MatchesDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.firstTeamTableView, let cell = tableView.dequeueReusableCell(withIdentifier: "firstTeamCell", for: indexPath) as? FirstTeamTableViewCell {
            if self.teams[0].players.count >= self.index1+1 {
                cell.setupCell(team: self.teams[0], index: self.index1)
                self.index1 += 1
            }
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "secondTeamCell", for: indexPath) as? SecondTeamTableViewCell {
            if self.teams[1].players.count >= self.index2+1 {
                cell.setupCell(team: self.teams[1], index: self.index2)
                self.index2 += 1
            }
            return cell
        }
        return UITableViewCell()
    }
}
