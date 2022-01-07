//
//  UserDetailViewModel.swift
//  GitHubUserList
//
//  Created by yulin on 2022/1/7.
//

import Foundation
import AVFoundation

class UserDetailViewModel {

    var userLogin = Box("-")
    var userName = Box("-")
    var userAvatarUrl = Box("-")
    var userEmail = Box("-")
    var userBio = Box("-")
    var publicRepos = Box(0)
    var publicGists = Box(0)
    var followers = Box(0)
    var following = Box(0)

    private var userManger = GetUserManger()

    init(userLogin: String) {
        fetchUser(userLogin: userLogin)
    }


    func fetchUser(userLogin: String){

        userManger.getUserInfo(userLogin: userLogin) { result in

            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                self.userLogin.value = user.login
                self.userName.value = user.userName ?? "-"
                self.userAvatarUrl.value = user.avatarUrl
                self.userBio.value = user.userBio ?? "-"
                self.publicRepos.value = user.publicRepos ?? 0
                self.publicGists.value = user.publicGists ?? 0
                self.followers.value = user.followers ?? 0
                self.following.value = user.following ?? 0
                }
            case .failure(let error):
                print(error)

            }
        }
    }
}
