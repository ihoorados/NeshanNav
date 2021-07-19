//
//  NTCTAButton.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation
import UIKit

public class NTCTAButton: UIButton {

    let BackgroundLayer = CALayer()
    let MainLayer = CALayer()

    override init (frame: CGRect){
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var bounds: CGRect {
        didSet { updateFrames() }
    }
    
    public override var frame: CGRect {
        didSet { updateFrames() }
    }
    
    
    private func setupUI() {
        backgroundColor = UIColor.clear
        layer.addSublayer(BackgroundLayer)
        layer.addSublayer(MainLayer)
        MainLayer.cornerRadius = 16.0
        layer.cornerRadius = 16.0
        BackgroundLayer.cornerRadius = 16.0
        MainLayer.shadowOpacity = 0.3
        MainLayer.shadowOffset = CGSize(width: 0, height: 5)
        MainLayer.shadowRadius = 1
        MainLayer.shadowColor = UIColor.darkGray.cgColor
    }
    
    private func updateFrames() {
        BackgroundLayer.frame = bounds.inset(
            by: UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        )
        MainLayer.frame = bounds.inset(
            by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        )
    }
    
    func touchIn(){
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.1, delay: 0, options: [.allowUserInteraction,.allowAnimatedContent] , animations: {
                self.MainLayer.frame = self.bounds.inset(
                    by: UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
                )
                self.titleEdgeInsets = UIEdgeInsets(top: 5.0, left: 0.0, bottom: 0.0, right: 0.0)
                self.MainLayer.shadowOffset = CGSize(width: 0, height: 0)
                self.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    func touchOut(){
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.13, delay: 0, options: [.allowUserInteraction,.curveEaseOut] , animations: {
                self.MainLayer.frame = self.bounds.inset(
                    by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                )
                self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
                self.MainLayer.shadowOffset = CGSize(width: 0, height: 5)
                self.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        touchOut()
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        touchIn()
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        touchOut()
    }
    
}
