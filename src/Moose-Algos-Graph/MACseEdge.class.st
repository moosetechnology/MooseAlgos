Class {
	#name : #MACseEdge,
	#superclass : #MADijkstraEdge,
	#instVars : [
		'cseVisited'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #accessing }
MACseEdge >> cseVisited [
	^ cseVisited
]

{ #category : #accessing }
MACseEdge >> cseVisited: aBoolean [
	cseVisited := aBoolean
]

{ #category : #initialization }
MACseEdge >> initialize [ 

	super initialize.
	self cseVisited: false.
]
