//
//  UserListViewModel.swift
//  GitHubUserList
//
//  Created by yulin on 2022/1/7.
//

import Foundation
import UIKit

class UserListViewModel {

    var list = [UserListCellViewModel]()
    var userManger = GetUserManger()
    var didUpdateData: (() -> Void )?

    func fetchUserList() {
        userManger.getUserList { result in
            switch result {

            case .success(let users):
                users.forEach { user in
                    let userViewModel = UserListCellViewModel(login: user.login, avatarUrl: user.avatarUrl, isSiteAdmin: user.siteAdmin)
                    self.list.append(userViewModel)
                }

                DispatchQueue.main.async {
                    self.didUpdateData?()
                }

            case .failure(let error):
                print(error)
            }
        }
    }

    func resetList() {
        list.removeAll()
        userManger.resetPaging()
        fetchUserList()
    }

}

class UserListCellViewModel {

    var login = Box("")
    var avatarUrl = Box("")
    var isSiteAdmin = Box(false)

    init(login: String, avatarUrl: String, isSiteAdmin: Bool) {

        self.login.value = login
        self.avatarUrl.value = avatarUrl
        self.isSiteAdmin.value = isSiteAdmin

    }

}
