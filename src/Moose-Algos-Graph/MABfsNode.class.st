Class {
	#name : #MABfsNode,
	#superclass : #MAGraphNode,
	#traits : 'MATEdgeNode - {#previousEdges. #from:edge:}',
	#classTraits : 'MATEdgeNode classTrait',
	#instVars : [
		'nextEdges',
		'firstDepth'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #accessing }
MABfsNode >> firstDepth [
	^ firstDepth
]

{ #category : #accessing }
MABfsNode >> firstDepth: anObject [
	firstDepth := anObject
]

{ #category : #'as yet unclassified' }
MABfsNode >> initialize [ 

	nextEdges := OrderedCollection new.

]

{ #category : #'as yet unclassified' }
MABfsNode >> nextEdges [

	^ nextEdges 
]

{ #category : #accessing }
MABfsNode >> notVisited [

	firstDepth := nil
]

{ #category : #accessing }
MABfsNode >> visited [

	^ firstDepth notNil
]
