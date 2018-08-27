# CountryPickerIOS

CountryPickerIOS is lightweight version of [CountryPickerView](https://github.com/kizitonwose/CountryPickerView)

## ScreenShots

###### UITextField with left view 
![UITextFiled](https://user-images.githubusercontent.com/23559375/44647077-b8edd780-a9e5-11e8-858d-fab3b11a38ff.png)
###### CountryList, navBar inherits from pushed vc
![CountryList](https://user-images.githubusercontent.com/23559375/44647389-9a3c1080-a9e6-11e8-9d6a-f4af6f906017.png)
## Instalation
### Cocoapods
CountryPickerView is available through [CocoaPods](https://cocoapods.org). Simply add the following to your Podfile:
```
use_frameworks!

target '<Your Target Name>' do
  pod 'CountryPickerIOS`
end
```
### Manual
1. Put CountryPickerView repo somewhere in your project directory.
2. In Xcode, add CountryPickerView.xcodeproj to your project.
3. On your app's target, add the CountryPickerView framework:
 * as an embedded binary on the General tab.
 * as a target dependency on the Build Phases tab.
 
## Usage 

If you're using Storyboards/Interface Builder you can create a CountryPickerView instance by adding a UIView to your Storyboard, and then manually changing the view's class to CountryPickerView in the "Custom Class" field of the Identity Inspector tab on the Utilities panel (the right-side panel)

You can also create an instance of CountryPickerView programmatically:
```
import CountryPickerIOS

class ViewController: UIViewController {
    var countryPickerView: CountryPickerView?
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryPickerView = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 100, height: textField.bounds.height))
        countryPickerView?.delegate = self
        
        //setting countryPickerView as left/right view of UITextField,
        //you also can add countryPickerView just as subview of another view
        textField.leftView = countryPickerView
        textField.leftViewMode = .always
    }
```

To show country picker list, where you can choose country whatever you want your UIViewController have to conform CountryPickerListDelegate where in *showCountryList(output: CountryPickerListOutput)* method your create instance of CountryPickerList and setup output from argument.
```
extension ViewController: CountryPickerListDelegate {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        debugPrint("Selected country \(country)")
    }
    
    func showCountryList(output: CountryPickerListOutput) {
        let countryList = CountryPickerList(style: .grouped)
        countryList.output = output
        
        navigationController?.pushViewController(countryList, animated: true)
    }   
}
```

## License
CountryPickerView is distributed under the MIT license. See [LICENSE](https://en.wikipedia.org/wiki/MIT_License) for details.
