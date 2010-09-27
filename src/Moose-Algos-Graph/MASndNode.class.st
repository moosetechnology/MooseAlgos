Class {
	#name : #MASndNode,
	#superclass : #MAGraphNode,
	#traits : 'MATNodeNode',
	#classTraits : 'MATNodeNode classTrait',
	#instVars : [
		'previousNodes',
		'nextNodes',
		'visited',
		'bfsAncestor'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #accessing }
MASndNode >> bfsAncestor [
	^ bfsAncestor
]

{ #category : #accessing }
MASndNode >> bfsAncestor: anObject [
	bfsAncestor := anObject
]

{ #category : #'initialize-release' }
MASndNode >> initialize [

	previousNodes := OrderedCollection new.
	nextNodes := OrderedCollection new.
]

{ #category : #accessing }
MASndNode >> nextNodes [
	^ nextNodes
]

{ #category : #accessing }
MASndNode >> nextNodes: anObject [
	nextNodes := anObject
]

{ #category : #accessing }
MASndNode >> previousNodes [
	^ previousNodes
]

{ #category : #accessing }
MASndNode >> previousNodes: anObject [
	previousNodes := anObject
]

{ #category : #accessing }
MASndNode >> visited [
	^ visited
]

{ #category : #accessing }
MASndNode >> visited: anObject [
	visited := anObject
]
