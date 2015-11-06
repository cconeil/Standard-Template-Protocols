# Standard Template Protocols

Essential protocols for your every day iOS needs

![language](https://img.shields.io/badge/Language-Swift-blue.svg)
![MIT License](https://img.shields.io/badge/License-MIT-lightgrey.svg)
![Platform](https://img.shields.io/badge/platform-%20iOS%20-lightgrey.svg)

## Example

<img src="./gifs/gesture_example.gif" width="320px"></img>

UIGestureRecognizerProtocols

## About

Swift 2.0 opens a world of opportunity with enhanced Protocols and Protocol Extensions. This library attempts to address some of the most commonly repeated patterns in iOS apps using protocol oriented programming and reduce the need to create deep, complicated subclassing trees.

## Why Protocols?

Too often we find ourselves locked into deep and complicated subclassing trees just to factor out common behavior in our apps. This makes our code  inflexible, hard to navigate, and contain too many dependencies. Using protocols for common features allows us to create default behavior that is additive without complicated subclassing.

## Setup
#### Cocoapods (recommended)
1. Make sure you have downloaded and installed [cocoapods](https://cocoapods.org/).
2. Add `pod 'STP'`to your podfile.
3. Make sure that your podfile includes `use_frameworks!`
4. `pod install`
5. `import STC` and let the magic happen!

#### Manual
1. Drag and drop the files into your project and build the app.  Note you will not get bugfixes, updates, and new releases if you do this. If you want custom features, I reccommend forking this repo.

## UIGestureRecognizer Protocols
All too often, we find ourselves subclassing views to allow them to be tappable, moveable, rotatable, and more. These protocols allow you to add these features by simply conforming to a protocol, but still give you the flexible to create custom features and animations.

#### Moveable
By default, making a view conform to the Movable protocol will attach a `UIPanGestureRecognizer` and allow the user to tap on the view and drag it around the screen. The default behavior is for the view to only be dragged within its superview. Creating a moveable view is as simple as:

```swift    
class MyMoveableView : UIView, Moveable {
    init(frame: CGRect) {
        super.init(frame: frame)
        self.makeMoveable()
    }
}
``` 
To do an action on start or finish, or use custom logic for movement or animation, implement the appropriate methods in the `Moveable` protocol.

```swift
func didStartMoving()
func didFinishMoving(velocity:CGPoint)
func canMoveToX(x:CGFloat) -> Bool
func canMoveToY(y:CGFloat) -> Bool
func translateCenter(translation:CGPoint, velocity:CGPoint, startPoint:CGPoint, currentPoint:CGPoint) -> CGPoint
func animateToMovedTransform(transform:CGAffineTransform)
```

#### Pinchable
By default, making a view conform to the Pinchable protocol will attach a `UIPinchGesetureRecognizer` and allow the user to pinch and scale a view.  Creating a pinchable view is as simple as:

```swift
class MyPinchableView : UIView, Pinchable {
    init(frame: CGRect) {
        super.init(frame: frame)
        self.makePinchable()
    }
}
```

To do an action on start or finish, or create custom transform or animation logic, simply implement the appropriate methods in the `Pinchable` protocol


```swift
func didStartPinching()
func didFinishPinching()
func maximumPinchScale() -> CGFloat
func minimumPinchScale() -> CGFloat
func transformWithScale(scale:CGFloat, lastScale:CGFloat, velocity:CGFloat) -> CGAffineTransform
func animateToPinchedTransform(transform:CGAffineTransform)
```
#### Rotatable
By default, making a view conform to the `Rotatable` protocol will attach a `UIRotationGestureRecognizer` and allow the user to use two fingers to rotate a view.  Creating a rotatable view is as simple as:

```swift
class MyRotatableView : UIView, Rotatable {
    init(frame: CGRect) {
        super.init(frame: frame)
        self.makeRotatable()
    }
}
```

To do an action on start or finish, or create custom transform or animation logic, simply implement the appropriate methods in the `Rotatable` protocol

```swift
func didStartRotating()
func didFinishRotating(velocity:CGFloat)
func minimumRotation() -> CGFloat
func maximumRotation() -> CGFloat
func transformWithRotation(rotation:CGFloat, lastRotation:CGFloat, velocity:CGFloat) -> CGAffineTransform
func animateToRotatedTransform(transform:CGAffineTransform)
```

#### Tappable

By default, making a view conform to the `Tappable` protocol will attach a `UILongPressGestureRecognizer` and allow the user to tap.  It will call the `didTap()` method and set the `alpha` of the view to `0.5` on the down state and `1.0` on the up state.  Creating a tappable view is as simple as:

```swift
class MyTappableView : UIView, Tappable {
    init(frame: CGRect) {
        super.init(frame: frame)
        self.makeTappable()
    }
    
    func didTap() {
         print("tapped!")
    }
}
```

To do customize the up and down state and/or adjust the minimum press duration and allowable movement, simply implement the appropriate methods in the `Tappable` protocol.


```swift
func didTap()
func didTouchDown()
func didTouchUp()
func minimumPressDuration() -> NSTimeInterval
func allowableMovement() -> CGFloat
```

#### Forceable

By default, making a view conform to the `Forceable` protocol will attach a `ForceTouchGestureRecognizer` and allow the user to press down with a force. It will call the `didForce()` method, but doesn't have any default behavior. Creating a forceable view is as simple as:

```swift
class ForceView: UIView, Forceable {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.makeForceable()
    }
}
```

To do customize the vide on force, simply implement the appropriate methods in the `Forceable` protocol.

```swift
func didStartForcing(force:CGFloat)
func didForce(force:CGFloat, lastForce:CGFloat)
func didFinishForcing(force:CGFloat)
```

#### Using Them Together

Because protocols are addative, you can mix and match these protocols to create even more dynamic views. Creating a view that movable, pinchable, rotatable, and tappable is as easy as:

```swift
class MyAwesomeView : UIView, Moveable, Rotatable, Pinchable, Tappable {
    init(frame: CGRect) {
        super.init(frame: frame)
        self.makeMoveable()
        self.makeRotatable()
        self.makePinchable()
        self.makeTappable()
    }
}
```

## Contributions
Pull requests are welcome! You can also email me or contact me on Twitter if you have any questions, ideas, or just want to contribute.

t: [@chrisoneil_](https://twitter.com/chrisoneil_)

e: [cconeil5@gmail.com](mailto:cconeil5@gmail.com)

A special thanks to [jhurray](https://github.com/jhurray) for inspring me to do work on some open source code.


## TODO:
There's a ton that we can do hear, and I would love to hear suggestions and get pull requets. Here are some things that I'm planning to work on in the immediate future.

1. A protocol for a 3D touch force gesture.
2. A protocol for view controllers that implements default peek and pop for force touch.
3. A protocol for view controllers that drops down an error banner.

## License
Standard Template Protocols is released under the MIT license. See LICENSE for details.
