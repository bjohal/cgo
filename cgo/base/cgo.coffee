root = global ? window
 
class root.Cgo
  @G: 6.67384 * Math.pow(10, -11) 

  @gravity: (distance, mass1, mass2 = 1) ->
    @G * mass1 * mass2 / Math.pow(distance, 2)

  @orbitalVelocity: (distance, parentMass, satelliteMass) ->
    Math.sqrt( Math.pow(parentMass,2) * @G / ((parentMass + satelliteMass) * distance))
