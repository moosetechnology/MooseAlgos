# MooseAlgos

Moose Algos contains generic libraries for various analysis algorithms.

## Install MooseAlgo 

To install MooseAlgo on your Pharo image you can just execute the following script:

```Smalltalk
    Metacello new
    	githubUser: 'pharo-contributions' project: 'MooseAlgo' commitish: 'master' path: 'src';
    	baseline: 'MooseAlgo';
    	load
```

To add MooseAlgo to your baseline just add this:

```Smalltalk
    spec
    	baseline: 'MooseAlgo'
    	with: [ spec repository: 'github://pharo-contributions/MooseAlgo:master/src' ]
```

Note that you can replace the #master by another branch as #development or a tag as #v1.0.0, #v1.? or #v1.2.? .

## Graph algorithms
- [Breadth-first search (BFS)](https://en.wikipedia.org/wiki/Breadth-first_search)
- [Dijkstra's algorithm](https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm)
- [Disjoint sets](https://en.wikipedia.org/wiki/Disjoint-set_data_structure)
- Dominance
- Graph reducer
- Graph structure 
- Hits
  - Weighted hits
- [Kruskal algorithm](https://en.wikipedia.org/wiki/Kruskal%27s_algorithm)
- Longest path 
- [Strongly connected components extractor](https://en.wikipedia.org/wiki/Strongly_connected_component)
- [Tarjan algorithm](https://en.wikipedia.org/wiki/Tarjan%27s_strongly_connected_components_algorithm)
  - Cycles coverate
  - HAL
- [Topological sorting](https://en.wikipedia.org/wiki/Topological_sorting)
- Hierarchical graphs

### Example: 
```Smalltalk
dijkstra := MalDijkstra new.
nodes := $a to: $h.
edges := #(($a $b) ($b $a) ($b $c) ($b $d) ($c $d) ($c $f) 
           ($d $b) ($d $e) ($e $a) ($f $g) ($g $h) ($h $g)).
dijkstra nodes: nodes.
dijkstra edges: edges from: #first to: #second.
dijkstra runFrom: $a to: $h
```
## Clustering

see https://en.wikipedia.org/wiki/Hierarchical_clustering

- [complete linkage](https://en.wikipedia.org/wiki/Complete-linkage_clustering)
- single linkage
- average linkage
- centroid
- [Wards method](https://en.wikipedia.org/wiki/Ward%27s_method)

### Example:
```Smalltalk
	input := #(#(1 2 3 5) #(11 12 15) #(21 22 23 25) #(31 32 35) #(41 42 43 45 47)).
	clusty := MalClusterEngine with: input flatten shuffle.
	clusty hierarchicalClusteringUsing: #centroid.
	clusters := clusty dendrogram breakInto: 5.
```

## Word compacting

### Example: 
```Smalltalk
	(MalKontractor reduce: 'Hello' upTo: 3) >>> 'Hlo'
```
## Latice
### Example
```Smalltalk
	data := #(#(#Cat #(#fourlegs #hair)) 
	  #(#Dog #(#smart #fourlegs #hair)) 
	  #(#Dolphin #(#smart #marine)) 
	  #(#Gibbon #(#hair #smart #thumbed)) 
	  #(#Man #(#smart #thumbed)) 
	  #(#Whale #(#smart #marine))).
	formalContext := MalFormalContext new.
	formalContext with: data using: #first using: #last.
	lattice := MalLattice on: formalContext.
	patterns := MalLatticePatterns on: lattice.
	patterns grey "
		N {{#Dog, #Dolphin, #Gibbon, #Man, #Whale}, {#smart}} 
		N {{#Cat, #Dog, #Gibbon}, {#hair}}"
```	
## Linear algebra

- operations with matrices


## Version management 

This project use semantic versionning to define the releases. This mean that each stable release of the project will get associate a version number of the form `vX.Y.Z`. 

- **X** define the major version number
- **Y** define the minor version number 
- **Z** define the patch version number

When a release contains only bug fixes, the patch number increase. When the release contains new features backward compatibles, the minor version increase. When the release contains breaking changes, the major version increase. 

Thus, it should be safe to depend on a fixed major version and moving minor version of this project.
