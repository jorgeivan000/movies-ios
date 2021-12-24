//
//  ContactsSelectorViewController+CollectionView.swift
//  MoviesApp
//
//  Created by jorgehc on 5/29/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//

import Foundation

extension ContactsSelectorViewController {
    func setupCollectionView() {
        selectedContactsCollectionView.delegate = self
        selectedContactsCollectionView.dataSource = self
    }
}

extension ContactsSelectorViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedContacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let currentContact = selectedContacts[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeue(.selectedContactCollectionViewCell, for: indexPath, castingTo: SelectedContactCollectionViewCell.self)
        cell.setup()
        cell.contact = currentContact
        cell.renderContact()
        return cell
    }
}

extension ContactsSelectorViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedContact = selectedContacts[indexPath.row]
        let sectionedContacts = paginatedContactsCopy[selectedContact.section]
        guard let contactsInSection = sectionedContacts else {
            return
        }
        guard let index = contactsInSection.firstIndex(where: { $0.id == selectedContact.id  }) else {
            return
        }
        paginatedContactsCopy[selectedContact.section]?[index].isChecked = false
        contactsHashed[selectedContact.section]?[index].isChecked = false
        if let paginatedContactSectioned = paginatedContactsHashed[selectedContact.section], let paginatedContactIndex = paginatedContactSectioned.firstIndex(where: { $0.id == selectedContact.id  })  {
            paginatedContactsHashed[selectedContact.section]?[paginatedContactIndex].isChecked = false
            tableView.reloadData()
        }
        selectedContacts.remove(at: indexPath.row)
        presenter.updateContactsSelected(contactsSelected: selectedContacts)
    }
}
