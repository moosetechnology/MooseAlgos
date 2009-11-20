Class {
	#name : #MOCycleTable,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'cycles',
		'nodeRows',
		'cycleColumns'
	],
	#category : #'MooseAlgos-DependencyTable'
}

{ #category : #sample }
MOCycleTable class >> cycles [

	^ #((A B C)
		(A B E)
		(C D))
]

{ #category : #sample }
MOCycleTable class >> edges [

	^ #((A B 10)
		(B E 9)
		(B C 4)
		(C A 3)
		(C D 1)
		(D C 1)
		(E A 1))
]

{ #category : #sample }
MOCycleTable class >> nodes [

	^ #(A B C D E)
]

{ #category : #drawing }
MOCycleTable >> cellShape [

	^ self cellShape: 50
]

{ #category : #drawing }
MOCycleTable >> cellShape: size [

	^ MOFixedRectangleShape new size: size
]

{ #category : #drawing }
MOCycleTable >> cellShapeFor: edge borderColor: aColor view: view [

	^ edge ifNotNil: [
		view node: #edge forIt: [view shape: (self edgeCellShapeBorder: aColor fill: edge color). 
									view interaction popupText.
									view node: edge.
									view layout: (MOHorizontalLineLayout new gapSize: 10)].
	] ifNil: [
		view shape: self cellShape.
		view node: #nil.
	]
]

{ #category : #example }
MOCycleTable >> cellShapeFor: edge color: aColor view: view [

	^ edge ifNotNil: [
		view node: #edge forIt: [view shape: (self edgeCellShapeColor: aColor). 
									view interaction popupText.
									view node: edge.
									view layout: (MOHorizontalLineLayout new gapSize: 10)].
	] ifNil: [
		view shape: self cellShape.
		view node: #nil.
	]
]

{ #category : #accessing }
MOCycleTable >> cycleColumns [
	^ cycleColumns
]

{ #category : #accessing }
MOCycleTable >> cycles [
	^ cycles
]

{ #category : #accessing }
MOCycleTable >> cycles: anObject [
	cycles := anObject
]

{ #category : #drawing }
MOCycleTable >> edgeCellShapeBorder: aColor fill: aColor2 [

	| shape |
	shape := (self cellShape: 30) borderColor: aColor; text: [:e | e to model asString, e weight asString].
	aColor2 ifNotNil: [ shape fillColor: aColor2 ].
	^ shape
]

{ #category : #example }
MOCycleTable >> edgeCellShapeColor: aColor [

	^ (self cellShape: 30) borderColor: aColor; text: [:e | e second asString, e third asString]
]

{ #category : #example }
MOCycleTable >> edgesForCycle: cycle [

	| edges |
	edges := OrderedCollection new.
	1 to: (cycle size - 1) do: [ :i|
		edges add: {cycle at: i. cycle at: i+1}
	].
	edges add: {cycle at: cycle size. cycle at: 1}.
	^ edges
]

{ #category : #example }
MOCycleTable >> exampleCycleTable [
	"
	self new exampleCycleTable
	"
	| builder x y columns rows view sample lastRow cells |
	view := MOViewRenderer new.
	builder := MOFormsBuilder new.
	
	sample := self class.
	
	columns := sample cycles.
	columns size + 1 timesRepeat: [ builder column; pref ].
	rows := sample nodes.
	rows size + 1 timesRepeat: [ builder row; pref ].
	cells := sample edges.
	
	x := 1. y := 0.
	rows do:  [ :node | y := y + 1.
		view shape: (self cellShape text: [ :n | n ]).
		builder x: 1 y: y add: (view node: node).
		columns do: [ :cycle | |edge| x := x + 1.
			edge := self getEdgeFrom: cells starting: node inCycle: cycle.
			builder x: x y: y add: (self cellShapeFor: edge color: (Color indexedColors at: x + 3) view: view) ].
		x := 1 ].
	
	lastRow := rows size + 1.
	"view shape: self cellShape."
	view shape: (self cellShape text: [ :n | n ]).
	builder x: 1 y: lastRow add: (view node: #length).
	
	x := 1.
	columns do: [ :cycle | x := x + 1.
		view shape: (self cellShape text: [ :n | n printString ]).		
		builder x: x y: lastRow add: (view node: cycle size).
	].
	view layout: builder asLayout.
	view open
]

{ #category : #example }
MOCycleTable >> getEdgeFrom: edges starting: aNode inCycle: aCycle [

	| e |
	e := (self edgesForCycle: aCycle) detect: [:x| x first = aNode] ifNone: [^ nil].
	^ self getEdgeStarting: e first ending: e second in: edges.
]

{ #category : #example }
MOCycleTable >> getEdgeStarting: aSource ending: aTarget in: edges [

	^ edges detect: [:e| e first = aSource and: [e second = aTarget]]
]

{ #category : #'drawing-initialize' }
MOCycleTable >> initializeRowsAndColumns [
	
	| org |
	org := MOCycleTableOrganizer new.
	org initializeRowsAndColumnsWith: cycles.
	nodeRows := org nodeRows.
	cycleColumns := org cycleColumns

]

{ #category : #accessing }
MOCycleTable >> nodeRows [
	^ nodeRows
]

{ #category : #accessing }
MOCycleTable >> nodes [
	^ nodes
]

{ #category : #accessing }
MOCycleTable >> nodes: anObject [
	nodes := anObject
]

{ #category : #drawing }
MOCycleTable >> render [
	"
	self new cycles: (MOCycleTableTest new setUp); render
	"

	| view |
	view := MOViewRenderer new.
	self renderOn: view.
	view open.
]

{ #category : #drawing }
MOCycleTable >> renderOn: view [

	| builder x y lastRow |
	builder := MOFormsBuilder new.
	
	self initializeRowsAndColumns.
	cycleColumns size + 1 timesRepeat: [ builder column; pref ].
	nodeRows size + 1 timesRepeat: [ builder row; pref ].

	x := 1. y := 0.
	nodeRows do:  [ :node | y := y + 1.
		view shape: (self cellShape text: [ :n | n model asString ]).
		builder x: 1 y: y add: (view node: node).
		cycleColumns do: [ :cycle | |edge| x := x + 1.
			edge := cycle edgeFrom: node.
			builder x: x y: y add: (self cellShapeFor: edge borderColor: (Color indexedColors at: x + 3) view: view) ].
		x := 1 ].
	
	lastRow := nodeRows size + 1.
	view shape: (self cellShape text: [ :n | n ]).
	builder x: 1 y: lastRow add: (view node: #length).
	
	x := 1.
	cycleColumns do: [ :cycle | x := x + 1.
		view shape: (self cellShape text: [ :n | n printString ]).		
		builder x: x y: lastRow add: (view node: cycle length).
	].
	view layout: builder asLayout.
]
