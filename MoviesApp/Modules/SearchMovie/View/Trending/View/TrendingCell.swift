//
//  FavoritesCell.swift
//  MoviesApp
//
//  Created by Artur R on 24.04.2020.
//  Copyright © 2020 Artur Ryzhikh. All rights reserved.
//

import UIKit

protocol CollectionViewCellDelegate: class {
  func collectionView(didSelectItemWith viewModel: MovieViewModel)
  func showAlert(_ message: String)
  }



class TrendingCell: UICollectionViewCell {
  
  weak var cellDelegate: CollectionViewCellDelegate?
  static var reuseID : String {
    return self.description()
  }
  //MARK: Instance properties
  private var viewModel = TrendingViewModel()
  //MARK: life cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    bindViewModel()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  //MARK: Subviews
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 16
    layout.scrollDirection = .horizontal
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.showsHorizontalScrollIndicator = false
    cv.showsVerticalScrollIndicator = false
    return cv
  }()
  private func setupView() {
    setSubviewsForAutoLayout(collectionView)
    collectionView.register(TrendingMovieCell.self,
                                    forCellWithReuseIdentifier: TrendingMovieCell.reuseID)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.1450980392, blue: 0.2470588235, alpha: 1)
    //Constraint Collection View
    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      collectionView.topAnchor.constraint(equalTo: self.topAnchor),
      collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
     ])
    }
 
 }


//MARK: Collection View Delegate & DataSource
extension TrendingCell: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedViewModel = viewModel.cellViewModel(for: indexPath)
    cellDelegate?.collectionView(didSelectItemWith: selectedViewModel)
    
  }
 
 func collectionView(_ collectionView: UICollectionView,
                     numberOfItemsInSection section: Int) -> Int {
    return viewModel.numberOfItemsInSection
  }
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingMovieCell.reuseID,
                                                  for: indexPath) as! TrendingMovieCell
    let cellViewModel = viewModel.cellViewModel(for: indexPath)
    cell.viewModel = cellViewModel
    return cell
   }
  
 }
//MARK: Collection View Delegate Flow Layout
extension TrendingCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (self.frame.width / 2) , height: frame.height )
  }
}

//MARK: Bind View Model

extension TrendingCell {
  private func bindViewModel() {
     viewModel.showAlertClosure = { [weak self] in
           DispatchQueue.main.async {
               if let message = self?.viewModel.alertMessage {
                 self?.cellDelegate?.showAlert( message )
               }
           }
       }

       viewModel.updateLoadingClousure = { [weak self] () in
           DispatchQueue.main.async {
               let isLoading = self?.viewModel.isLoading ?? false
               if isLoading {
                 UIView.animate(withDuration: 0.2, animations: {
                       self?.collectionView.alpha = 0.0
                 })
               } else {
                 UIView.animate(withDuration: 0.2, animations: {
                       self?.collectionView.alpha = 1.0
                   })
               }
           }
       }
       
       viewModel.reloadDataClosure = { [weak self] () in
           DispatchQueue.main.async {
               self?.collectionView.reloadData()
           }
       }
     
   }
}
