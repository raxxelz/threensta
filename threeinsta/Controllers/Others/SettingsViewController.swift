//
//  SettingsViewController.swift
//  InstaClone
//
//  Created by Kuanish on 18.07.2023.
//

import UIKit
import SafariServices

struct SettingTableViewCellModel {
    let title: String
    let handler: (() -> Void)
}


final class SettingsViewController: UIViewController {
    
    private let tabelView: UITableView = {
        let tableView = UITableView(frame: .zero,
                                    style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cells")
        return tableView
    }()
    
    private var date = [[SettingTableViewCellModel]]() // массив из ячеек
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.addSubview(tabelView)
        view.backgroundColor = .systemBackground
        tabelView.dataSource = self
        tabelView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabelView.frame = view.bounds
    }
    private func configureModels() {
        date.append([
            SettingTableViewCellModel(title: "Edit Profile") { [weak self] in
                self?.editProile()
            
            },
            SettingTableViewCellModel(title: "Invite Friends") { [weak self] in
                self?.inviteFriends()
            },
            SettingTableViewCellModel(title: "Save Original Posts") { [weak self] in
                self?.saveOriginPosts()
            }
        ])
        date.append([
            
            SettingTableViewCellModel(title: "Creator` Insta Acc") { [weak self] in
                self?.openLinks(type: .instagram)
                
            },
            SettingTableViewCellModel(title: "Creator` Spotify") { [weak self] in
                self?.openLinks(type: .spotify)
            }
        ])
        
    
        date.append([
            SettingTableViewCellModel(title: "Log out") { [weak self] in
                self?.tappedLogOut()
            }
        ])
    }
    
    enum CreatorsLinks {
        case spotify
        case instagram
        
    }
    
    
    private func editProile() {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    private func inviteFriends() {
        
    }
    
    private func saveOriginPosts() {
        
    }
    
    private func openLinks(type : CreatorsLinks) {
        let linksString: String
        switch type {
        case .instagram : linksString = "https://instagram.com/poulixiz?igshid=OGQ5ZDc2ODk2ZA%3D%3D"
        case .spotify : linksString = "https://open.spotify.com/user/s3xztoeyvdzixrg6xftlktrt8?si=5a96be388a714240"
        }
        guard let url = URL(string: linksString) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    
    
    private func tappedLogOut() {
        let alert = UIAlertController(title: "Log out",
                                      message: "Are you sure?",
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "No",
                                      style: .default ,
                                      handler: nil))
        present(alert , animated: true)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive ) { logOut in
            DispatchQueue.main.async {
                AuthManager.shared.logOut { succes in
                    if succes {
                        // успешный выход из аккаунта
                        let loginVC = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: true) {
                            self.navigationController?.popViewController(animated: true)
                            self.tabBarController?.selectedIndex = 0
                        }
                    }
                }
            }
        }
        )}
}
            
                                      
            
extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return date[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells" , for: indexPath)
        cell.textLabel?.text = date[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    //Функция чтобы убрать подсветку при выборе секции
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = date[indexPath.section][indexPath.row]
        model.handler()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return date.count
    }
    
}
