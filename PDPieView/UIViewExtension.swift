/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation;
import UIKit;

public extension CGRect {

	init(_ point: CGPoint,_ size: CGSize) { self.init(origin: point, size: size); };
	init(_ x: CGFloat,_ y: CGFloat,_ w: CGFloat,_ h: CGFloat) { self.init(x: x, y: y, width: w, height: h); };
};

public extension UIView {

	@objc convenience init(_ x: CGFloat,_ y: CGFloat,_ w: CGFloat,_ h: CGFloat) { self.init(frame: CGRect(x, y, w, h)); };

	var bg: UIColor { get { return self.backgroundColor ?? .clear } set { self.backgroundColor = newValue; } };

	@objc func bg(clr: UIColor) -> UIView { self.bg = clr; return self; };

	@objc func radius(_ val: CGFloat) -> UIView { self.layer.cornerRadius = val; return self; };

	func clip(view val: Bool) -> UIView { self.clipsToBounds = val; return self; };

	func layer(_ layers: [CALayer]) -> UIView { layers.forEach { e in self.layer.addSublayer(e); }; return self; };

	@objc func child(_ views: [UIView]) -> UIView { views.forEach { view in self.addSubview(view); }; return self; };

	func end() {};

	func rotate(angle: CGFloat) -> UIView {
		let angle = angle / 180.0 * CGFloat.pi
		let rotation = self.transform.rotated(by: angle)
		self.transform = rotation
		return self;
	};
};

