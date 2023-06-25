//
//  ReusableCardViewType.swift
//  MapDemo
//
//  Created by Mahmoud Abdulwahab on 24/06/2023.
//

import Foundation

protocol ReusableCardViewType: AnyObject {
    var didTapOnCard: ((Int) -> ())? { get set }
    
    func configureCell()
}
