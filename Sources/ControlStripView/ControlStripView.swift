// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

public class ControlStripView: UIScrollView {
    public var spacing: CGFloat = 8 { didSet{ setNeedsLayout() }}
    private let stackView = UIStackView()
    private var items: [UIView] = []
    
    public init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        stackView.axis = .horizontal
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
        
        let itemsWidth = items.map({ $0.frame.size.width }).reduce(0, +)
        let itemsSpacing = CGFloat(items.count - 1) * spacing
        let total = itemsWidth + itemsSpacing
        
        // Scroll the items
        if frame.size.width < total {
            contentSize.width = total
            stackView.spacing = spacing
        } else { // layout with equal spacing
            contentSize.width = frame.size.width
            let space = (frame.size.width - itemsWidth) / CGFloat(items.count - 1)
            stackView.spacing = space
        }
    }
}
