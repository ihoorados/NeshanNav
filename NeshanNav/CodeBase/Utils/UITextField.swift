//
//  UITextField.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation

extension UITextField {

enum Direction {
    case Left
    case Right
}

// add image to textfield
func withImage(direction: Direction, image: UIImage, colorSeparator: UIColor, colorBorder: UIColor){
    
    let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    mainView.layer.cornerRadius = 5

    let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    view.backgroundColor = .systemBackground
    view.clipsToBounds = true
    view.layer.cornerRadius = 25
    view.layer.borderWidth = CGFloat(1.5)
    view.layer.borderColor = colorBorder.cgColor
    mainView.addSubview(view)

    let imageView = UIImageView(image: image)
    imageView.tintColor = colorSeparator
    imageView.contentMode = .scaleAspectFit
    imageView.frame = CGRect(x: 13.0, y: 13.0, width: 24, height: 24)
    view.addSubview(imageView)

    let seperatorView = UIView()
    seperatorView.backgroundColor = colorSeparator
    mainView.addSubview(seperatorView)

    if(Direction.Left == direction){ // image left
        seperatorView.frame = CGRect(x: 50, y: 0, width: 0, height: 50)
        self.leftViewMode = .always
        self.leftView = mainView
    } else { // image right
        seperatorView.frame = CGRect(x: 0, y: 0, width: 0, height: 50)
        self.rightViewMode = .always
        self.rightView = mainView
    }

    self.layer.borderColor = colorBorder.cgColor
    self.layer.borderWidth = CGFloat(1.0)
    self.layer.cornerRadius = 5
}

}
