//
//  PageControl.swift
//  ASF Fitness
//
//  Created by Ravi Panchasra on 08/05/25.
//

import Foundation
import UIKit
import SwiftUI

struct PageControl: UIViewRepresentable {
    
    var current = 0
    
    func makeUIView(context: UIViewRepresentableContext<PageControl>) -> UIPageControl {
        
        let page = UIPageControl()
        page.currentPageIndicatorTintColor = UIColor(Color("Primary"))
        page.numberOfPages = 3
        page.pageIndicatorTintColor = .gray
        
        return page
    }
    
    func updateUIView(_ uiView: UIPageControl, context: UIViewRepresentableContext<PageControl>) {
        uiView.currentPage = current
    }
}
