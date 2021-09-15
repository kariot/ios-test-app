//
//  UserRegistrationViewController.swift
//  Test App
//
//  Created by Matajar on 14/09/21.
//

import UIKit

class UserRegistrationViewController: BaseViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var chooseImageButton : UIButton!
    @IBOutlet weak var fullNameTextField: TextField!
    @IBOutlet weak var dateOfBirthTextField: TextField!
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var phoneTextField: TextField!
    
    private var userImage : UIImage?
    private var userSign : UIImage?
    
    @IBOutlet weak var avartarImageVIew: UIImageView!
    @IBOutlet weak var signaturePad: Canvas!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backgroundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    private func initUI() {
        chooseImageButton.setRoundedCorners()
        userImageView.setRoundedCorners()
        dateOfBirthTextField.addInputViewDatePicker(target: self, selector: #selector(initDatePicker))
        backgroundView.roundTopCorners(radius: 20)
        
    }
    @IBAction func didTapRegister(_ sender: Any) {
        let userName = fullNameTextField.text ?? ""
        let dob = dateOfBirthTextField.text ?? ""
        let userEmail = emailTextField.text ?? ""
        let userPhone = phoneTextField.text ?? ""
        let userPhoto = getUserPhotoName()
        let userSign = getUserSign()
        
        if userName.isEmpty {
            showErrorAlert(message: "Please enter a valid name")
            return
        }
        if dob.isEmpty {
            showErrorAlert(message: "Please select a valid date of birth")
            return
        }
        if userEmail.isEmpty || !userEmail.isValidEmail() {
            showErrorAlert(message: "Please enter a valid email")
            return
        }
        if userPhone.isEmpty || userPhone.count < 10 {
            showErrorAlert(message: "Please enter a valid phone number")
            return
        }
        if userPhoto.isEmpty {
            showErrorAlert(message: "Please select a valid profile image")
            return
        }
        if userSign.isEmpty {
            showErrorAlert(message: "Please provide a valid sign")
            return
        }
        let user = ModelUser()
        user.userName = userName
        user.userDOB = dob
        user.userEmail = userEmail
        user.userPhone = userPhone
        user.userSign = userSign
        user.userPhoto = userPhoto
        RealmHelpers.saveUser(user: user)
        showSuccessAlert()
    }
    func getUserSign() -> String {
        if let userSign = signaturePad.exportDrawing() {
            let imageName = UUID().uuidString.replacingOccurrences(of: "-", with: "")
            FileUtils.saveImage(imageName: imageName, image: userSign)
            return imageName
        } else {
            return ""
        }
    }
    
    func getUserPhotoName() -> String {
        if let userImage = userImage {
            let imageName = UUID().uuidString.replacingOccurrences(of: "-", with: "")
            FileUtils.saveImage(imageName: imageName, image: userImage)
            return imageName
        } else {
            return ""
        }
        
    }
    @IBAction func didTapSelectImage(_ sender: Any) {
        showActionSheet()
    }
    
    //MARK:- Camera and Gallery
    func showActionSheet(){
        let actionSheetController: UIAlertController = UIAlertController(title: NSLocalizedString("Upload Image", comment: ""), message: nil, preferredStyle: .actionSheet)
        actionSheetController.view.tintColor = UIColor.black
        let cancelActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)
        
        let saveActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Take Photo", comment: ""), style: .default)
        { action -> Void in
            self.camera()
        }
        actionSheetController.addAction(saveActionButton)
        
        let deleteActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Choose From Gallery", comment: ""), style: .default)
        { action -> Void in
            self.gallery()
        }
        actionSheetController.addAction(deleteActionButton)
        addActionSheetForiPad(actionSheet: actionSheetController)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    func camera()
    {
        if !UIImagePickerController.isCameraDeviceAvailable(.rear) {
            return
        }
        let myPickerControllerCamera = UIImagePickerController()
        myPickerControllerCamera.delegate = self
        myPickerControllerCamera.sourceType = .camera
        myPickerControllerCamera.allowsEditing = true
        self.present(myPickerControllerCamera, animated: true, completion: nil)
        
    }
    
    func gallery()
    {
        let myPickerControllerGallery = UIImagePickerController()
        myPickerControllerGallery.delegate = self
        myPickerControllerGallery.sourceType = UIImagePickerController.SourceType.photoLibrary
        myPickerControllerGallery.allowsEditing = true
        self.present(myPickerControllerGallery, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        userImage = selectedImage
        userImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    @IBAction func didTapClear(_ sender: Any) {
        signaturePad.resetDrawing()
    }
    
    @objc func initDatePicker() {
        if let datePicker = self.dateOfBirthTextField.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            self.dateOfBirthTextField.text = dateformatter.string(from: datePicker.date)
        }
        self.dateOfBirthTextField.resignFirstResponder()
    }
    
    func showErrorAlert(message : String) {
        let alert = UIAlertController( title: nil,message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    func showSuccessAlert() {
        let alert = UIAlertController( title: "User Added",message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true)
    }
}
