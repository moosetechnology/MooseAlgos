Class {
	#name : #MalGraphGeneratorExampleHelper,
	#superclass : #Object,
	#instVars : [
		'canvas'
	],
	#category : #'Moose-Algos-Graph-Generators-Examples-Helper'
}

{ #category : #public }
MalGraphGeneratorExampleHelper >> animatedLayout [

	| layout |
	layout := RSForceBasedLayout new
		          nodes: canvas nodes;
		          edges: canvas edges;
		          start;
		          yourself.
	canvas nodes @ (RSDraggableForce new layout: layout).
	canvas newAnimation repeat onStepDo: [ :t | 
		layout step.
		canvas zoomToFit ]
]

{ #category : #building }
MalGraphGeneratorExampleHelper >> buildEdgesFor: graphEdges inCanvas: canvas [

	| edges |
	edges := RSEdgeBuilder line
		         canvas: canvas;
		         color: (Color red alpha: 0.5);
		         source: graphEdges connectFrom: #from to: #to.
	edges do: [ :e | e pushBack ]
]

{ #category : #public }
MalGraphGeneratorExampleHelper >> fixedLayout [

	| layout |
	layout := RSGridLayout new
		          nodes: canvas nodes;
		          edges: canvas edges;
		          yourself
]

{ #category : #public }
MalGraphGeneratorExampleHelper >> gridLayout: anInteger [

	RSGridLayout new
		lineItemsCount: anInteger;
		on: canvas nodes;
		yourself
]

{ #category : #initialization }
MalGraphGeneratorExampleHelper >> initialize [

	super initialize.
	canvas := RSCanvas new
]

{ #category : #public }
MalGraphGeneratorExampleHelper >> nodes: graphNodes edges: graphEdges [

	canvas addAll: (self shapesFor: graphNodes).
	self buildEdgesFor: graphEdges inCanvas: canvas
]

{ #category : #public }
MalGraphGeneratorExampleHelper >> run [

	canvas @ RSCanvasController.
	canvas zoomToFit.
	canvas open
]

{ #category : #building }
MalGraphGeneratorExampleHelper >> shape [

	^ (RSEllipse new
		   color: (Color purple alpha: 0.3);
		   size: 10)
		  @ RSDraggable;
		  yourself
]

{ #category : #building }
MalGraphGeneratorExampleHelper >> shapesFor: graphNodes [

	^ RSGroup newFrom:
		  (graphNodes collect: [ :node | self shape model: node ])
]
