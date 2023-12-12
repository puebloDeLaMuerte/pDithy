float xrot = 0;
float yrot = 0;

void ddd() {
  
  if( autoRotate ) {
    xrot += 6.1f;
    yrot += 4.1f;
  }
  
  pushMatrix();
  
  noLights();
  
  translate(width / 2, height / 2);
  
  // Orange point light on the right
  pointLight(150, 100, 0, // Color
             200, -150, 0); // Position

  // Blue directional light from the left
  directionalLight(0, 102, 255, // Color
                   1, 0, 0); // The x-, y-, z-axis direction

  // Yellow spotlight from the front
  spotLight(255, 255, 109, // Color
            0, 40, 200, // Position
            0, -0.5, -0.5, // Direction
            PI / 2, 2); // Angle, concentration
  
  rotateY(map(mouseX+xrot, 0, width, 0, PI));
  rotateX(map(mouseY+yrot, 0, height, 0, PI));
  box(250);
  
  popMatrix();
}
