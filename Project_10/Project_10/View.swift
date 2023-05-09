
import Foundation
import UIKit

class View: UIView {
    var collectionView: UICollectionView?

    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .red
        let layout = UICollectionViewFlowLayout()
////               layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//               layout.minimumLineSpacing = 0
//               layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 50, height: 100)
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal


        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        addSubview(collectionView )

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PersonCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        
        collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension View: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "cell",
                for: indexPath
        ) as? PersonCell else { return UICollectionViewCell() }

        cell.imageView.image = UIImage(named: "person")
        cell.nameLabel.text = "derder"
//        cell.backgroundColor = .purple
        return cell
    }
    

    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: 60 , height: 50)
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 3.0
      }
    
}
