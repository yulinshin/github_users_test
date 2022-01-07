//
//  ViewController.swift
//  GitHubUserList
//
//  Created by yulin on 2022/1/7.
//

import UIKit
import Kingfisher
import MJRefresh
import CoreAudio

class UserListViewController: UIViewController {

    var tableView: UITableView = {
        var table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }()

    private let header = MJRefreshNormalHeader()
    private let footer = MJRefreshAutoNormalFooter()
    private let viewModel = UserListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.didUpdateData = { [weak self] in
            self?.tableView.reloadData()
            self?.tableView.mj_header?.endRefreshing()
            self?.tableView.mj_footer?.endRefreshing()
        }
        viewModel.fetchUserList()
        setupHeaderFooter()
    }

    private func setupTableView(){
        tableView.frame = self.view.frame
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupHeaderFooter() {

        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        self.tableView.mj_header = header

        footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        self.tableView.mj_footer = footer
    }

    @objc private func headerRefresh() {
        viewModel.resetList()
    }
    @objc private func footerRefresh() {
        viewModel.fetchUserList()
    }
}


extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let viewModel = viewModel.list[indexPath.row]
        if let textLabel = cell.textLabel,
           let imageView = cell.imageView {
            viewModel.login.bind { login in
                viewModel.isSiteAdmin.bind { isSiteAdmin in
                    textLabel.text = "\(login), isAdmin: \(isSiteAdmin)"
                }
            }
            viewModel.avatarUrl.bind { url in
                imageView.loadImage(viewModel.avatarUrl.value)
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let useLogin = viewModel.list[indexPath.row].login.value
        let viewController = UserDetailViewController(userLogin: useLogin)

        self.navigationController?.pushViewController(viewController, animated: true)

    }


}
