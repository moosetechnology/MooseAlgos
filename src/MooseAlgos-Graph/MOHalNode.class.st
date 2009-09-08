Class {
	#name : #MOHalNode,
	#superclass : #MOTarjanNode,
	#instVars : [
		'hNumber',
		'previousNodes'
	],
	#category : #'MooseAlgos-Graph'
}

{ #category : #accessing }
MOHalNode >> from: aHalNode [

	previousNodes add: aHalNode
]

{ #category : #accessing }
MOHalNode >> hNumber [
	^ hNumber
]

{ #category : #accessing }
MOHalNode >> hNumber: anObject [
	hNumber := anObject
]

{ #category : #initialization }
MOHalNode >> initialize [
	
	super initialize.
	previousNodes := Set new.

]

{ #category : #testing }
MOHalNode >> isSink [

	^ self nextNodes isEmpty 
]

{ #category : #testing }
MOHalNode >> isSource [

	^ self previousNodes isEmpty 
]

{ #category : #'hal-algorithm' }
MOHalNode >> label [

	^ 'Ha '
]

{ #category : #'hal-algorithm' }
MOHalNode >> markCycleWith: anInteger [

	self cycleNodes do: [ :next | next hNumber: anInteger ].
	^ self cycleNodes 
]

{ #category : #'hal-algorithm' }
MOHalNode >> markHNumber: anInteger [

	self hNumber: anInteger.
	self isInCycle ifTrue: [
		^ self markCycleWith: anInteger
	].
	^ OrderedCollection new
]

{ #category : #accessing }
MOHalNode >> previousNodes [
	^ previousNodes
]

{ #category : #accessing }
MOHalNode >> previousNodes: anObject [
	previousNodes := anObject
]

{ #category : #'hal-algorithm' }
MOHalNode >> removeCycleFromEdges [

	self nextNodes removeAllFoundIn: self cycleNodes.
	self previousNodes removeAllFoundIn: self cycleNodes 
]
