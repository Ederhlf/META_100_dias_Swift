

import Foundation
import UIKit

protocol ViewDelegate: AnyObject {
    func intensityChangedSlider(_ sender: UISlider)
    func changeFilterBtn(_ sender: UIButton)
    func save()
}

class View: UIView {
    let boxView = UIView()
    var currentImage = UIImageView()
    var sliderView = UISlider()
    let changeBtn = UIButton()
    let saveBtn = UIButton()
    let sliderLabel = UILabel()
    
    weak var delegate: ViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func appearBox() {
        configureBoxView()
        configureImgBox()
        configureSliderLabel()
        configureIsliderView()
        configureChangeBtn()
        configureSaveBtn()
    }
    
    @objc func intensityChanged(_ sender: UISlider) {
        delegate?.intensityChangedSlider(sender)
    }
    
    @objc func changeFilter(_ sender: UIButton) {
        delegate?.changeFilterBtn(sender)
    }
    
    @objc func save() {
        delegate?.save()
    }
}

// MARK: - BoxView
extension View {
    private  func configureBoxView() {
        addSubview(boxView)
        
        configureBoxViewSpecs()
        configureBoxViewConstraints()
    }
    
    private  func configureBoxViewSpecs() {
        boxView.translatesAutoresizingMaskIntoConstraints = false
        boxView.backgroundColor = .darkGray
    }
    
    private func configureBoxViewConstraints() {
        NSLayoutConstraint.activate([
            boxView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            boxView.leftAnchor.constraint(equalTo: leftAnchor, constant:  5 ),
            boxView.rightAnchor.constraint(equalTo: rightAnchor, constant:  -5 ),
            boxView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant:  -80 ),
        ])
    }
}


// MARK: - ImgBox
extension View {
    private  func configureImgBox() {
        boxView.addSubview(currentImage)
        
        configureImgBoxSpecs()
        configureImgBoxConstraints()
    }
    
    private  func configureImgBoxSpecs() {
        currentImage.translatesAutoresizingMaskIntoConstraints = false
        currentImage.backgroundColor = .darkGray
    }
    
    private func configureImgBoxConstraints() {
        NSLayoutConstraint.activate([
            currentImage.topAnchor.constraint(equalTo: boxView.topAnchor, constant: 5),
            currentImage.leftAnchor.constraint(equalTo: boxView.leftAnchor, constant:  5 ),
            currentImage.rightAnchor.constraint(equalTo: boxView.rightAnchor, constant:  -5 ),
            currentImage.bottomAnchor.constraint(equalTo: boxView.bottomAnchor, constant:  -140 ),
        ])
    }
}

// MARK: - SliderLabel
extension View {
    private  func configureSliderLabel() {
        boxView.addSubview(sliderLabel)
        
        configureSliderLabelSpecs()
        configureSlidarLabelConstraints()
    }
    
    private  func configureSliderLabelSpecs() {
        sliderLabel.text = "Intensity"
        sliderLabel.translatesAutoresizingMaskIntoConstraints = false
        sliderLabel.sizeToFit()
    }
    
    private func configureSlidarLabelConstraints() {
        NSLayoutConstraint.activate([
            sliderLabel.topAnchor.constraint(equalTo: currentImage.bottomAnchor, constant: 15),
            sliderLabel.leftAnchor.constraint(equalTo: boxView.leftAnchor, constant:  15 ),
        ])
    }
}


// MARK: - Islider
extension View {
    private  func configureIsliderView() {
        boxView.addSubview(sliderView)
        
        configureSliderViewSpecs()
        configureIsliderViewConstraints()
    }
    
    private  func configureSliderViewSpecs() {
        sliderView.translatesAutoresizingMaskIntoConstraints = false
//        sliderView.minimumValue = 0
//        sliderView.maximumValue = 100
//        sliderView.isContinuous = true
        sliderView.tintColor = UIColor.green
        sliderView.addTarget(self, action: #selector(intensityChanged(_ :)), for: .valueChanged)
    }
    
    private func configureIsliderViewConstraints() {
        NSLayoutConstraint.activate([
            sliderView.topAnchor.constraint(equalTo: currentImage.bottomAnchor, constant: 15),
            sliderView.leftAnchor.constraint(equalTo: sliderLabel.rightAnchor, constant:  20 ),
            sliderView.rightAnchor.constraint(equalTo: boxView.rightAnchor, constant:  -15 ),
            sliderView.bottomAnchor.constraint(equalTo: sliderView.topAnchor, constant:  20 ),
        ])
    }
}

// MARK: - ChangeBtn
extension View {
    private  func configureChangeBtn() {
        boxView.addSubview(changeBtn)
        
        configureChangeBtnSpecs()
        configureChangeBtnConstraints()
    }
    
    private  func configureChangeBtnSpecs() {
        changeBtn.setTitle("Change Color", for: .normal)
        changeBtn.backgroundColor = .brown
        changeBtn.tintColor = .orange
        changeBtn.translatesAutoresizingMaskIntoConstraints = false
        changeBtn.sizeToFit()
        changeBtn.addTarget(self, action: #selector(changeFilter(_ :)), for: .touchUpInside)
    }
    
    private func configureChangeBtnConstraints() {
        NSLayoutConstraint.activate([
            changeBtn.topAnchor.constraint(equalTo: sliderLabel.bottomAnchor, constant: 20),
            changeBtn.leftAnchor.constraint(equalTo: boxView.leftAnchor, constant:  15 ),
            changeBtn.heightAnchor.constraint(equalToConstant: 30),
            changeBtn.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}

// MARK: - SaveBtn
extension View {
    private  func configureSaveBtn() {
        boxView.addSubview(saveBtn)
        
        configureSaveBtnSpecs()
        configureChangeSaveConstraints()
    }
    
    private  func configureSaveBtnSpecs() {
        saveBtn.setTitle("Save", for: .normal)
        saveBtn.backgroundColor = .brown
        saveBtn.tintColor = .orange
        saveBtn.translatesAutoresizingMaskIntoConstraints = false
        saveBtn.sizeToFit()
        saveBtn.addTarget(self, action: #selector(save), for: .touchUpInside)
    }
    
    private func configureChangeSaveConstraints() {
        NSLayoutConstraint.activate([
            saveBtn.topAnchor.constraint(equalTo: sliderLabel.bottomAnchor, constant: 20),
            saveBtn.rightAnchor.constraint(equalTo: boxView.rightAnchor, constant:  -15 ),
            saveBtn.heightAnchor.constraint(equalToConstant: 30),
            saveBtn.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}

