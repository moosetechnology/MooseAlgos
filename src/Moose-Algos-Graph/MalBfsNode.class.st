Class {
	#name : #MalBfsNode,
	#superclass : #MalGraphNode,
	#traits : 'MATEdgeNode - {#previousEdges. #from:edge:}',
	#classTraits : 'MATEdgeNode classTrait',
	#instVars : [
		'nextEdges',
		'firstDepth'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #accessing }
MalBfsNode >> firstDepth [
	^ firstDepth
]

{ #category : #accessing }
MalBfsNode >> firstDepth: anObject [
	firstDepth := anObject
]

{ #category : #'as yet unclassified' }
MalBfsNode >> initialize [ 

	nextEdges := OrderedCollection new.

]

{ #category : #'as yet unclassified' }
MalBfsNode >> nextEdges [

	^ nextEdges 
]

{ #category : #accessing }
MalBfsNode >> notVisited [

	firstDepth := nil
]

{ #category : #accessing }
MalBfsNode >> visited [

	^ firstDepth notNil
]
