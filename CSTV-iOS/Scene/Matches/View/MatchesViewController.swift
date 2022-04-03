//
//  MatchesViewController.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import UIKit

class MatchesViewController: UIViewController, ViewModelBindable {
    @IBOutlet weak var matchesLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: MatchesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupElements()
        self.setupTableView()
        self.setupRefresh()
    }
    
    func bindViewModel() {
        self.viewModel?.matches.addAndNotify(observer: self, observerBlock: { [weak self] _ in
            self?.tableView.reloadData()
            self?.tableView.refreshControl?.endRefreshing()
        })
        self.viewModel?.finishLoading.addAndNotify(observer: self, observerBlock: { [weak self] stop in
            self?.stopAnimating(stop: stop)
        })
    }
    
    func setupTableView() {
        self.tableView.register(UINib(nibName: "MatchesTableViewCell", bundle: nil), forCellReuseIdentifier: "matchesCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func setupElements() {
        self.matchesLabel.font = .roboto(type: .medium, size: 32)
    }
    
    func stopAnimating(stop: Bool) {
        if stop {
            self.activityIndicator.stopAnimating()
        }
    }
    
    func setupRefresh() {
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
    }
    
    @objc private func refresh() {
        self.viewModel?.refreshMatches()
    }
}

extension MatchesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.matches.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let match = self.viewModel?.matches.value[indexPath.row] else { return UITableViewCell() }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "matchesCell", for: indexPath) as? MatchesTableViewCell {
            cell.setupCell(match: match)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewModel?.pagination(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let match = self.viewModel?.matches.value[indexPath.row] else { return }
        self.viewModel?.goToDetails(match: match)
    }
}
