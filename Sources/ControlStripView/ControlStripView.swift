// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

public class ControlStripView: UIScrollView {
    public var spacing: CGFloat = 8 { didSet{ setNeedsLayout() }}
    private let stackView = UIStackView()
    private var items: [UIView] = []
    
    var axis: NSLayoutConstraint.Axis = .horizontal {
        didSet {
            stackView.axis = axis
            setNeedsLayout()
        }
    }
    
    public init(axis: NSLayoutConstraint.Axis = .horizontal) {
        super.init(frame: .zero)
        self.axis = axis
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        stackView.axis = axis
        stackView.alignment = .fill
        stackView.distribution = .fill
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    public func addItem(view: UIView) {
        items.append(view)
        stackView.addArrangedSubview(view)
    }
    
    public func removeItem(view: UIView) {
        if items.contains(view) {
            stackView.removeArrangedSubview(view)
            view.removeFromSuperview()
            items.removeAll(where: { $0 == view })
        }
    }
    
    public func removeAllItems() {
        stackView.arrangedSubviews.forEach({
            self.stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        })
        items.removeAll()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        guard !items.isEmpty else { return }
        
        let itemsSize = items.map({ axis == .horizontal ? $0.frame.size.width : $0.frame.size.height }).reduce(0, +)
        let itemsSpacing = CGFloat(items.count - 1) * spacing
        let total = itemsSize + itemsSpacing
        
        // Scroll the items
        if frame.size.width < total {
            if axis == .horizontal {
                contentSize.width = total
                contentSize.height = frame.size.height
            } else if axis == .vertical {
                contentSize.width = frame.size.width
                contentSize.height = total
            }
            stackView.spacing = spacing
        } else { // layout with equal spacing
            contentSize.width = frame.size.width
            let space = (frame.size.width - itemsSize) / CGFloat(items.count - 1)
            stackView.spacing = space
        }
    }
}
