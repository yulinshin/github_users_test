//
//  ViewController.swift
//  GitHubUserList
//
//  Created by yulin on 2022/1/7.
//

import UIKit
import MJRefresh

class UserListViewController: UIViewController {

    var tableView: UITableView = {
        var table = UITableView()
        let nib = UINib(nibName: UserListTableViewCell.identifier, bundle: nil)
        table.register(nib, forCellReuseIdentifier: UserListTableViewCell.identifier)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserListTableViewCell.identifier, for: indexPath) as? UserListTableViewCell else { return UITableViewCell() }
        let viewModel = viewModel.list[indexPath.row]

        viewModel.login.bind { login in
            cell.userLoginLabel.text = login
            }
        viewModel.isSiteAdmin.bind { isSiteAdmin in
            cell.isAdminLabel.text = "isAdmin: \(isSiteAdmin)"
        }
        viewModel.avatarUrl.bind { url in
            cell.userImageView.loadImage(viewModel.avatarUrl.value)
            }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let useLogin = viewModel.list[indexPath.row].login.value
        let viewController = UserDetailViewController(userLogin: useLogin)

        self.navigationController?.pushViewController(viewController, animated: true)

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }


}
