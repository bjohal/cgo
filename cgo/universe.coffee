root = global ? window
 


class root.Cgo.Universe
  @center: null
  @camera: null
  @scene: null
  @renderer: null
  @geometry: null
  @material: null
  @mesh: null
  @stats: null
  @controls: null
  @simulationClock: null
  @animationClock: null
  @objects: null
  @debugEl: null
  @timescale: 10000

  @init: ->
    @objects = {
      massives : [],
      others : []
    }

    @stats = new Stats
    @stats.domElement.id = "stats"

    @center = new THREE.Vector3(0,0,0) 

    @camera = new Cgo.Camera
    @scene = new THREE.Scene

    #@renderer = new THREE.CanvasRenderer
    @renderer = new THREE.WebGLRenderer
    @renderer.setClearColor 0x000000, 1
    @renderer.setSize(root.innerWidth, root.innerHeight)

    $("body").empty()
    $("body").append(@renderer.domElement)

    $("body").append(@stats.domElement)

    @debugEl = $("<div id='debug'></div>")
    $("body").append(@debugEl)


    render = ->
      Cgo.Universe.render()

      #@camera.controls.addEventListener 'change', render

    @animationClock = new THREE.Clock(true)
    @simulationClock = new THREE.Clock(true)

    @simulate()

    animate = =>
      requestAnimationFrame(animate)
      @animate()

    animate()

    geo = new THREE.Geometry();
    for i in [0..10000]
      vertex = new THREE.Vector3(
        THREE.Math.randFloatSpread(2000000000),
        THREE.Math.randFloatSpread(2000000000),
        THREE.Math.randFloatSpread(2000000000)
      )
      geo.vertices.push(vertex)

    @scene.add(
      new THREE.ParticleSystem(
        geo, 
        new THREE.ParticleSystemMaterial(color: 0x888888) 
      )
    )


  @add: (object) ->
    if object.mass > 1000000000
      @objects.massives.push(object)
      console.log "scene add massive> #{object.name} # #{@objects.massives.length}"
    else
      @objects.others.push(object)
      console.log "scene add non-massive> #{object.name} # #{@objects.others.length}"
    @scene.add(object.mesh)

  @render: ->
    @stats.update()
    @renderer.render(@scene, @camera.camera)

  @debug: (string) ->
    @debugEl.html(@debugEl.html() + string + "; ")

  @gravitateBoth: (o1, o2) ->
    if typeof(o1) == "number"
      o1 = @objects.massives[o1]
    if typeof(o2) == "number"
      o2 = @objects.massives[o2]

##    console.log(o1)
#    console.log(o1.mesh.position)
#    console.log(o2.mesh.position)
    angle = new THREE.Vector3
    angle.subVectors o1.mesh.position, o2.mesh.position
    #console.log("angle", angle)
    distance = angle.length()
    @debug("d: " + distance.toExponential())
    #console.log("distance", distance)
    gravity = Cgo.gravity(distance, o1.mass, o2.mass)
    @debug("g: " + gravity.toExponential())
    #console.log("gravity", gravity)

    angle.normalize()

    force = angle.clone()
    force.multiplyScalar(gravity / o2.mass)
    #console.log("force", force.length(), force)
    o2.force = force

    force = angle.clone()
    force.multiplyScalar(gravity / o1.mass)
    force.negate()
    o1.force = force


  @simulate: ->
    @debugEl.empty()
    delta = @simulationClock.getDelta() * @timescale
    setTimeout (=> @simulate()), 1000/20
    
    # call all objects' simulate callbacks
    object.simulate(delta) for object in @objects.massives
    object.simulate(delta) for object in @objects.others

    # now simulate gravity for massive objects
    # massive objects attract each other

    i = 0
    j = i + 1 

    while i < @objects.massives.length - 1
      @gravitateBoth(i,j)   
      if j < @objects.massives.length - 1
        j++
      else
        i++
        j = i + 1
        
    # TODO massive objects attract non-massives
    for object in @objects.massives
      @debugEl.html( @debugEl.html() + "#{object.name}: #{Math.round(object.speed.length(),2)}; " )


  @animate: ->
    delta = @animationClock.getDelta() * @timescale
    @camera.animate()
    object.animate(delta) for object in @objects.massives
    object.animate(delta) for object in @objects.others
    @render()
    

