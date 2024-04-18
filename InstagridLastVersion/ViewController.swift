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
    @IBOutlet weak var TextToSwipeLeft: UILabel!
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
        SwipeGesture()
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
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            
        }
    }
    //next session
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {//dictionnaire contenant des informations sur l'image sélectionnée.
        picker.dismiss(animated: true, completion: nil) //Fermeture du contrôleur de sélection d'image nill cune action particulière n'est exécutée une fois que le contrôleur de sélection d'image est fermé.
        
     if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage { imageIntoMainGridInsertion(pickedImage) }
    }
     
     func imageIntoMainGridInsertion(_ image: UIImage) {
         buttonTouched.contentMode = .scaleAspectFit //insertion ajustemn sans deformation image //
         buttonTouched.setImage(image, for: UIControl.State.normal) //image contenu du bouton
     }
    // Add Gesture *balayage* To defferent Elements
    
    func SwipeGesture() {
       addSwipeGesture(to: ArrowToSwipe, [.up, .left])
       addSwipeGesture(to: TextToSwipeUp, [.up])
       addSwipeGesture(to: TextToSwipeLeft, [.left])
       addSwipeGesture(to: MainGridView, [.up, .left])
    }
    func addSwipeGesture(to view: UIView, _ gesture_tab: [UISwipeGestureRecognizer.Direction]) {
        for direction in gesture_tab {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(Swiped(_:)))
            gesture.direction = direction //Configuration de la direction du geste de balayage
            view.addGestureRecognizer(gesture) //ajoute le geste de balayage à la vue
        }
    }
    //geste Valid Or Not 
    func isSwipeValid(_ sender: UISwipeGestureRecognizer) -> Bool {
        return (sender.direction == .left && traitCollection.verticalSizeClass == .compact) || (sender.direction == .up && traitCollection.verticalSizeClass == .regular && traitCollection.horizontalSizeClass == .compact)
    }
    //Cette annotation indique que la méthode Swiped(_:) peut être accessible depuis Objective-C. Elle est nécessaire lorsqu'une méthode est utilisée comme cible d'un sélecteur Objective-C, comme c'est le cas lors de la création d'un UISwipeGestureRecognizer.
    @objc func Swiped(_ sender: UISwipeGestureRecognizer) {
        if isSwipeValid(sender) {
            var translation = CGAffineTransform()
            if (sender.direction == .up) {
                translation = CGAffineTransform(translationX: 0, y: -MainGridView.frame.maxY)
            }
            else if (sender.direction == .left) {
                translation = CGAffineTransform(translationX: -MainGridView.frame.maxX, y: 0)
            }
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [.curveEaseIn], animations: {
                self.MainGridView.transform = translation
                },
                completion: { (end) in
                    let share = self.mainGridImageReadyToShare(sender)
                    self.present(share, animated: true)
                }
            )
        }
    }
    func mainGridImageReadyToShare(_ sender: UISwipeGestureRecognizer) -> UIActivityViewController {
        let image = [self.MainGridView.image] //preparation image
        
        let activityViewController = UIActivityViewController(activityItems: image as [Any], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = UIActivityViewController.CompletionWithItemsHandler? { activityType,completed,returnedItems,activityError in
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [.curveEaseIn], animations: {
                self.MainGridView.transform = CGAffineTransform(translationX: 0, y: 0)
                },
                completion: nil
            )
        }
        return activityViewController
    }
    // SWIPE PART end
}

//ajoute une propriété calculée image, qui permet de générer une image à partir du contenu de la vue.
extension UIView {
    var image: UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in layer.render(in: rendererContext.cgContext) }
    }
}


