//
//  UserDetailsViewController.swift
//  Test App
//
//  Created by Matajar on 14/09/21.
//

import UIKit

class UserDetailsViewController: BaseViewController {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userPhoneLabel: UILabel!
    @IBOutlet weak var userSignImageView: UIImageView!
    @IBOutlet weak var userNameBottomLabel: UILabel!
    var user : ModelUser?
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    private func initUI(){
        guard let user = user else { return  }
        userImageView.setRoundedCorners()
        userImageView.image = FileUtils.loadImageFromDiskWith(fileName: user.userPhoto)
        userNameLabel.text = user.userName
        userEmailLabel.text = user.userEmail
        userPhoneLabel.text = user.userPhone
        userSignImageView.image = FileUtils.loadImageFromDiskWith(fileName: user.userSign)
        userNameBottomLabel.text = user.userName
    }
    
    class func getInstance(user : ModelUser) -> UserDetailsViewController {
        var vc : UserDetailsViewController
        if #available(iOS 13.0, *) {
            vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "UserDetailsViewController") as! UserDetailsViewController
        } else {
            vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
        }
        vc.user = user
        return vc
    }
    
}
