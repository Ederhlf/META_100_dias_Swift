
import Foundation
import UIKit

protocol PersonDelegate: AnyObject {
    func didSelectedIndexPath(person: Person) 
}

class View: UIView {
    var collectionView: UICollectionView?
    var people = [Person]()
    weak var delegate: PersonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .red
        let layout = UICollectionViewFlowLayout()
//               layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        layout.itemSize = CGSize(width: 50, height: 140)
        layout.scrollDirection = .horizontal


        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        addSubview(collectionView )

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PersonCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        
        //MARK - Constraints collection
        collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

// Delegate
extension View: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "cell",
                for: indexPath
        ) as? PersonCell else { return UICollectionViewCell() }

        let person = self.people[indexPath.item]
        
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.nameLabel.text = person.name
        cell.imageView.image = UIImage(named: path.path)

        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        delegate?.didSelectedIndexPath(person: person)
     
    }
}
