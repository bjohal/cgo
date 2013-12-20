root = global ? window

if root.Meteor.isClient
  root.Template.hello.greeting = ->
    "Welcome to FirstApp."
 
  root.Template.hello.events = "click input": ->
    Cgo.Universe.init()
    earth = new Cgo.Planet(
      radius:   6371 * 1000,
      mass:     5.97219 * Math.pow(10,24), 
      rotation: 0.99726968,
      name:     "Earth",
      texture:  "earth/1k",
      color:    0x0000ff
    )

    moon = new Cgo.Planet(
      radius:   1737.1 * 1000,
      mass:     7.3477 * Math.pow(10,22),
      rotation: 27.321582,
      name:     "Moon",
      texture:  "moon/1k",
      color:    0xcccccc
    )

    sun = new Cgo.Star(
      radius:   6.96342e+9,
      mass:     1,
      #mass:     1.9891e+30,
      rotation: 27.321582,
      name:     "Sun",
      color:    0xffcc00
    )

    #moon.mesh.translateX( 363295000 )
    moon.mesh.translateX( 363295000 )
    sun.mesh.translateX( 1.52098232e+12 )
    orbVel = Cgo.orbitalVelocity( 363295000, earth.mass, moon.mass )
    console.log("orbvel", orbVel)
    moon.speed.y = orbVel

    Cgo.Universe.add earth
    Cgo.Universe.add moon
    Cgo.Universe.add sun

    Cgo.Universe.add bug = new Cgo.Bug

    root.p = {
      earth: earth,
      moon: moon,
      sun: sun,
      bug: bug
    }



