//
//  NewsTabViewController.swift
//  VKApp
//
//  Created by Butmalay Denis on 06.03.2021.
//

import UIKit

class NewsTabViewController: UITableViewController {
    private let networkSession = NetworkService(token: Session.shared.token)
    //var 
    var addedNews = [News] ()
    var sectionedGroups: [NewsResopnse] {
        addedNews.reduce(into: []) {
            currentSectionNews, group in
            guard let firstLetter = News.post_type.first else { return }
            
            if let currentSectionNewsFirstLetterIndex = currentSectionNews.firstIndex(where: { $0.title == firstLetter }) {
                
                let oldSection = currentSectionNews[currentSectionNewsFirstLetterIndex]
                let updatedSection = NewsResopnse(title: firstLetter, news: oldSection.news + [news])
                currentSectionNews[currentSectionNewsFirstLetterIndex] = updatedSection
                
            } else {
                let newSection = NewsResopnse(title: firstLetter, news: [news])
                currentSectionNews.append(newSection)
            }
        }.sorted()
    }
                
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: NewsRichCell.nibName, bundle: nil), forCellReuseIdentifier: NewsRichCell.reuseIdentifier)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addedNews.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsRichCell.reuseIdentifier, for: indexPath) as? NewsRichCell else { return UITableViewCell() }
        cell.configure(with: addedNews[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       if editingStyle == .delete {
        print("Remove at index \(indexPath.row) with name \(addedNews[indexPath.row].post_type) ")
           addedNews.remove(at: indexPath.row)
           tableView.deleteRows(at: [indexPath], with: .fade)
           //print(addedNews)
       }
   }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SegueShowDetailGroup", sender: nil) //ShowNewsUnwindSegue
    }
}
     
//
//extension NewsTabViewController: UITableViewDataSource {
//   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//       return addedNews.count
//   }
//
//   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//       guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsRichCell.reuseIdentifier, for: indexPath) as? NewsRichCell else { return UITableViewCell() }
//
//        cell.newsNameLabel.text = addedNews[indexPath.row].name
//        //print(cell.friendLabel.text)
//        return cell
//   }
//}
