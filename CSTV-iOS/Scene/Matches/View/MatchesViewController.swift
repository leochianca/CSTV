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
    }
    
    func bindViewModel() {
        self.viewModel?.matches.addAndNotify(observer: self, observerBlock: { matches in
            print("MATCHES: \(matches)")
        })
    }
}
