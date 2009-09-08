Class {
	#name : #MOTarjanNode,
	#superclass : #MOGraphNode,
	#instVars : [
		'nextNodes',
		'index',
		'lowlink',
		'inStack',
		'cycleNodes'
	],
	#category : #'MooseAlgos-Graph'
}

{ #category : #accessing }
MOTarjanNode >> cycleNodes [
	^ cycleNodes
]

{ #category : #accessing }
MOTarjanNode >> cycleNodes: anObject [
	cycleNodes := anObject copy remove: self ; yourself
]

{ #category : #accessing }
MOTarjanNode >> inStack [
	^ inStack
]

{ #category : #accessing }
MOTarjanNode >> inStack: anObject [
	inStack := anObject
]

{ #category : #accessing }
MOTarjanNode >> initialize [
	nextNodes := Set new.
	index := -1.
	inStack := false
]

{ #category : #accessing }
MOTarjanNode >> isInCycle [

	^ self cycleNodes isEmpty not
]

{ #category : #accessing }
MOTarjanNode >> isTarjanUndefined [

	^ index = -1
]

{ #category : #accessing }
MOTarjanNode >> label [

	^ 'T '
]

{ #category : #accessing }
MOTarjanNode >> nextNodes [

	^ nextNodes
]

{ #category : #accessing }
MOTarjanNode >> popped [

	self inStack: false
]

{ #category : #accessing }
MOTarjanNode >> tarjanIndex [
	^ index
]

{ #category : #accessing }
MOTarjanNode >> tarjanIndex: anInteger [
	index := anInteger
]

{ #category : #accessing }
MOTarjanNode >> tarjanLowlink [
	^ lowlink
]

{ #category : #accessing }
MOTarjanNode >> tarjanLowlink: anInteger [
	lowlink := anInteger
]

{ #category : #accessing }
MOTarjanNode >> to: aNode [

	nextNodes add: aNode
]
