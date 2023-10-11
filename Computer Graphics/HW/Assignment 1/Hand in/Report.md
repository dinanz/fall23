# Computer Graphics HW1
Diana Zhao dz1371

## Setup
- OS: Windows 11
- Code editor: VSCode
- Compiled and built with cmake

## Comments
Overall I tried to implement it exactly as outlined in the template, but in my logic I couldn't find a use for the det() function. I'm a little rusty on linear algebra so I will make sure to catch up on this with the tutor. There were also a few points where I didn't quite follow the template, such as not using the return point in the point in polygon code. Other than that, I implemented the functions as outlined in the template.<br>
Also I was unable to succesfully make using cmake, even though the cmake part did not prompt any errors. Typing command 'make' didn't work, so I had to manually compile.

## Results
### Convex hull
This had a slight issue where the lower right corner isn't included in the hull. Otherwise the hull is recognised correctly.
### Point in polygon
This also had a slight issue, this time with the cluster on the bottom left. Points that are not in the polygon are recognised as in it, while some that are in the polygon aren't recognised. Otherwise the majority of the points are correctly recognised.
### Images
See screenshots.