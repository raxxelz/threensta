//
//  FormTableViewCell.swift
//  threeinsta
//
//  Created by Kuanish on 28.07.2023.
//

import UIKit

class FormTableViewCell: UITableViewCell {
    
    static let identifier = "FormTableViewCell"
    
    public weak var delegate: FormTableViewCellDelegate?
    
    private let formLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    private let field: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        return field
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(field)
        contentView.addSubview(formLabel)
        selectionStyle = .none
        field.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: EditProfileModel) {
        formLabel.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value
    }
    //Метод  переопределен для сброса содержимого ячейки перед повторным использованием. Он очищает текст метки, местозаполнитель и значение поля.
    override func prepareForReuse() {
        super.prepareForReuse()
        formLabel.text = nil
        field.placeholder = nil
        field.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        formLabel.frame = CGRect(x: 5, y: 0, width: contentView.width/3, height: contentView.height)
        field.frame = CGRect(x:formLabel.right + 5, y: 0, width: contentView.width-10-formLabel.width, height: contentView.height)

    }
}
extension FormTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.formTableViewCell(self, updateFiled: textField.text)
        textField.resignFirstResponder()
        return true
    }
}
protocol FormTableViewCellDelegate: AnyObject {
    func formTableViewCell(_ cell: FormTableViewCell , updateFiled value: String?)
}
