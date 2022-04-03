//
//  MatchesDetailsViewController.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import UIKit

class MatchesDetailsViewController: UIViewController, ViewModelBindable {
    @IBOutlet weak var vsLabel: UILabel!
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var firstTeamImageView: UIImageView!
    @IBOutlet weak var secondTeamImageView: UIImageView!
    @IBOutlet weak var firstTeamNameLabel: UILabel!
    @IBOutlet weak var secondTeamNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var firstTeamTableView: UITableView!
    @IBOutlet weak var secondTeamTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imagesStackView: UIStackView!
    @IBOutlet weak var teamsNameStackView: UIStackView!
    @IBOutlet weak var firstTableViewTrailing: NSLayoutConstraint!
    @IBOutlet weak var secondTableViewLeading: NSLayoutConstraint!
    
    var viewModel: MatchesDetailsViewModel?
    var firstCellIndex: Int = 0
    var secondCellIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupElements()
    }
    
    func bindViewModel() {
        self.viewModel?.teams.addAndNotify(observer: self, observerBlock: { [weak self] teams in
            self?.firstTeamTableView.reloadData()
            self?.firstTeamTableView.refreshControl?.endRefreshing()
            
            self?.secondTeamTableView.reloadData()
            self?.secondTeamTableView.refreshControl?.endRefreshing()
        })
        self.viewModel?.finishLoading.addAndNotify(observer: self, observerBlock: { [weak self] stop in
            self?.stopAnimating(stop: stop)
        })
    }
    
    func setupTableView() {
        let screenWidth = UIScreen.main.bounds.size.width
        
        self.firstTeamTableView.register(UINib(nibName: "FirstTeamTableViewCell", bundle: nil), forCellReuseIdentifier: "firstTeamCell")
        self.firstTeamTableView.delegate = self
        self.firstTeamTableView.dataSource = self
        self.firstTableViewTrailing.constant = screenWidth / 2
        
        self.secondTeamTableView.register(UINib(nibName: "SecondTeamTableViewCell", bundle: nil), forCellReuseIdentifier: "secondTeamCell")
        self.secondTeamTableView.delegate = self
        self.secondTeamTableView.dataSource = self
        self.secondTableViewLeading.constant = screenWidth / 2
    }
    
    func setupElements() {
        self.setupFont()
        
        guard let match = self.viewModel?.match.value else { return }
        if match.status == "running" {
            self.timeLabel.text = "AGORA"
        } else {
            guard let matchDate = match.date else { return }
            let time = DateFormatter.dateString(initialDate: Date(), endDate: matchDate)
            self.timeLabel.text = time
        }
        
        self.leagueNameLabel.text = match.league.name
    }
    
    func setupFont() {
        self.vsLabel.font = .roboto(type: .regular, size: 12)
        self.timeLabel.font = .roboto(type: .bold, size: 12)
        self.leagueNameLabel.font = .roboto(type: .medium, size: 18)
        self.firstTeamNameLabel.font = .roboto(type: .regular, size: 10)
        self.secondTeamNameLabel.font = .roboto(type: .regular, size: 10)
    }
    
    func setupTeamsInfo() {
        guard let teams = self.viewModel?.teams.value else { return }
        if let imageUrl = teams[0].imageUrl {
            self.firstTeamImageView.kf.setImage(with: imageUrl)
        } else {
            self.firstTeamImageView.image = UIImage(named: "noteam")
        }
        
        if let imageUrl = teams[1].imageUrl {
            self.secondTeamImageView.kf.setImage(with: imageUrl)
        } else {
            self.secondTeamImageView.image = UIImage(named: "noteam")
        }
        
        self.firstTeamNameLabel.text = teams[0].name
        self.secondTeamNameLabel.text = teams[1].name
        
        self.imagesStackView.isHidden = false
        self.teamsNameStackView.isHidden = false
        self.timeLabel.isHidden = false
    }
    
    func stopAnimating(stop: Bool) {
        if stop {
            self.setupTeamsInfo()
            self.activityIndicator.stopAnimating()
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.viewModel?.goBack()
    }
}

extension MatchesDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let teams = self.viewModel?.teams.value else { return 0 }
        if teams.count == 2 {
            return 5
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let teams = self.viewModel?.teams.value else { return UITableViewCell() }
        if tableView == self.firstTeamTableView, let cell = tableView.dequeueReusableCell(withIdentifier: "firstTeamCell", for: indexPath) as? FirstTeamTableViewCell {
            if teams[0].players.count >= self.firstCellIndex + 1 {
                cell.setupCell(team: teams[0], index: self.firstCellIndex)
                self.firstCellIndex += 1
            }
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "secondTeamCell", for: indexPath) as? SecondTeamTableViewCell {
            if teams[1].players.count >= self.secondCellIndex + 1 {
                cell.setupCell(team: teams[1], index: self.secondCellIndex)
                self.secondCellIndex += 1
            }
            return cell
        }
        return UITableViewCell()
    }
}
