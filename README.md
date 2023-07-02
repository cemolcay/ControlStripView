ControlStripView
===

A wrapper around UIScrollView + UIStackView for laying out multiple views horizontally with equal spacing. 

It allows you to scroll the items automatically if the frame size is not enough. 

Otherwise, it lays out the items with an equal spacing. 


Demo 
---

![alt tag](https://github.com/cemolcay/ControlStripView/demo.gif)

Install
---

Install with swift package manager using this repo's URL

```
https://github.com/cemolcay/ControlStripView.git
```

Usage
---

Create the view:

``` swift
let strip = ControlStripView()
```

Add views to the strip:

``` swift
strip.addItem(view: cutoffKnob)
strip.addItem(view: resonanceKnob)
```

Example
---

The repo includes an example usage of the view. 

- Items will scroll on portrait mode, 
- And they will layout with equal spacing on landscape mode.
