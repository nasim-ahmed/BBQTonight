//
//  AutoScrollingCollectionView.swift
//  Shajuni
//
//  Created by Nasim on 2/9/18.
//  Copyright © 2018 Nasim. All rights reserved.
//

import UIKit

import UIKit

enum AutoScrollingCollectionViewScrollDirection: String {
    case left = "left"
    case right = "right"
}
class AutoScrollingCollectionView: UICollectionView {
    
    
    private var timer = Timer()
    
    var scrollInterval: Int = 3
    
    deinit { stopScrolling() }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isPagingEnabled = true
    }
    
    fileprivate func setTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(scrollInterval), target: self, selector: #selector(self.autoScrollImageSlider), userInfo: nil, repeats: true)
        RunLoop.main.add(self.timer, forMode: .commonModes)
    }
    
    /**
     * Starts scrolling the collection view if there is at least one item in the datsource.
     */
    func startScrolling() {
        if !timer.isValid {
            if self.numberOfItems(inSection: 0) != 0 {
                stopScrolling()
                setTimer()
            }
        }
    }
    
    func stopScrolling() { if timer.isValid { self.timer.invalidate() } }
    
    @objc fileprivate func autoScrollImageSlider() {
        DispatchQueue.main.async {
            let firstIndex = 0
            let lastIndex = self.numberOfItems(inSection: 0) - 1
            let visibleCellsIndexes = self.indexPathsForVisibleItems.sorted()
            
           
            
            if !visibleCellsIndexes.isEmpty {
                let nextIndex = visibleCellsIndexes[0].row + 1
                let nextIndexPath: IndexPath = IndexPath.init(item: nextIndex, section: 0)
                let firstIndexPath: IndexPath = IndexPath.init(item: firstIndex, section: 0)
                
                if nextIndex > lastIndex {
                    self.scrollToItem(at: firstIndexPath, at: .centeredHorizontally, animated: true)
                } else {
                    self.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
                }
            }
        }
    }
    
    func scrollToPreviousOrNextCell(direction: AutoScrollingCollectionViewScrollDirection) {
        DispatchQueue.main.async {
            let firstIndex = 0
            let lastIndex = self.numberOfItems(inSection: 0) - 1
            let visibleCellsIndexes = self.indexPathsForVisibleItems.sorted()
            
            if !visibleCellsIndexes.isEmpty {
                let nextIndex = visibleCellsIndexes[0].row + 1
                let previousIndex = visibleCellsIndexes[0].row - 1
                let nextIndexPath: IndexPath = IndexPath.init(item: nextIndex, section: 0)
                let previousIndexPath: IndexPath = IndexPath.init(item: previousIndex, section: 0)
                
                if direction == .left {
                    if previousIndex < firstIndex {
                    } else {
                        self.scrollToItem(at: previousIndexPath, at: .centeredHorizontally, animated: true)
                    }
                } else if direction == .right {
                    if nextIndex > lastIndex {
                    } else {
                        self.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
                    }
                }
            }
        }
    }
}
