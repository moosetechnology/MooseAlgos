Class {
	#name : #MalSndNode,
	#superclass : #MalGraphNode,
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
MalSndNode >> bfsAncestor [
	^ bfsAncestor
]

{ #category : #accessing }
MalSndNode >> bfsAncestor: anObject [
	bfsAncestor := anObject
]

{ #category : #'initialize-release' }
MalSndNode >> initialize [

	previousNodes := OrderedCollection new.
	nextNodes := OrderedCollection new.
]

{ #category : #accessing }
MalSndNode >> nextNodes [
	^ nextNodes
]

{ #category : #accessing }
MalSndNode >> nextNodes: anObject [
	nextNodes := anObject
]

{ #category : #accessing }
MalSndNode >> previousNodes [
	^ previousNodes
]

{ #category : #accessing }
MalSndNode >> previousNodes: anObject [
	previousNodes := anObject
]

{ #category : #accessing }
MalSndNode >> visited [
	^ visited
]

{ #category : #accessing }
MalSndNode >> visited: anObject [
	visited := anObject
]
