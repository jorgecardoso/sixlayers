A computational graphic design tool developed using Processing

**SixLayers** is a design tool (built with Processing) created to help generate the graphical image for the [School of Art's new Digital Design](http://artes.ucp.pt/designdigital) course.

## Layers ##
It transforms 2d images into 3d objects composed of six layers, defined by the brightness of the pixels. Each layer is draw four pixels at a time, and can be represented with different graphical primitives:

  * two points
  * four points
  * two lines
  * an empty triangle
  * an empty square
  * a filled triangle
  * a filled square

Additionally, it is possible to displace the original pixel positions by randomizing within an adjustable range.

## Parameters ##
The tool also allows setting other various parameters:

  * the background color
  * the colors applied to the gradient (the original colors of the source image are not used, instead they are converted to a gradient applied according to the brightness)
  * which area (rectangle) of the image to render
  * the resolution (how many pixels of the original image are processed)

## Animation ##
SixLayers also allows you to animate the graphical parameters using keyframe based animation.

## Exporting ##
You can export still images, high-resolution still images, a video of the animation, or the individual animation frames.

## Demo ##
Here's an example of the usage of the tool:

<a href='http://www.youtube.com/watch?feature=player_embedded&v=EKYGNjRO0C4' target='_blank'><img src='http://img.youtube.com/vi/EKYGNjRO0C4/0.jpg' width='425' height=344 /></a>

## Example animation ##
For the website of the course, we have created various animations. Here's one:

<a href='http://www.youtube.com/watch?feature=player_embedded&v=BOItk0h3I7w' target='_blank'><img src='http://img.youtube.com/vi/BOItk0h3I7w/0.jpg' width='425' height=344 /></a>


## Technical info ##

Built with Processing, using ControlP5 GUI library.

## Credits ##

Concept: [Jorge Cardoso](http://jorgecardoso.eu), [Luis Sarmento](http://spiritbit.com), Carla Almeida

Programming: Jorge Cardoso