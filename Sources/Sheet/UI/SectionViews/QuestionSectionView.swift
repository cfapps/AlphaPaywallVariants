//
// Copyright © 2023 CF Apps LLC. All rights reserved.
//

import UIKit
import QuickToolKit

final class QuestionSectionView: UIView {
    
    struct Item {
        
        let questionText: String
        
        let answerText: String
    }
    
    private lazy var collection = QuickTableViewCollection()
    private lazy var dataSource = QuickTableViewDataSource(collection: collection)
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2, weight: .bold)
        label.textColor = UIColor.label
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = ContentSizedTableView()
        tableView.backgroundColor = UIColor.clear
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.register(cellType: QuestionTableViewCell.self)
        return tableView
    }()
    
    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    var items: [Item] = [] {
        didSet {
            collection.update(with: [
                QuickTableViewSection(
                    items: items.map({
                        QuestionTableViewCellModel(
                            titleText: $0.questionText,
                            descriptionText: $0.answerText
                        )
                    })
                )
            ])
            tableView.reloadData()
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(tableView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.bottom.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
        }
    }
}

extension QuestionSectionView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.numberOfRows(inSection: indexPath.section) - 1 == indexPath.item {
            cell.separatorInset = UITableView.hiddenSeparatorInset
        } else {
            cell.separatorInset = UIEdgeInsets.zero
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let cell = tableView.cellForRow(at: indexPath) as? QuestionTableViewCell else {
            return
        }
        
        tableView.performBatchUpdates {
            cell.toggle()
        }
    }
}
