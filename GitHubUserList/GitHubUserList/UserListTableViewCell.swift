//
//  UserListTableViewCell.swift
//  GitHubUserList
//
//  Created by yulin on 2022/1/8.
//

import UIKit

class UserListTableViewCell: UITableViewCell {

    @IBOutlet weak var isAdminLabel: UILabel!
    @IBOutlet weak var userLoginLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!

    static var identifier = "UserListTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }


}
