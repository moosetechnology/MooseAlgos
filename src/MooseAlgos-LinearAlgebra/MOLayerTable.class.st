Class {
	#name : #MOLayerTable,
	#superclass : #Object,
	#instVars : [
		'layers',
		'orderedNodes',
		'cellSize',
		'cellPadding',
		'textLabel'
	],
	#category : #'MooseAlgos-DependencyTable'
}

{ #category : #drawing }
MOLayerTable >> addDependencyColumnFor: node view: view rows: nbRows [ 
	| depLayers maxCells |
	depLayers := SmallDictionary new.
	1 to: nbRows do: [:i| 
		depLayers at: i put: OrderedCollection new ].
	node nextNodes do: [ :next | (depLayers at: next layer) add: next ].
	(depLayers at: node layer) add: node.

	maxCells := (depLayers detectMax: [ :l | l size ]) size.
	view shape: (self enclosingShapeFor: maxCells).
	view nodes: depLayers forEach: [:dlayer| 
		dlayer isEmpty
		ifTrue: [
			view shape: self whiteShape.
			view node: #void ]
		ifFalse: [
			view interaction popupText: [:n | textLabel moValue: n].
			view shape: (self cellShapeWithSource: node).
			view nodes: dlayer ].
		view layout: (MOHorizontalLineLayout new gapSize: (self cellPadding // 2))
	]
]

{ #category : #sample }
MOLayerTable >> applyDefaultBorderColorStrategy [

	| queue tarjan color |
	queue := MOCircularColors new.
	tarjan := MOTarjan new.
	tarjan nodes: self nodes.
	tarjan edges: self edges from: #first to: #second.
	tarjan run.
	
	"this is a hack: temporarily nilling all bordercolors"
	self nodes do: [:n|
		n borderColor: nil ].
	
	tarjan nodes do: [:n|
		n isInCycle
			ifTrue: [
				n model borderColor ifNil: [
					color := queue nextColor.
					n model borderColor: color.
					n cycleNodes do: [:cn| 
						cn model borderColor: color ]
					]]
			ifFalse: [ "reset default color"
				n model borderColor: Color black]
	]
]

{ #category : #sample }
MOLayerTable >> applyDefaultFillColorStrategy [

	| queue previousCounts count fanin fanout |
	queue := MOCircularColors new.

	"dumb way to count incoming dependencies.
	remember, it's just a sample"
	previousCounts := SmallDictionary new.
	self nodes do: [:node|
		previousCounts at: node ifAbsentPut: 0.
		node nextNodes do: [:next|
			count := previousCounts at: next ifAbsentPut: 0.
			previousCounts at: next put: count + 1 ]
		].

	self nodes do: [:node|
		fanin := (previousCounts at: node).
		fanout := node nextNodes size.
		((fanin > 0 and: [fanout >0]) or: [fanin > 1]) ifTrue: [
			node fillColor: (queue nextColor alpha: 0.5) ]
	]
]

{ #category : #drawing }
MOLayerTable >> applyDefaultNodes [

	orderedNodes := self nodes
]

{ #category : #sample }
MOLayerTable >> applyDominanceFillColorStrategy [

	| queue dom dominantColors color |
	queue := MOCircularColors new.

	dom := MODominance new.
	dom nodes: self nodes.
	dom edges: self edges from: #first to: #second.
	dom run.

	dominantColors := SmallDictionary new.
	dom nodes do: [:node|
		node isDominant ifTrue: [
			color := dominantColors at: node ifAbsentPut: (queue nextColor alpha: 0.5).
			node model fillColor: color.
		].
		node isDominated ifTrue: [
			color := dominantColors at: node dominantNode ifAbsentPut: (queue nextColor alpha: 0.5).
			node model fillColor: color.
		]
	]
]

{ #category : #drawing }
MOLayerTable >> applySimilarityNodes [

	orderedNodes := MOLayerTableOrganizer new initializeNodeOrderWith: self nodes
]

{ #category : #accessing }
MOLayerTable >> cellPadding [
	^ cellPadding
]

{ #category : #accessing }
MOLayerTable >> cellPadding: anObject [
	cellPadding := anObject
]

{ #category : #drawing }
MOLayerTable >> cellShapeWithSource: sNode [

	^ MOFixedRectangleShape new
			size: self cellSize;
			borderWidth: [:n| n = sNode ifTrue: [3] ifFalse: [1]];
			borderColor: [:n| n borderColor];
			fillColor: [:n| n fillColor];
			text: [:n| textLabel moValue: n]
]

{ #category : #accessing }
MOLayerTable >> cellSize [

	^ cellSize
]

{ #category : #accessing }
MOLayerTable >> cellSize: anInteger [

	cellSize := anInteger
]

{ #category : #sample }
MOLayerTable >> edges [

	^ self nodes 	inject: OrderedCollection new
					into: [:c :n| n nextNodes do: [:t| c add: {n. t}]. c]
]

{ #category : #drawing }
MOLayerTable >> enclosingShapeFor: nbCells [

	^ MOFixedRectangleShape new
			borderColor: Color lightGray;
			height: self cellSize + self cellPadding;
			width: nbCells * (self cellSize + self cellPadding)
]

{ #category : #accessing }
MOLayerTable >> initialize [

	cellSize := 30.
	cellPadding := 10.
	textLabel := [:node| node model asString].
]

{ #category : #accessing }
MOLayerTable >> layers [
	^ layers
]

{ #category : #accessing }
MOLayerTable >> layers: anObject [
	layers := anObject
]

{ #category : #accessing }
MOLayerTable >> nodes [

	^ layers inject: OrderedCollection new into: [:c :layer| c addAll: layer. c]
]

{ #category : #drawing }
MOLayerTable >> render [

	| view |
	view := MOViewRenderer new.
	self renderOn: view.
	view open.
]

{ #category : #drawing }
MOLayerTable >> renderOn: view [ 
	| nbRows |
	
	nbRows := layers size.
	orderedNodes ifNil: [self applyDefaultNodes].
	
	view node: #layers forIt: [
		view shape: ((self enclosingShapeFor: 1)
									text: [:l| l value size printString]).
		view nodes: layers associations.
		view verticalLineLayout gapSize: -1.
	].
	
	orderedNodes do: [ :node | 
		node nextNodes isEmpty ifFalse: [
			view node: node forIt: [
				self addDependencyColumnFor: node view: view rows: nbRows.
				view verticalLineLayout gapSize: -1]]
	].
	view horizontalLineLayout gapSize: 0.
]

{ #category : #sample }
MOLayerTable >> renderSample [
	"self new renderSample"

	self renderSampleWith: #applyDefaultFillColorStrategy.
]

{ #category : #sample }
MOLayerTable >> renderSampleWith: fillColorStrategy [
	"
	self new renderSampleWith: #applyDefaultFillColorStrategy.
	self new renderSampleWith: #applyDominanceFillColorStrategy.
	"

	self layers: self sample.
	fillColorStrategy moValue: self.
	self applyDefaultBorderColorStrategy.
	self applySimilarityNodes.
	self render
]

{ #category : #sample }
MOLayerTable >> sample [

	| graph layers |
	graph := MOGraphStructure new nodeClass: MOLayerNode.
	MOGraphFixture dependencyGraph: graph.
	layers := SmallDictionary new.
	#(1 2 3 4) do: [:i| layers at: i put: OrderedCollection new].
	#($a $d) do: [:n| (layers at: 1) add: ((graph findNode: n) layer: 1)].
	#($b $e $g) do: [:n| (layers at: 2) add: ((graph findNode: n) layer: 2)].
	#($c $f $h $i) do: [:n| (layers at: 3) add: ((graph findNode: n) layer: 3)].
	#($k $j) do: [:n| (layers at: 4) add: ((graph findNode: n) layer: 4)].
	^ layers
]

{ #category : #accessing }
MOLayerTable >> textLabel [
	^ textLabel
]

{ #category : #accessing }
MOLayerTable >> textLabel: anObject [
	textLabel := anObject
]

{ #category : #drawing }
MOLayerTable >> whiteShape [
	^ MOFixedRectangleShape new
			size: self cellSize;
			borderColor: Color white
]
