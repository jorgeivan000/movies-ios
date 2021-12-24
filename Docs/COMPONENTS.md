# Components

## Actions Container

//TODO: Document use and properties

## CodeFields

Attribute  | Type | Description
------------- | ------------- | -------------
Size  | Number  | Code input fields size for both width and height.
Space Between  | Number  | Horizontal space between each field.
Is Secure  | Number  | Determines draw strategy in order to hide/show current "Text" attribute value.
Digit Count  | Number  | Number of input fields to be draw.
Text  | String  | Current input fields value. Characters shown depend on the "Digit Count" attribute.
Font Size  | Number  | Input character value size
Border Width  | Number  | Determines input border width. This attribute is valid only when "Is Secure" attribute is set to false.
Text Color  | Color  | Input character text color
Empty Color  | Color  | Color to use when an input has no character
Filled Color  | Color  | Color to use when an input is filled
Error Color  | Color  | Color to use when the fields are on "error" state

### How to use

Setup your storyboard:

Add an `UIView` to your storyboard and set the custom class to `CodeFields`. Now you can modifiy attributes inside the inspector. [See how to setup storyboard](https://drive.google.com/file/d/1hnfGtkwRUjvPNIkZK7H5UBYrNFI2B3ho/view)

**Important:** The *CodeFields* width should match your *UIView* height to avoid layouting issues on live preview.

Setup your view controller:

```swift
class OnboardingViewController: UIViewController {

    //MARK: - Outlets

    @IBOutlet weak var pinFields: CodeFields!
    @IBOutlet weak var smsCodeFields: CodeFields!

    //MARK: - Controller

    override func viewDidLoad() {
        super.viewDidLoad()
        addDismissGestureRecognizer()
        // Do not forget to use delegate in order to listen value changes
        pinFields.delegate = self
        smsCodeFields.delegate = self

        // Testing to identifiy each field
        pinFields.tag = 1
        smsCodeFields.tag = 2
    }

    @IBAction func didTapToggleError(_ sender: UIButton) {
        //This is how to set error/invalid state on code fields
        pinFields.isInvalid = !pinFields.isInvalid
        smsCodeFields.isInvalid = !smsCodeFields.isInvalid
    }
}

extension OnboardingViewController: CodeFieldsDelegate {
    func codeFieldsValueChanged(_ codeFields: CodeFields) {
        // Use optional text from field "codeFields.text"
        if codeFields.tag == 1 {
            debugPrint("NIP value \(codeFields.text ?? "No value")")
        } else {
            debugPrint("SMS Code value \(codeFields.text ?? "No value")")
        }
    }
}
```

Run and see the results. [See how should see inside simulator](https://drive.google.com/file/d/13GyjYiOcLzZRBFjq3rU2HWiwZKEU5CWq/view)

## Round Button

//TODO: Document use and properties