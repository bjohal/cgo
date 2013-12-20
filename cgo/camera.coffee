root = global ? window
 
class root.Cgo.Camera
  constructor: ->
    @camera = new THREE.PerspectiveCamera(75, root.innerWidth / root.innerHeight)
    @camera.position.z = 7000 * 1000 * 2
    #@camera.far = 152000000000
    @camera.far = 1.52098232e+12 * 2
    @camera.near = 10
    @camera.updateProjectionMatrix()

    @controls = new THREE.OrbitControls(@camera)
    @

  follow: (object) ->
    @following = object
    @following.add(@camera)
    #@controls.target = @following.mesh.position

  track: (object) ->
    @tracking = object

  animate: ->
    @controls.update()
    if @tracking?
      @camera.lookAt(@tracking.mesh.position)

