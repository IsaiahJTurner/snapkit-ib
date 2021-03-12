# PLEASE HELP IF YOU WORK AT SNAPCHAT
The SnapSDK causes Interface Builder to crash when rendering IBDesignables. This happens even if SnapKit is not imported into ANY files.
To reproduce:
1. Create a new project (iOS App Xcode Template works)
2. Create an IBDesignable (example in code samples above)
3. Use the IBDesignable class in a storyboard (give text red color)
4. The color changes to red!
5. Install the SnapSDK (create Podfile + pod 'SnapSDK' + pod install + open xcworkspace)
6. Reopen the storyboard.
7. Change the color to black and red (make sure project starts building again/refreshes designable)
8. The designable will crash/turn red/not refresh anymore.

You can find an example project that reproduces the issue here: https://github.com/IsaiahJTurner/snapkit-ib

You may need to to go to Xcode tab bar -> Editor -> Automatically Refresh Designable Views and check that so designables will update.

Here is part of the crash log from ~/Library/Logs/DiagnosticReports:
```
Thread 0 Crashed:
0   libsystem_malloc.dylib        	0x00007fff20165063 tiny_malloc_should_clear + 120
1   libsystem_malloc.dylib        	0x00007fff2014b45f szone_malloc_should_clear + 66
2   libsystem_malloc.dylib        	0x00007fff201599d0 _malloc_zone_malloc + 114
3   com.apple.CoreFoundation      	0x00007fff203d1e2e __CFStrAllocateMutableContents + 60
4   com.apple.CoreFoundation      	0x00007fff203d15b4 __CFStringChangeSizeMultiple + 662
5   com.apple.CoreFoundation      	0x00007fff203cbadf __CFStringAppendBytes + 614
6   com.apple.CoreFoundation      	0x00007fff203ba086 __CFStringAppendFormatCore + 8639
7   com.apple.CoreFoundation      	0x00007fff203bc8a1 _CFStringCreateWithFormatAndArgumentsReturningMetadata + 145
8   com.apple.CoreFoundation      	0x00007fff203bc7e9 CFStringCreateWithFormatAndArguments + 127
9   com.apple.CoreFoundation      	0x00007fff203bc9b1 CFStringCreateWithFormat + 120
10  com.apple.CoreFoundation      	0x00007fff2032bd2f __CFBundleCopyDescription + 234
11  com.apple.CoreFoundation      	0x00007fff20392903 CFCopyDescription + 221
12  com.apple.CoreFoundation      	0x00007fff203bbb30 __CFStringAppendFormatCore + 15465
13  com.apple.CoreFoundation      	0x00007fff203cbd50 CFStringAppendFormatAndArguments + 110
14  com.apple.CoreFoundation      	0x00007fff203bd3be CFStringAppendFormat + 176
15  com.apple.CoreFoundation      	0x00007fff2032ef89 _CFBundleCopyFindResources + 2938
16  com.apple.CoreFoundation      	0x00007fff2032e406 CFBundleCopyResourceURL + 31
17  com.apple.CoreFoundation      	0x00007fff20495981 CFBundleGetLocalInfoDictionary + 154
18  com.apple.Foundation          	0x00007fff20733143 -[NSBundle localizedInfoDictionary] + 30
19  com.apple.Foundation          	0x00007fff2073317d -[NSBundle objectForInfoDictionaryKey:] + 36
20  com.snapchat.SCSDKCoreKit     	0x0000000210269b3b 0x210262000 + 31547
21  com.snapchat.SCSDKCoreKit     	0x00000002102698a6 0x210262000 + 30886
22  com.snapchat.SCSDKCoreKit     	0x0000000210269cd1 0x210262000 + 31953
23  com.snapchat.SCSDKCoreKit     	0x00000002102698a6 0x210262000 + 30886
24  com.snapchat.SCSDKCoreKit     	0x0000000210269cd1 0x210262000 + 31953
```
```
@IBDesignable class DesignableLabel: UILabel {
    @IBInspectable var isRedText: Bool = false {
        didSet {
            self.textColor = isRedText ? .red : .black
        }
    }
}
```
