Class {
	#name : #MAHalNode,
	#superclass : #MATarjanNode,
	#instVars : [
		'hNumber',
		'previousNodes'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #accessing }
MAHalNode >> from: aHalNode [

	previousNodes add: aHalNode
]

{ #category : #accessing }
MAHalNode >> hNumber [
	^ hNumber
]

{ #category : #accessing }
MAHalNode >> hNumber: anObject [
	hNumber := anObject
]

{ #category : #initialization }
MAHalNode >> initialize [
	
	super initialize.
	previousNodes := Set new.

]

{ #category : #testing }
MAHalNode >> isSink [

	^ self nextNodes isEmpty 
]

{ #category : #testing }
MAHalNode >> isSource [

	^ self previousNodes isEmpty 
]

{ #category : #'hal-algorithm' }
MAHalNode >> label [

	^ 'Ha '
]

{ #category : #'hal-algorithm' }
MAHalNode >> markCycleWith: anInteger [

	self cycleNodes do: [ :next | next hNumber: anInteger ].
	^ self cycleNodes 
]

{ #category : #'hal-algorithm' }
MAHalNode >> markHNumber: anInteger [

	self hNumber: anInteger.
	self isInCycle ifTrue: [
		^ self markCycleWith: anInteger
	].
	^ OrderedCollection new
]

{ #category : #accessing }
MAHalNode >> previousNodes [
	^ previousNodes
]

{ #category : #accessing }
MAHalNode >> previousNodes: anObject [
	previousNodes := anObject
]

{ #category : #'hal-algorithm' }
MAHalNode >> removeCycleFromEdges [

	self nextNodes removeAllFoundIn: self cycleNodes.
	self previousNodes removeAllFoundIn: self cycleNodes 
]
