//
//  CfeServiceViewController+CollectionView.swift
//  MoviesApp
//
//  Created by jorgehc on 3/17/20.
//  Copyright © 2020 jorgehc.com. All rights reserved.
//

import Foundation

/*
extension CfeServiceViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PaymentMethodCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifier.paymentMethod.rawValue, for: indexPath) as! PaymentMethodCollectionViewCell
        let currentModel = cards[indexPath.row]
        cell.cardViewModel = currentModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        resetCardsSelection()
        let currentMethod = cards[indexPath.row]
        if currentMethod.cardType != .addCard {
            cards[indexPath.row].isSelected = true
            selectedPaymentMethod = cards[indexPath.row]
            collectionView.reloadData()
            self.resetValidations(balance: String(presenter.getCurrentBalance()))
        } else {
            sendToAddCard()
        }
    }
}
 */
