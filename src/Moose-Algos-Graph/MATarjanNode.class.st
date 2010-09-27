Class {
	#name : #MATarjanNode,
	#superclass : #MAGraphNode,
	#instVars : [
		'nextNodes',
		'index',
		'lowlink',
		'inStack',
		'cycleNodes'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #accessing }
MATarjanNode >> cycleNodes [
	^ cycleNodes
]

{ #category : #accessing }
MATarjanNode >> cycleNodes: anObject [
	cycleNodes := anObject copy remove: self ; yourself
]

{ #category : #accessing }
MATarjanNode >> inStack [
	^ inStack
]

{ #category : #accessing }
MATarjanNode >> inStack: anObject [
	inStack := anObject
]

{ #category : #accessing }
MATarjanNode >> initialize [
	nextNodes := Set new.
	index := -1.
	inStack := false
]

{ #category : #accessing }
MATarjanNode >> isInCycle [

	^ self cycleNodes isEmpty not
]

{ #category : #accessing }
MATarjanNode >> isTarjanUndefined [

	^ index = -1
]

{ #category : #accessing }
MATarjanNode >> label [

	^ 'T '
]

{ #category : #accessing }
MATarjanNode >> nextNodes [

	^ nextNodes
]

{ #category : #accessing }
MATarjanNode >> popped [

	self inStack: false
]

{ #category : #accessing }
MATarjanNode >> tarjanIndex [
	^ index
]

{ #category : #accessing }
MATarjanNode >> tarjanIndex: anInteger [
	index := anInteger
]

{ #category : #accessing }
MATarjanNode >> tarjanLowlink [
	^ lowlink
]

{ #category : #accessing }
MATarjanNode >> tarjanLowlink: anInteger [
	lowlink := anInteger
]

{ #category : #accessing }
MATarjanNode >> to: aNode [

	nextNodes add: aNode
]
