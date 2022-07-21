//
//  CircleProgressView.swift
//  Fargo
//
//  Created by Elvina Jacia on 21/07/22.
//

import UIKit

class CircleProgressView: UIView {

        //Properties
        private var backLayer: CAShapeLayer!
        private var foreLayer: CAShapeLayer!
        private var imageLayer: CALayer!
            
        /*
        // Only override draw() if you perform custom drawing.
        // An empty implementation adversely affects performance during animation.
        override func draw(_ rect: CGRect) {
            // Drawing code
        }
        */
    
        override func draw(_ rect: CGRect) {
            let width = rect.width
            let height = rect.height

            let lineWidth = 0.1 * min(width, height)

           //Draw Back Layer
            backLayer = createCircleLayer(rect: rect, strokeColor: UIColor.superLightGray.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)
            
           //Draw Fore Layer
            foreLayer = createCircleLayer(rect: rect, strokeColor: UIColor.darkGreen.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)
   
    
            //Utk set forelayer udah keisi berapa persen
            //0.5 = 50%
            foreLayer.strokeEnd = 0.3
            
            //imagelayer
      
                
            //Add layer ke view
            layer.addSublayer(backLayer)
            layer.addSublayer(foreLayer)
    
        }
            
    private func createCircleLayer(rect: CGRect, strokeColor: CGColor, fillColor: CGColor, lineWidth: CGFloat) -> CAShapeLayer{
        
        let width = rect.width
        let height = rect.height

   //    let lineWidth = 0.1 * min(width, height)

        let center = CGPoint(x: width/2, y: height/2)
        let radius = (min(width, height) - lineWidth) / 2

        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + 2 * CGFloat.pi

        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true).cgPath
        
        
        //Draw layer
            let circleLayer = CAShapeLayer()
            circleLayer.path = circlePath
            circleLayer.strokeColor = strokeColor
            circleLayer.fillColor = fillColor
            circleLayer.lineWidth = lineWidth
        
        //Buat bikin fillnya jd agak circular
        //circleLayer.lineCap = .round
            
        return circleLayer
    }

       
    

}


