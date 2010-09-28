Class {
	#name : #MalTarjanNode,
	#superclass : #MalGraphNode,
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
MalTarjanNode >> cycleNodes [
	^ cycleNodes
]

{ #category : #accessing }
MalTarjanNode >> cycleNodes: anObject [
	cycleNodes := anObject copy remove: self ; yourself
]

{ #category : #accessing }
MalTarjanNode >> inStack [
	^ inStack
]

{ #category : #accessing }
MalTarjanNode >> inStack: anObject [
	inStack := anObject
]

{ #category : #accessing }
MalTarjanNode >> initialize [
	nextNodes := Set new.
	index := -1.
	inStack := false
]

{ #category : #accessing }
MalTarjanNode >> isInCycle [

	^ self cycleNodes isEmpty not
]

{ #category : #accessing }
MalTarjanNode >> isTarjanUndefined [

	^ index = -1
]

{ #category : #accessing }
MalTarjanNode >> label [

	^ 'T '
]

{ #category : #accessing }
MalTarjanNode >> nextNodes [

	^ nextNodes
]

{ #category : #accessing }
MalTarjanNode >> popped [

	self inStack: false
]

{ #category : #accessing }
MalTarjanNode >> tarjanIndex [
	^ index
]

{ #category : #accessing }
MalTarjanNode >> tarjanIndex: anInteger [
	index := anInteger
]

{ #category : #accessing }
MalTarjanNode >> tarjanLowlink [
	^ lowlink
]

{ #category : #accessing }
MalTarjanNode >> tarjanLowlink: anInteger [
	lowlink := anInteger
]

{ #category : #accessing }
MalTarjanNode >> to: aNode [

	nextNodes add: aNode
]
