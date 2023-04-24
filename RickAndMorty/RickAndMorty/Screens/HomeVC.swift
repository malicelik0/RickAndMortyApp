//
//  HomeVC.swift
//  RickAndMorty
//
//  Created by Mali on 14.04.2023.
//

import UIKit

class HomeVC: UIViewController {
  
  var locations: [Location] = []
  var characters: [Character] = []
  var hasMoreLocation = true
  var page = 1
  
  private var isLoading = false
  
  private var collectionView: UICollectionView!
  private var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupHomeVC()
    setupCollectionView()
    setupTableView()
    getLocations(page: page) { [weak self] in
      guard let self = self else { return }
      
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  
  private func setupCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 20
    layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .white
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(LocationCell.self, forCellWithReuseIdentifier: "cell")
    collectionView.register(LoadingCell.self, forCellWithReuseIdentifier: "loadingCell")
    
    view.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.heightAnchor.constraint(equalToConstant: 60)
    ])
  }
  private func setupHomeVC() {
    let logo = UIImage(named: "rmLogo")
    let imageView = UIImageView(image: logo)
    imageView.frame = CGRect(x: 0, y: 0, width: 60, height: 15)
    imageView.contentMode = .scaleAspectFit
    navigationItem.titleView = imageView
  }
  private func setupTableView() {
    tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(CharacterCell.self, forCellReuseIdentifier: "customCell")
    
    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  private func getLocations(page: Int, completion: @escaping () -> Void) {
    NetworkManager.shared.getLocations(page: page) { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success(let locations):
        if locations.count < 20 { self.hasMoreLocation = false }
        self.locations.append(contentsOf: locations)
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  
  
}
// MARK: - UICollectionViewDataSource
extension HomeVC: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return locations.count + (isLoading ? 1 : 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.row < locations.count {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? LocationCell else { return UICollectionViewCell() }
      cell.label.text = locations[indexPath.row].name
      cell.label.adjustsFontSizeToFitWidth = true
      cell.label.minimumScaleFactor = 0.5
      return cell
    } else {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loadingCell", for: indexPath) as! LoadingCell
      cell.spinner.startAnimating()
      return cell
    }
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeVC: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 130, height: 40)
  }
}

// MARK: - UICollectionViewDelegate
extension HomeVC: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedLocation = locations[indexPath.row]
    NetworkManager.shared.getCharacters(residentIDs: selectedLocation.residentIDs) { [weak self] characterResult in
      guard let self = self else { return }
      
      switch characterResult {
      case .success(let characters):
        self.characters = characters
        
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      case .failure(_):
        characters.removeAll()
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
        self.presentRMAlertOnMainThread(title: "UPPS!", message: "This Location is Empty", buttonTitle: "Ok")
      }
    }
    
  }
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let offsetX = scrollView.contentOffset.x
    let contentWidth = scrollView.contentSize.width
    let width = scrollView.frame.size.width
    
    if offsetX > contentWidth - width {
      isLoading = true
      page += 1
      getLocations(page: page) {
        self.isLoading = false
        self.collectionView.reloadData()
      }
    }
    
    
    
  }
}
// MARK: - UITableViewDataSource
extension HomeVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return characters.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CharacterCell else { return UITableViewCell() }
    
    let character = characters[indexPath.row]
    cell.configure(with: character)
    
    if let imageUrl = URL(string: self.characters[indexPath.row].image) {
      NetworkManager.shared.loadImage(from: imageUrl) { (image) in
        DispatchQueue.main.async {
          cell.cellImageView.image = image
        }
        
      }
    }
    return cell
  }
}
// MARK: - UITableViewDelegate
extension HomeVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 110
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let destVC = DetailVC()
    destVC.character = characters[indexPath.row]
    navigationController?.pushViewController(destVC, animated: true)
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
