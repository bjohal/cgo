
root = global ? window

class root.Cgo.Planet
  name:     null
  geometry: null
  force:    null
  mesh:     null
  material: null
  texture:  null
  mass:     null
  radius:   null
  color:    null
  category: "planet"
  gravity:  null
  planet:   null

  constructor: (params = {}) ->
    @speed = new THREE.Vector3(0,0,0)
    @gravity = new THREE.Vector3(0,0,0)
    @force = new THREE.Vector3(0,0,0)

    @name = params.name || "Unknown"
    @mass = params.mass || 2000000000
    @radius = params.radius || 1000
    @color = params.color || 0xff000
    @rotation = params.rotation || 1
    @texture = params.texture

    console.log @category, @name, @mass, @radius, @color
    @geometry = new THREE.SphereGeometry(@radius, 32, 32)
    #@material = new THREE.MeshBasicMaterial color: @color, wireframe: true 
    @createMaterial()
    @planet = new THREE.Mesh(@geometry, @material)
    @mesh = new THREE.Object3D
    @mesh.add(@planet)

  textureFor: (path) ->
    THREE.ImageUtils.loadTexture('textures/' + path)

  createMaterial: ->
    if @texture
      @material = new THREE.MeshPhongMaterial(
        color:      0xffffff, 
        map:        @textureFor(@texture + "/color.jpg"),
        bumpMap:    @textureFor(@texture + "/bump.jpg"),
        bumpScale:  @radius * 0.03,
        specularMap:@textureFor(@texture + "/spec.jpg"),
        specular:   new THREE.Color('grey')
      )
    else
      @material = new THREE.MeshLambertMaterial color: @color

  add: (child) ->
    @mesh.add child

  animate: (delta) ->
    @planet.rotation.y += delta / (86400 * @rotation) * 2 * Math.PI

    accel = @force.clone()
    accel.multiplyScalar(delta)
    @speed.add(accel)

    if @speed.length() != 0
      add = @speed.clone()
      add.multiplyScalar(delta)
      @mesh.position.add(add)

    @mesh.updateMatrix()

  simulate: (delta) ->
    #console.log("simulating #{@name} after #{delta}")
    @speed


class root.Cgo.Star extends root.Cgo.Planet
  category:    "star"
  light:       null

  constructor: (params) ->
    @light = new THREE.PointLight
    super params
    @mesh.add @light

  createMaterial: ->
    @material = new THREE.MeshLambertMaterial color: @color, emissive: @color

