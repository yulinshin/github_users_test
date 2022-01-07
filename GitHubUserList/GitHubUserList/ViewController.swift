//
//  ViewController.swift
//  GitHubUserList
//
//  Created by yulin on 2022/1/7.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    var tableView: UITableView = {
        var table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame = self.view.bounds
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let textlabel = cell.textLabel,
           let imageView = cell.imageView {
            textlabel.text = "login, isAdmin: True"
            imageView.loadImage("picUrl")
        }
        return cell
    }

}
