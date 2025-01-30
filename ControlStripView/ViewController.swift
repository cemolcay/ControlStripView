//
//  ViewController.swift
//  ControlStripView
//
//  Created by Cem Olcay on 7/2/23.
//

import UIKit

class ItemView: UIView, ControlStripViewItem {
    var centerInStripView: Bool = false
    var hugStripView: Bool = false
    var index: Int = 0
    
    init(frame: CGRect = .zero, index: Int = 0) {
        super.init(frame: frame)
        self.index = index
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        let stack = UIStackView()
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        stack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .fill
        stack.backgroundColor = .lightGray
        let label = UILabel()
        label.text = "Item \(index + 1)"
        let button = UIButton(type: .system)
        button.setTitle("Button \(index + 1)", for: .normal)
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(button)
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var hStrip: ControlStripView?
    @IBOutlet weak var vStrip: ControlStripView?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hStrip?.axis = .horizontal
        vStrip?.axis = .vertical
        
        for i in 0..<6 {
            // horizontal
            let hItem = ItemView(frame: CGRect(x: 0, y: 0, width: 200, height: 100), index: i)
            hItem.centerInStripView = false
            hItem.hugStripView = true
            hStrip?.addItem(hItem)
            // vertical
            let vItem = ItemView(frame: CGRect(x: 0, y: 0, width: 200, height: 100), index: i)
            vItem.centerInStripView = true
            vItem.hugStripView = false
            vStrip?.addItem(vItem)
        }
    }
}
