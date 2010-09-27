Class {
	#name : #MADijkstraNode,
	#superclass : #MAGraphNode,
	#traits : 'MATEdgeNode',
	#classTraits : 'MATEdgeNode classTrait',
	#instVars : [
		'pathWeight',
		'previousEdges',
		'nextEdges',
		'previousNodes'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #accessing }
MADijkstraNode >> from: aNode edge: anEdge [

	self previousNodes add: aNode.
	self previousEdges add: anEdge
]

{ #category : #initialization }
MADijkstraNode >> initialize [

	previousNodes := OrderedCollection new.
	previousEdges := OrderedCollection new.
	nextEdges := OrderedCollection new.
	pathWeight := Float infinity "initialization for Dijsktra"
]

{ #category : #accessing }
MADijkstraNode >> nextEdges [

	^ nextEdges
]

{ #category : #accessing }
MADijkstraNode >> pathWeight [
	^ pathWeight
]

{ #category : #accessing }
MADijkstraNode >> pathWeight: anObject [
	pathWeight := anObject
]

{ #category : #accessing }
MADijkstraNode >> previousEdges [

	^ previousEdges
]

{ #category : #accessing }
MADijkstraNode >> previousNodes [

	^ previousNodes
]
