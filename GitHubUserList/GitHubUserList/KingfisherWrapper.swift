//
//  KingfisherWrapper.swift
//  GitHubUserList
//
//  Created by yulin on 2022/1/7.
//

import UIKit
import Kingfisher

extension UIImageView {

    func loadImage(_ urlString: String?, placeHolder: UIImage? = nil) {

        guard urlString != nil else { return }

        let url = URL(string: urlString!)

        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, placeholder: placeHolder)

    }
}
