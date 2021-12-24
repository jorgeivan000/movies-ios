//
//  ContactsSelectorViewController+TableView.swift
//  MoviesApp
//
//  Created by jorgehc on 5/29/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//

import Foundation

struct ContactSelectable {
    var name: String
}

extension ContactsSelectorViewController {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.registerCell(.selectableContact)
    }
}

extension ContactsSelectorViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return paginatedSortedKeys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paginatedContactsHashed[paginatedSortedKeys[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(.selectableContact, for: indexPath, castingTo: SelectableContactTableViewCell.self)
        guard let sortedKeys = paginatedSortedKeys[safe: indexPath.section] else {
            return UITableViewCell()
        }
        guard let contact = paginatedContactsHashed[sortedKeys]?[safe: indexPath.row] else {
            return UITableViewCell()
        }
        cell.contact = contact
        cell.setSelectedColor(color: .weakGray)
        cell.renderContact()
        return cell
    }
}

extension ContactsSelectorViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 67.0
    }
    
    private var headerFactory: SectionHeaderFactory { return SectionHeaderFactory(for: 40) }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header =  paginatedSortedKeys[safe: section] else {
            return UIView()
        }
        let headerSeparatorRequired = section == 2
        return headerFactory.createSectionHeaderView(with: header, and: .contactsSelectorSectionHeader, separator: headerSeparatorRequired)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = paginatedSortedKeys[safe: section], section != .whitespace else {
            return 0.0
        }
        return headerFactory.headerHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sortedKeys = paginatedSortedKeys[safe: indexPath.section] else {
            return
        }
        if let selectedContact = paginatedContactsHashed[sortedKeys]?[safe: indexPath.row] {
            let isChecked = !selectedContact.isChecked
            if  isChecked {
                selectedContacts.append(selectedContact)
            } else {
                guard let index = selectedContacts.firstIndex(where: { $0.id == selectedContact.id  }) else {
                    return
                }
                selectedContacts.remove(at: index)
            }
            presenter.updateContactsSelected(contactsSelected: selectedContacts)
            paginatedContactsHashed[sortedKeys]?[indexPath.row].isChecked = isChecked
            guard let checkedContact = paginatedContactsCopy[sortedKeys] else {
                return
            }
            guard let index = checkedContact.firstIndex(where: { $0.id == selectedContact.id }) else { return }
            paginatedContactsCopy[sortedKeys]?[index].isChecked = isChecked
            contactsHashed[sortedKeys]?[index].isChecked = isChecked
            tableView.reloadData()
        }
    }
}
