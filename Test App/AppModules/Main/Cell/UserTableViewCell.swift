//
//  UserTableViewCell.swift
//  Test App
//
//  Created by Matajar on 14/09/21.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        userImageView.setRoundedCorners()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setData(user : ModelUser) {
        userNameLabel.text = user.userName
        userEmailLabel.text = user.userEmail
        if !user.userPhoto.isEmpty {
            userImageView.image = FileUtils.loadImageFromDiskWith(fileName: user.userPhoto)
        }
    }
}
