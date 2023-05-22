
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var myView: View?
    let defaults = UserDefaults.standard

    override func loadView() {
        super.loadView()
        myView = View()
        view = myView
        
        myView?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewPerson)
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let savedPeople = defaults.object(forKey: "people") as? Data {
            if let decodePeople = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedPeople) {
                myView?.people = decodePeople as! [Person]
                myView?.collectionView?.reloadData()
            }
        }
    }
    
    @objc func addNewPerson() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = myView?.getDocumentsDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath!)
        }

        let person = Person(name: "Eber", image: imageName)
        myView?.people.append(person)
        myView?.collectionView?.reloadData()
        self.saveData()

        dismiss(animated: true)
    }

    func saveData() {
        if let saveData = try? NSKeyedArchiver.archivedData(withRootObject: myView?.people as Any, requiringSecureCoding: false) {
            defaults.setValue(saveData, forKey: "people")
        }
    }
}

extension ViewController: PersonDelegate {
    func didSelectedIndexPath(person: Person) {
        let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
        ac.addTextField()

        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            guard let newName = ac?.textFields?[0].text else { return }
            person.name = newName

            self?.myView?.collectionView!.reloadData()
            self?.saveData()
        })

        present(ac, animated: true)
    }
}