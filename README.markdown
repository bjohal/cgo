# CGO

CGO is an experimental space simulation web application. It features:

* Gravity
* 3D rendering via WebGL
* Adjustable timescales

## Installation

Install MeteorJS. See http://docs.meteor.com/#quickstart for details.

    curl https://install.meteor.com | /bin/sh

Fetch the code:

    git clone https://github.com/rleemorlang/cgo.git

Start It Up

    cd cgo
    meteor

Point your browser at http://localhost:3000

## Future?

CGO is just an experiment and a learning exercise, but there are lofty 
dreams for it, including:

* Fleshed-out Sol system, with all planets and major satellites
* Simplified (hardcoded) orbits for major planetary bodies to avoid
  orbital destabilization due to poor simulation granularity, rounding errors,
  incorrect data, and bugs
* "Starships" that obey Newtonian physics, which can be player controlled
  or can navigate via their own algorithm
* Server-side simulation, with client-side prediction
* Persistent world. Simulation continues when no client connected.
* Multiple players sharing the same game world
* Procedurally generated solar systems
* Starship algorithms such as navigation exposed as user-editable JavaScript,
  can be modified/forked/shared, to run on server side in secure sandbox
* Game mechanics!


