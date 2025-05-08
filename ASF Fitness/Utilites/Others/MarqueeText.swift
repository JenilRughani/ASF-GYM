//
//  MarqueeText.swift
//  ASF
//
//  Created by Jenil Rughani on 27/03/25.
//

import Foundation
import SwiftUI

public struct MarqueeText: View {
    public var text: String
    public var font: UIFont
    public var leftFade: CGFloat
    public var rightFade: CGFloat
    public var startDelay: Double
    public var alignment: Alignment
    
    @State private var animate = false
    @State private var offset: CGFloat = 0
    var isCompact = false
    
    public var body: some View {
        let stringWidth = text.widthOfString(usingFont: font)
        let stringHeight = text.heightOfString(usingFont: font)
        
        let animation = Animation
            .linear(duration: Double(stringWidth) / 40)
            .delay(startDelay)
            .repeatForever(autoreverses: false)
        
        let nullAnimation = Animation.linear(duration: 0)
        
        GeometryReader { geo in
            let needsScrolling = (stringWidth > geo.size.width)
            
            ZStack {
                if needsScrolling {
                    makeMarqueeTexts(
                        stringWidth: stringWidth,
                        stringHeight: stringHeight,
                        geoWidth: geo.size.width,
                        animation: animation,
                        nullAnimation: nullAnimation
                    )
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity,
                        alignment: .topLeading
                    )
                    .mask(fadeMask(leftFade: leftFade, rightFade: rightFade))
                } else {
                    Text(text)
                        .font(.init(font))
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            minHeight: 0,
                            maxHeight: .infinity,
                            alignment: alignment
                        )
                }
            }
            .task {
                await animateMarquee(geoWidth: geo.size.width, needsScrolling: needsScrolling)
            }
        }
        .frame(height: stringHeight)
        .frame(maxWidth: isCompact ? stringWidth : nil)
    }
    
    private func animateMarquee(geoWidth: CGFloat, needsScrolling: Bool) async {
        guard needsScrolling else { return }
        await Task.sleep(UInt64(startDelay * 1_000_000_000)) // Convert to nanoseconds
        animate = true
    }
    
    @ViewBuilder
    private func makeMarqueeTexts(
        stringWidth: CGFloat,
        stringHeight: CGFloat,
        geoWidth: CGFloat,
        animation: Animation,
        nullAnimation: Animation
    ) -> some View {
        Group {
            Text(text)
                .lineLimit(1)
                .font(.init(font))
                .offset(x: animate ? -stringWidth - geoWidth : geoWidth)
                .animation(animate ? animation : nullAnimation, value: animate)
                .fixedSize(horizontal: true, vertical: false)
            
            Text(text)
                .lineLimit(1)
                .font(.init(font))
                .offset(x: animate ? 0 : geoWidth + stringWidth)
                .animation(animate ? animation : nullAnimation, value: animate)
                .fixedSize(horizontal: true, vertical: false)
        }
    }
    
    @ViewBuilder
    private func fadeMask(leftFade: CGFloat, rightFade: CGFloat) -> some View {
        HStack(spacing: 0) {
            Rectangle().frame(width: 2).opacity(0)
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0), Color.black]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(width: leftFade)
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.black]),
                startPoint: .leading,
                endPoint: .trailing
            )
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(width: rightFade)
            Rectangle().frame(width: 2).opacity(0)
        }
    }
    
    public init(
        text: String,
        font: UIFont,
        leftFade: CGFloat,
        rightFade: CGFloat,
        startDelay: Double,
        alignment: Alignment? = nil
    ) {
        self.text = text
        self.font = font
        self.leftFade = leftFade
        self.rightFade = rightFade
        self.startDelay = startDelay
        self.alignment = alignment ?? .topLeading
    }
}

extension MarqueeText {
    public func makeCompact(_ compact: Bool = true) -> Self {
        var view = self
        view.isCompact = compact
        return view
    }
}

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
}
