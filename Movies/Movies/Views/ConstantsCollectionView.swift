//
//  Constants.swift
//  Movies
//
//  Created by Александр Воробей on 18.10.2021.
//

import Foundation
import UIKit

struct ConstantsCollectionView {
    static let leftDistaneToView: CGFloat = 20
    static let righttDistaneToView: CGFloat = 20
    static let gallaryMinimumLineSpacing: CGFloat = 20
    static let galleryItemWidth = (UIScreen.main.bounds.width - ConstantsCollectionView.leftDistaneToView - ConstantsCollectionView.righttDistaneToView - (ConstantsCollectionView.gallaryMinimumLineSpacing / 2)) / 2.2
}
