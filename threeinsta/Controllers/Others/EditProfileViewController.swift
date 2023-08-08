//
//  EditProfileViewController.swift
//  InstaClone
//
//  Created by Kuanish on 18.07.2023.
//

import UIKit

struct EditProfileModel {
    let label : String
    let placeholder: String
    var value: String?
}

class EditProfileViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero,
                                    style: .grouped)
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        return tableView
    }()
    
    private var models = [[EditProfileModel]]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        tableView.tableFooterView = createTableHeaderView()
        configureModel()

        tableView.dataSource = self
        tableView.delegate = self
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain , target: self, action: #selector(cancelButton))
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    private func createTableHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 50, width: view.width, height:view.height/4).integral) //возвращает наименьший прямоугольник при делении
        let size = header.height/1.5
        let profilePhoto = UIButton(frame: CGRect(x: (view.width-size)/2, y: (header.height-size)/2 , width: size, height: size))
        header.addSubview(profilePhoto)
        profilePhoto.layer.masksToBounds = true
        profilePhoto.layer.cornerRadius = size/2.0
        profilePhoto.addTarget(self, action: #selector(tappedProfilePhoto), for: .touchUpInside)
        profilePhoto.setImage(UIImage(named: "Profile"), for: .normal)
        profilePhoto.layer.borderWidth = 1
        profilePhoto.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        return header
    }
    private func configureModel() {
        let sectionLabel = ["Name" , "Username" , "Bio"]
        var oneSection = [EditProfileModel]()
        for label in sectionLabel {
            let model = EditProfileModel(label: label, placeholder: "Enter \(label)...", value: nil)
            oneSection.append(model)
        }
        models.append(oneSection)

        let sectionTwoLabel = ["Email" , "Gender" , "Phone"]
        var twoSection = [EditProfileModel]()
        for label in sectionTwoLabel {
            let model = EditProfileModel(label: label, placeholder: "Enter \(label)...", value: nil)
            twoSection.append(model)
        }
        models.append(twoSection)
    }

    
    @objc private func tappedProfilePhoto() {
        
    }
    
    @objc private func saveButton() {
        
    }
    
    @objc private func cancelButton() {
        navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 0 else {
            return nil
        }
        return "Personal Info"
    }
    
    @objc private func changeProfilePicture() {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Change Picture", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default , handler: { tapped in
            print("openned camera")
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose Photo", style: .default , handler: { tapped in
            print("choose photo")
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(actionSheet, animated: true)
    }
}
extension EditProfileViewController: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier , for: indexPath) as! FormTableViewCell
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
}
extension EditProfileViewController : FormTableViewCellDelegate {
    func formTableViewCell(_ cell: FormTableViewCell, updateFiled value: String?) {
        print("field update to \(value ?? "nil")")
    }
}

