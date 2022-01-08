//
//  NavigationHeader.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/8/22.
//

import UIKit

protocol NavigationHeaderDelegate: AnyObject {
    func didClickBack()
}

class NavigationHeader: UIView {

    @IBOutlet private var container: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    private weak var delegate: NavigationHeaderDelegate?
    @IBOutlet private weak var backImageView: UIImageView!
    @IBOutlet private weak var backButtonTrigger: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
   
    func initSubviews() {
        _ = R.nib.navigationHeader(owner: self)
        container.frame = bounds
        addSubview(container)
    }
    
    func bindData(title: String, delegate: NavigationHeaderDelegate?) {
        let backHidden = delegate == nil
        titleLabel.text = title
        self.delegate = delegate
        backImageView.isHidden = backHidden
        backButtonTrigger.isEnabled = !backHidden
    }
    
    @IBAction private func backButtonDidClicked(_ sender: UIButton) {
        delegate?.didClickBack()
    }
    
    
}
