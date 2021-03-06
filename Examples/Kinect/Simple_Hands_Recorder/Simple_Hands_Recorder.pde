import SimpleOpenNI.*;

PImage depth_img;
PImage rgb_img;

String mode = "play"; // record / play / live

SimpleOpenNI kinect;

void setup()
{
  size(640, 480, P3D);
  //smooth();
  noStroke();
  fill(255, 100, 0);

  frameRate(20);

  if (mode == "live")
  {
    // Enable OpenNI / Kinect with live camera
    kinect = new SimpleOpenNI(this);
    kinect.enableDepth(); // Kinect depth image
    kinect.enableRGB(); // Kinect color image
    kinect.enableUser(); // enable skeleton
  } else if (mode == "play")
  {
    // Enable OpenNI with pre recorded .oni file
    kinect = new SimpleOpenNI(this, "recording.oni");
    kinect.enableDepth(); // Kinect depth image
    kinect.enableRGB(); // Kinect color image
    kinect.enableUser(); // enable skeleton
  } else if (mode == "record")
  {
    kinect = new SimpleOpenNI(this);
    
    kinect.enableDepth(); // Kinect depth image
    kinect.enableRGB(); // Kinect color image
    kinect.enableUser(); // enable skeleton
    
    kinect.enableRecorder("recording.oni");

    

    kinect.addNodeToRecording(SimpleOpenNI.NODE_DEPTH, true);
    kinect.addNodeToRecording(SimpleOpenNI.NODE_IMAGE, true);
    kinect.addNodeToRecording(SimpleOpenNI.NODE_USER, true);
    kinect.addNodeToRecording(SimpleOpenNI.NODE_SCENE, true);
  }

  kinect.setMirror(true);
}

void draw()
{
  background(0);

  // update OpenNI
  kinect.update();
  // get depth and color image
  depth_img = kinect.depthImage();
  //rgb_img = kinect.rgbImage();

  // display despth image
  image(depth_img, 0, 0);
  //image(rgb_img, 0, 0);

  // update skeleton
  boolean tracking = updateSketeton();

  if (tracking = true)
  {
    fill(255, 100, 0);
    pushMatrix();
    translate(SKEL_LEFT_HAND.x, SKEL_LEFT_HAND.y, 0);
    ellipse(0, 0, 20, 20);
    popMatrix();

    fill(255, 100, 255);
    pushMatrix();
    translate(SKEL_RIGHT_HAND.x, SKEL_RIGHT_HAND.y, 0);
    ellipse(0, 0, 20, 20);
    popMatrix();

    fill(255, 100, 0);
    pushMatrix();
    translate(SKEL_LEFT_FOOT.x, SKEL_LEFT_FOOT.y, 0);
    ellipse(0, 0, 20, 20);
    popMatrix();

    fill(255, 100, 255);
    pushMatrix();
    translate(SKEL_RIGHT_FOOT.x, SKEL_RIGHT_FOOT.y, 0);
    ellipse(0, 0, 20, 20);
    popMatrix();
  }
}

