import UIKit
import CoreImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var myView: View?
    var context: CIContext!
    var currentFilter: CIFilter!
    var imageView = UIImageView()
    let picker = UIImagePickerController()
  
    override func loadView() {
        super.loadView()
        myView = View()
        view = myView
        
        myView?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "YACIFP"
        picker.delegate = self
        context = CIContext()
        currentFilter = CIFilter(name: "CISepiaTone")
        
        view.backgroundColor = .orange
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
    }

    @objc func importPicture() {
        picker.allowsEditing = true

        present(picker, animated: true)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        let data = image.pngData()
        myView?.currentImage.image = UIImage(data: data ?? Data())
        myView?.appearBox()
        dismiss(animated: true)
        
        let beginImage = CIImage(image: (myView?.currentImage.image)!)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)

        applyProcessing()
    }
    
    func intensityChanged(_ sender: Any) {
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(myView?.sliderView.value, forKey: kCIInputIntensityKey)
            
        }
     
        if inputKeys.contains(kCIInputRadiusKey) {
            
            currentFilter.setValue((myView?.sliderView.value)! * 100, forKey: kCIInputRadiusKey)
            
        }
      
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue((myView?.sliderView.value)! * 10, forKey: kCIInputScaleKey)
            
        }
      
        if inputKeys.contains(kCIInputCenterKey) {
            currentFilter.setValue(CIVector(
                                    x: (myView?.currentImage.image!.size.width)! / 2,
                                    y: (myView?.currentImage.image!.size.height)! / 2),
                                   forKey: kCIInputCenterKey)
            
        }

        if let cgimg = context.createCGImage(currentFilter.outputImage!, from: currentFilter.outputImage!.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            myView?.currentImage.image = processedImage
        }
    }
    
     func changeFilter(_ sender: Any) {
        let ac = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIPixellate", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CITwirlDistortion", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func setFilter(action: UIAlertAction) {
        // make sure we have a valid image before continuing!
        guard myView?.currentImage.image != nil else { return }

        // safely read the alert action's title
        guard let actionTitle = action.title else { return }

        currentFilter = CIFilter(name: actionTitle)

        let beginImage = CIImage(image: (myView?.currentImage.image)!)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)

        applyProcessing()
    }
}


extension ViewController: ViewDelegate {
    func save() {
        guard let image = myView?.currentImage.image  else { return }

       UIImageWriteToSavedPhotosAlbum(
        image,
        self,
        #selector(image(_:didFinishSavingWithError:contextInfo:)),
        nil
       )
    }
    
    func changeFilterBtn(_ sender: UIButton) {
        changeFilter(sender)

    }
    
    func intensityChangedSlider(_ sender: UISlider) {
        intensityChanged(sender)
    }
}
