//
//  ViewController.swift
//  LoadingAsync
//
//  Created by 游宗諭 on 2020/1/8.
//  Copyright © 2020 游宗諭. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		showLoading()
	}
	
	private let queue = DispatchQueue(label: "ViewController")
	var anycancelable: AnyCancellable!
	let vc:UIAlertController = {
		let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
		let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
		loadingIndicator.hidesWhenStopped = true
		loadingIndicator.style = .medium
		loadingIndicator.startAnimating();
		
		alert.view.addSubview(loadingIndicator)
		return alert
	}()
	
	fileprivate func showLoading() {
		let loadTime = (1...3).randomElement()!
		anycancelable =
			Just<Void>(())
				.delay(for: .seconds(loadTime),
					   scheduler: queue)
				.receive(on: RunLoop.main)
				.sink {
					self.dismiss(animated: true, completion: nil)
		}
		
		present(vc, animated: true, completion: nil)
	}
	
	@IBAction func didTapButton(_ sender: UIButton) {
		showLoading()
	}
	
}
