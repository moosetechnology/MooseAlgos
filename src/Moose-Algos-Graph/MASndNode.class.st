Class {
	#name : #MASndNode,
	#superclass : #MOGraphNode,
	#instVars : [
		'ancestors',
		'visited',
		'bfsAncestor'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #accessing }
MASndNode >> ancestors [
	^ ancestors
]

{ #category : #accessing }
MASndNode >> ancestors: anObject [
	ancestors := anObject
]

{ #category : #accessing }
MASndNode >> bfsAncestor [
	^ bfsAncestor
]

{ #category : #accessing }
MASndNode >> bfsAncestor: anObject [
	bfsAncestor := anObject
]

{ #category : #accessing }
MASndNode >> visited [
	^ visited
]

{ #category : #accessing }
MASndNode >> visited: anObject [
	visited := anObject
]
