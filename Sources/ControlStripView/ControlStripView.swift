import UIKit

public protocol ControlStripViewItem: UIView {
    var centerInStripView: Bool { get set }
    var hugStripView: Bool { get set }
}

public class ControlStripView: UIScrollView {
    public var spacing: CGFloat = 8 { didSet{ setNeedsLayout() }}
    private var items: [any ControlStripViewItem] = []
    
    public var axis: NSLayoutConstraint.Axis = .horizontal {
        didSet {
            setNeedsLayout()
        }
    }
    
    public init(axis: NSLayoutConstraint.Axis = .horizontal) {
        super.init(frame: .zero)
        self.axis = axis
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func addItem(_ view: any ControlStripViewItem) {
        items.append(view)
        addSubview(view)
    }
    
    public func removeItem(view: any ControlStripViewItem) {
        if items.contains(where: { $0 == view }) {
            view.removeFromSuperview()
            items.removeAll(where: { $0 == view })
        }
    }
    
    public func removeAllItems() {
        items.forEach({ $0.removeFromSuperview() })
        items.removeAll()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        let spaceCount = CGFloat(items.count - 1)
        
        switch axis {
        case .horizontal:
            let itemsSize = items.reduce(0, { $0 + $1.frame.size.width })
            let space = max(8, (frame.size.width - itemsSize) / spaceCount)
            var x: CGFloat = 0
            for item in items {
                let c = (frame.size.height - item.frame.size.height) / 2.0
                item.frame = CGRect(
                    x: x,
                    y: item.centerInStripView ? c : 0,
                    width: item.frame.size.width,
                    height: item.hugStripView ? frame.size.height : item.frame.size.height)
                x += item.frame.size.width + space
            }
            contentSize = CGSize(width: itemsSize + (space * spaceCount), height: frame.size.height)
        case .vertical:
            let itemsSize = items.reduce(0, { $0 + $1.frame.size.height })
            let space = max(8, (frame.size.height - itemsSize) / spaceCount)
            var y: CGFloat = 0
            for item in items {
                let c = (frame.size.width - item.frame.size.width) / 2.0
                item.frame = CGRect(
                    x: item.centerInStripView ? c : 0,
                    y: y,
                    width: item.hugStripView ? frame.size.width : item.frame.size.width,
                    height: item.frame.size.height)
                y += item.frame.size.height + space
            }
            contentSize = CGSize(width: frame.size.width, height: itemsSize + (space * spaceCount))
        @unknown default:
            return
        }
    }
}
