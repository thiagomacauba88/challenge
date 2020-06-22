//
//  LoadingConvenience.swift
//  Challenge
//
//  Created by Thiago on 16/06/20.
//  Copyright © 2020 Challenge. All rights reserved.
//

import UIKit

class LoadingConvenience {
    
    static let shared = LoadingConvenience()
    
    private var loadingView: UIView!
    private var window = (UIApplication.shared.delegate as! AppDelegate).window!
    
    static var blurView: UIVisualEffectView {
        
        let effect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: effect)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.alpha = 0.85
        
        return view
    }
    
    static var shadowView: UIView {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.alpha = 0.55
        return view
    }
    
    static var activityIndicator: UIActivityIndicatorView {
        let loading = UIActivityIndicatorView(style: .whiteLarge)
        loading.color = UIColor.purple
        return loading
    }
    
    static var textLoading: UILabel {
        let text = UILabel()
        text.text = ""
        return text
    }
    
    // MARK: - Life Cycle
    init() {
        setupLoadingView()
    }
    
    // MARK: - Misc
    
    func enableFullScreenLoading() {
        //window.addSubview(loadingView)
        UIApplication.shared.keyWindow!.addSubview(loadingView)
    }
    
    func disableFullScreenLoading() {
        loadingView.removeFromSuperview()
    }
    
    private func setupLoadingView() {
        loadingView = UIView()
        loadingView.frame = UIApplication.shared.keyWindow!.frame
        loadingView.startLoading()
    }    
}
