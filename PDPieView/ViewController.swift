//
//  ViewController.swift
//  PDPieView
//
//  Created by Pardn on 2023/5/3.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		let vw = UIScreen.main.bounds.width;
		let pieView = PDPieView(x: (vw - 200) / 2, y: 100, width: 200);
		view.addSubview(pieView);

		pieView
			.border(color: .purple)
			.border(W: 10)
			.show(75);
	}


}
class PDPieView: UIView {

	var bodyWidth: CGFloat = 200;
	var borderWidth: CGFloat = 20;
	var progressColor: UIColor = .red;
	var lefvView: UIView?
	var rightView: UIView?

	convenience init(x: CGFloat, y: CGFloat, width: CGFloat) {
		self.init(x, y, width, width);
		bodyWidth = width;
		self.addView(width)
	};

	func border(color: UIColor) -> PDPieView {
		progressColor = color;
		return self;
	}

	func border(W: CGFloat) -> PDPieView {
		borderWidth = W;
		self.subviews.forEach { e in
			e.removeFromSuperview();
		};

		guard let rightView = rightView, let lefvView = lefvView else { return self; };

		self.child([
				UIView(bodyWidth / 2, 0, bodyWidth / 2, bodyWidth)
					.child([
						rightView
					])
					.clip(view: true),
				UIView(0, 0, bodyWidth / 2, bodyWidth)
					.child([
						lefvView
					])
					.clip(view: true),
				UIView(borderWidth, borderWidth, bodyWidth - borderWidth * 2, bodyWidth - borderWidth * 2)
					.bg(clr: .white)
					.radius((bodyWidth - borderWidth * 2) / 2)
					.clip(view: true)
			])
			.radius(bodyWidth / 2)
			.clip(view: true)
			.bg(clr: progressColor)
			.end();
		return self;
	};

	private func addView(_ bodyWidth: CGFloat) {
		rightView = UIView(-bodyWidth / 2, 0, bodyWidth, bodyWidth)
			.bg(clr: .clear)
			.layer([
				{
				  let this = CAGradientLayer();
				  this.frame = CGRect(100, 0, 100, 200);
				  this.backgroundColor = (self.backgroundColor ?? .lightGray).cgColor;
				  this.startPoint = CGPoint(x: 0, y: 0.5);
				  this.endPoint = CGPoint(x: 1, y: 0.5);
				  return this;
				}()
			]);
		lefvView = UIView(0, 0, bodyWidth, bodyWidth)
			.bg(clr: .clear)
			.layer([
				{
				  let this = CAGradientLayer();
				  this.frame = CGRect(0, 0, 100, 200);
				  this.backgroundColor = (self.backgroundColor ?? .lightGray).cgColor;
				  this.startPoint = CGPoint(x: 0, y: 0.5);
				  this.endPoint = CGPoint(x: 1, y: 0.5);
				  return this
				}()
			]);

		guard let rightView = rightView, let lefvView = lefvView else { return; };

		self
			.child([
				UIView(bodyWidth / 2, 0, bodyWidth / 2, bodyWidth)
					.child([
						rightView
					])
					.clip(view: true),
				UIView(0, 0, bodyWidth / 2, bodyWidth)
					.child([
						lefvView
					])
					.clip(view: true),
				UIView(borderWidth, borderWidth, bodyWidth - borderWidth * 2, bodyWidth - borderWidth * 2)
					.bg(clr: .white)
					.radius((bodyWidth - borderWidth * 2) / 2)
					.clip(view: true)
			])
			.radius(bodyWidth / 2)
			.clip(view: true)
			.bg(clr: progressColor)
			.end();
	};

	func show(_ percent: CGFloat) {
		let angle: CGFloat = percent / 100 * 360;
		let sec1: CGFloat = angle > 180 ? 1 : (angle - 180) / 180;
		let sec2: CGFloat = angle > 180 ? ((angle - 180) / 180) : 1;

		guard let rightView = rightView, let lefvView = lefvView else { return; };

		UIViewPropertyAnimator(duration: 1.2 * sec1, curve: .easeIn) {
			rightView
				.rotate(angle: angle > 180 ? 180 : angle)
				.end();
		}.startAnimation()
		Timer.scheduledTimer(withTimeInterval: 1.21, repeats: false) { _ in
			if (angle <= 180) { return; };
			UIViewPropertyAnimator(duration: 1.2 * sec2, curve: .easeOut) {
				lefvView
					.rotate(angle: angle > 180 ? angle - 180 : 0)
					.end();
			}.startAnimation();
		};
	};
};
