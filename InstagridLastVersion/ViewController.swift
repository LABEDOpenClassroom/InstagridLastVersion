//
//  ViewController.swift
//  InstagridLastVersion
//
//  Created by Toufik LABED on 04/04/2024.
//
import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var ArrowToSwipe: UIImageView!
    @IBOutlet weak var TextToSwipeUp: UILabel!
    @IBOutlet weak var MainGridView: UIView!
    @IBOutlet weak var TopLeftButton: UIButton!
    @IBOutlet weak var BottomLeftButton: UIButton!
    @IBOutlet weak var TopRightButton: UIButton!
    @IBOutlet weak var BottomRightButton: UIButton!
    
    //3 buttons to choose the main grid's layout.
    
    @IBOutlet weak var Layout1Button: UIButton!
    @IBOutlet weak var Layout2Button: UIButton!
    @IBOutlet weak var Layout3Button: UIButton!
    
    
    //  user's photo library.
    
    var buttonTouched = UIButton()
    var imagePicker = UIImagePickerController()
    
    func defaultMainGridView() {
        Layout3ButtonTouched("")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultMainGridView()
        //ManageSwipeUpGesture()//
    }
    
    @IBAction func Layout1ButtonTouched(_ sender: Any) {
        if (Layout1Button.currentImage == nil) {
            removeButtonsImages()
            BottomRightButton.isEnabled = true;
            BottomRightButton.isHidden = false;
            Layout1Button.setImage(UIImage(named: "Selected"), for: UIControl.State.normal)
            TopRightButton.isEnabled = false;
            TopRightButton.isHidden = true;
        }
    }
    
    
    
    @IBAction func Layout2ButtonTouched(_ sender: Any) {
        if (Layout2Button.currentImage == nil) {
            removeButtonsImages()
            TopRightButton.isEnabled = true;
            TopRightButton.isHidden = false;
            Layout2Button.setImage(UIImage(named: "Selected"), for: UIControl.State.normal)
            BottomRightButton.isEnabled = false;
            BottomRightButton.isHidden = true;
        }
    }
    
    
    @IBAction func Layout3ButtonTouched(_ sender: Any) {
        if (Layout3Button.currentImage == nil) {
            removeButtonsImages()
            TopRightButton.isEnabled = true;
            BottomRightButton.isEnabled = true;
            TopRightButton.isHidden = false;
            BottomRightButton.isHidden = false;
            Layout3Button.setImage(UIImage(named: "Selected"), for: UIControl.State.normal)
        }
    }
    func removeButtonsImages() {
        Layout1Button.setImage(nil, for: UIControl.State.normal)
        Layout2Button.setImage(nil, for: UIControl.State.normal)
        Layout3Button.setImage(nil, for: UIControl.State.normal)
    }
    
    
    // images insertion
    
    @IBAction func GridButtonTouched(_ sender: UIButton) {
        takeAPhoto()
        buttonTouched = sender
    }
    
    @IBAction func GridButtonTouched2(_ sender: UIButton) {
        takeAPhoto()
        buttonTouched = sender
    }
    
    @IBAction func GridButtonTouched3(_ sender: UIButton) {
        takeAPhoto()
        buttonTouched = sender
    }
    
    @IBAction func GridButtonTouched4(_ sender: UIButton) {
        takeAPhoto()
        buttonTouched = sender
    }
    func takeAPhoto() {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
     if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage { insertPickedImageIntoMainGrid(pickedImage) }
    }
     
     func insertPickedImageIntoMainGrid(_ image: UIImage) {
         buttonTouched.contentMode = .scaleAspectFit
         buttonTouched.setImage(image, for: UIControl.State.normal)
     }
}
