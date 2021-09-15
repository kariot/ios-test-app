//
//  ViewController.swift
//  Test App
//
//  Created by Matajar on 14/09/21.
//

import UIKit

class UsersListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var addUserButton: UIButton!
    @IBOutlet weak var usersTableView: UITableView!
    var users = [ModelUser]()
    override func viewDidLoad() {
        super.viewDidLoad()
        users = RealmHelpers.getUsers()
        initTableView()
        initUI()
    }
    private func initUI(){
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 24, weight: .bold)
        ]
        addUserButton.setRoundedCorners()
        NotificationCenter.default.addObserver(self, selector: #selector(didAddNewUser), name: .didAddNewUser, object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Users";
    }
    @objc func didAddNewUser(){
        users = RealmHelpers.getUsers()
        self.usersTableView.reloadData()
    }
    private func initTableView() {
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersTableView.contentInset.bottom = 100
        usersTableView.register(UINib.init(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell
        cell.setData(user: users[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc  = UserDetailsViewController.getInstance(user: users[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    @IBAction func didTapAddUser(_ sender: Any) {
        performSegue(withIdentifier: "registerSegue", sender: self)
    }
}

