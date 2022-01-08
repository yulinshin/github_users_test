//
//  UserDetialViewController.swift
//  GitHubUserList
//
//  Created by yulin on 2022/1/7.
//

import UIKit

class UserDetailViewController: UIViewController {


    enum UserCatalog {
        case userLogin
        case userName
        case userEmail
        case userBio
        case publicRepos
        case publicGists
        case followers
        case following
    }

    private var cellArray: [UserCatalog] = [.userLogin, .userName, .userEmail, .userBio, .following, .followers, .publicGists, .publicRepos]

    private var avatarImageView: UIImageView = {
        var imageView = UIImageView()
        return imageView
    }()

    private var userInfoTableView: UITableView = {
        var table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }()
    private var viewModel: UserDetailViewModel?


    convenience init(userLogin: String) {
        self.init()
        let viewModel = UserDetailViewModel(userLogin: userLogin)
        self.viewModel = viewModel
    }

    deinit {
        print("DetialVC Dead")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpImage()
        userInfoTableView.delegate = self
        userInfoTableView.dataSource = self
        // Do any additional setup after loading the view.
    }


    private func setUpUI(){
        view.backgroundColor = .systemBackground
        view.addSubview(avatarImageView)
        view.addSubview(userInfoTableView)

        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        userInfoTableView.translatesAutoresizingMaskIntoConstraints = false

        avatarImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        avatarImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        userInfoTableView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10).isActive = true
        userInfoTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        userInfoTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        userInfoTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true

    }

    private func setUpImage() {
        self.viewModel?.userAvatarUrl.bind(listener: { [weak self] url in
                self?.avatarImageView.loadImage(url)
        })
    }
}

extension UserDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return cellArray.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = userInfoTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)



        if let textLabel = cell.textLabel {


                switch self.cellArray[indexPath.row] {

                case .userLogin:

                    self.viewModel?.userLogin.bind(listener: { login in
                        textLabel.text = "login: \(login)"
                    })

                case .userName:

                    self.viewModel?.userName.bind(listener: { name in
                        textLabel.text = "name: \(name)"
                    })

                case .userEmail:

                    self.viewModel?.userEmail.bind(listener: { email in
                        textLabel.text = "email: \(email)"
                    })

                case .userBio:

                    self.viewModel?.userBio.bind(listener: { userBio in
                        textLabel.text = "userBio: \(userBio)"
                    })

                case .publicRepos:

                    self.viewModel?.publicRepos.bind(listener: { publicRepos in
                        textLabel.text = "publicRepos: \(publicRepos)"
                    })

                case .publicGists:

                    self.viewModel?.publicGists.bind(listener: { publicGists in
                        textLabel.text = "publicGists: \(publicGists)"
                    })

                case .followers:

                    self.viewModel?.followers.bind(listener: { followers in
                        textLabel.text = "followers: \(followers)"
                    })

                case .following:

                    self.viewModel?.following.bind(listener: { following in
                        textLabel.text = "following: \(following)"
                    })
                }

        }
        return cell
    }
}
