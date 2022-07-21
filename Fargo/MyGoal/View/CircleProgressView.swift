//
//  CircleProgressView.swift
//  Fargo
//
//  Created by Elvina Jacia on 21/07/22.
//

import UIKit

class CircleProgessView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */


        //Properties
        private var backLayer: CAShapeLayer!
        private var foregLayer: CAShapeLayer!
        private var imageLayer: UIImageView!
        
        override func draw(_ rect: CGRect) {
            
            //Draw backlayer
            let width = rect.width
            let height = rect.height

            let lineWidth = 0.1 * min(width, height)

            let center = CGPoint(x: width/2, y: height/2)
            let radius = (min(width, height) - lineWidth) / 2

            let startAngle = -CGFloat.pi / 2
            let endAngle = startAngle + CGFloat.pi

            let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true).cgPath
        
            
            
            //draw back layer
            backLayer = CAShapeLayer()
            backLayer.path = circularPath
            backLayer.strokeColor = UIColor.white.cgColor
            backLayer.fillColor = UIColor.clear.cgColor
            backLayer.lineWidth = lineWidth
          //  backLayer.lineCap = .round
            layer.addSublayer(backLayer)
        }
    
    


}


extension Int{
    var degreeToRadian : CGFloat{
        return CGFloat(self) * .pi/180
    }
}
