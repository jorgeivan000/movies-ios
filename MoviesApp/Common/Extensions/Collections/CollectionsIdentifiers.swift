//
//  CollectionsIdentifiers.swift
//  MoviesApp
//
//  Created by jorgehc on 2/1/18.
//  Copyright © 2018 jorgehc.com. All rights reserved.
//

import Foundation

//MARK: UICollectionView
enum CollectionViewCellIdentifier: String {
    case movieCollectionViewCell = "MovieCollectionViewCell"
}

//MARK: UITableView
enum TableViewCellIdentifier: String {
    case none = "none"
    case contact = "ContactTableViewCell"
    case cashtagBanner = "CashtagBannerTableViewCell"
    case selectableContact = "SelectableContactTableViewCell"
    case paymentMethod = "PaymentMethodTableViewCell"
    case onboardingStep = "StepTableViewCell"
    case addCard = "AddCardTableViewCell"
    case userHasNoCards = "UserHasNoCardsTableViewCell"
    case chatMessage = "ChatMessageTableViewCell"
    case chatGroupMessage = "ChatGroupMessageTableViewCell"
    case withdraw = "WithdrawTableViewCell"
    case monthlyHistory = "MonthlyHistoryTableViewCell"
    case singleHistory = "SingleHistoryTableViewCell"
    case historyTransactionDetail = "HistoryTransactionDetailTableViewCell"
    case singleHistoryHeader = "SingleHistoryHeaderTableViewCell"
    case updateFeature = "UpdateFeatureTableViewCell"
    case helpResource = "HelpResourceTableViewCell"
    case serviceProductSelector = "ServiceProductSelectorTableViewCell"
    case serviceCategorySelector = "ServiceCategorySelectorTableViewCell"
    case neighborhoodSelector = "NeighborhoodSelectorTableViewCell"
    case occupationSelector = "OccupationSelectorTableViewCell"
    case businessStateSelector = "BusinessStateTableViewCell"
    case businessBranchSelector = "BusinessBranchTableViewCell"
}
