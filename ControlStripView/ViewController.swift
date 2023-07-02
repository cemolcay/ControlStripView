//
//  ViewController.swift
//  ControlStripView
//
//  Created by Cem Olcay on 7/2/23.
//

import UIKit

class ViewController: UIViewController {
    let controlStrip = ControlStripView()
    let controlStripHeight: CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(controlStrip)
        controlStrip.translatesAutoresizingMaskIntoConstraints = false
        controlStrip.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        controlStrip.heightAnchor.constraint(equalToConstant: controlStripHeight).isActive = true
        controlStrip.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        controlStrip.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        
        // scrolling on portrait mode
        // equal spacing on landscape mode
        for i in 0..<6 {
            controlStrip.addItem(view: randomControlElement(index: i))
        }
    }
    
    func randomControlElement(index: Int) -> UIView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        let label = UILabel()
        label.text = "Item \(index + 1)"
        let button = UIButton(type: .system)
        button.setTitle("Button \(index + 1)", for: .normal)
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(button)
        return stack
    }
}
