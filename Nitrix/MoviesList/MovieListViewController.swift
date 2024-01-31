//
//  MovieListViewController.swift
//  Nitrix
//
//  Created by Misha Vrana on 29.01.2024.
//

import CoreData
import UIKit
import SwiftUI

class MovieListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    let tableViewDelegate = MoviewListViewDelgate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDelegate
        tableViewDelegate.uiTableView = tableView
        
        let longPressGesture = UILongPressGestureRecognizer(target: tableViewDelegate, action: #selector(tableViewDelegate.handleLongPress))
        longPressGesture.minimumPressDuration = 0.5
        self.tableView.addGestureRecognizer(longPressGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableViewDelegate.fetchMovies()
    }
}

class MoviewListViewDelgate: 
    NSObject,
    UITableViewDataSource,
    UITableViewDelegate,
    UIScrollViewDelegate
{
    var data = [Movie]()
    var uiTableView: UITableView!
    var page: Int = 1
    var isLoading: Bool = false
    var showDetailRequest: (Movie) -> () = {_ in }
    
    let movieFetcher: PageFetcher = MovieFetcher()
    let context = PersistenceController.shared.container.viewContext
    
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()
        
        cell.textLabel?.text = data[indexPath.row].originalTitle
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showDetailRequest(data[indexPath.row])
    }
    
    // MARK: - Scroll
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (uiTableView.contentSize.height-100-scrollView.frame.size.height) {
            
            guard !isLoading,  uiTableView.contentSize.height != .zero else { return }
            fetchMovies()
            
        }
    }
    
    // MARK: - Intents
    
    func fetchMovies() {
        Task { [weak self] in
            self?.isLoading = true
            let movies: [Movie] = try await self?.movieFetcher.fetch(page: self?.page ?? 1) ?? []
            
            DispatchQueue.main.async {
                self?.data.append(contentsOf: movies)
                self?.uiTableView.reloadData()
                self?.page += 1
                self?.isLoading = false
            }
        }
    }
    
    @objc func handleLongPress(longPressGesture: UILongPressGestureRecognizer) {
        let gestureLocation = longPressGesture.location(in: self.uiTableView)
        let indexPath = self.uiTableView.indexPathForRow(at: gestureLocation)
        if longPressGesture.state == UIGestureRecognizer.State.began {
            print("Long press on row, at \(indexPath!.row)")
            
            let movie = data[indexPath!.row]
            let _ = FavoriteMovie(
                title: movie.title ?? "",
                genre: "",
                releaseDate: movie.releaseDate ?? "",
                context: context
            )
            PersistenceController.shared.save()
        }
    }
}
