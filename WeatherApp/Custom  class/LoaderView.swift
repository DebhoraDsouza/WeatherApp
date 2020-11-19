//
//  loader.swift
//  WeatherApp
//
//  Created by Debhora D Souza on 17/11/20.
//

import UIKit

class LoaderView: UIView {
    
    
    @IBOutlet var mContainerView: UIView!
    
    @IBOutlet weak var mMainView: MisDesignView!
    @IBOutlet weak var mLabel: UILabel!
    
    
    @IBOutlet weak var mActivityIndicator: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("LoaderView", owner: self, options: nil)
        addSubview(mContainerView)
        mContainerView.frame = self.bounds
        mContainerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
