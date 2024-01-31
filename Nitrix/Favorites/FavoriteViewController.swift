//
//  FavoriteViewController.swift
//  Nitrix
//
//  Created by Misha Vrana on 30.01.2024.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    var favoriteMovies: [FavoriteMovie] = []
    var showDetailRequest: (FavoriteMovie) -> () = {_ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        fetchDataFromCoreData()
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGesture.minimumPressDuration = 0.5
        self.tableView.addGestureRecognizer(longPressGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchDataFromCoreData()
        tableView.reloadData()
    }
    
    func fetchDataFromCoreData() {
        
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest = NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
        
        do {
            favoriteMovies = try context.fetch(fetchRequest)
            tableView.reloadData()
        } catch {
            print("Error fetching data from CoreData: \(error.localizedDescription)")
        }
        
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = favoriteMovies[indexPath.row].title

        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showDetailRequest(favoriteMovies[indexPath.row])
    }
    
    @objc func handleLongPress(longPressGesture: UILongPressGestureRecognizer) {
        let gestureLocation = longPressGesture.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: gestureLocation)
        if longPressGesture.state == UIGestureRecognizer.State.began {
            print("Long press on row, at \(indexPath!.row)")
            
            let movie = favoriteMovies[indexPath!.row]
            FavoriteMovie.delete(movie: movie)
            favoriteMovies.remove(at: indexPath!.row)
            tableView.reloadData()
            PersistenceController.shared.save()
        }
    }
}
