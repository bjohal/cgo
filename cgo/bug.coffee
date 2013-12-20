root = global ? window

class root.Cgo.Bug
  mesh: null
  radius: 100000
  length: 15000000

  constructor: ->
    red = @makePointy 0xff0000
    yellow = @makePointy 0xffff00
    blue = @makePointy 0x0000ff

    red.rotation.z -= Math.PI / 2
    red.position.x += @length / 2

    blue.rotation.x += Math.PI / 2
    blue.position.z += @length / 2

    yellow.position.y += @length / 2 

    @mesh = new THREE.Object3D
    @mesh.add(yellow)
    @mesh.add(blue)
    @mesh.add(red)

    @mesh 

  makePointy: (color) ->
    color = new THREE.Color(color)
    emissive = color.clone().multiplyScalar(0.33)
    geo = new THREE.CylinderGeometry(0, @radius, @length)
    mat = new THREE.MeshLambertMaterial(
      color:    color,
      emissive: emissive
    )
    new THREE.Mesh(geo, mat)

  animate: (delta) ->

  simulate: (delta) ->
    



