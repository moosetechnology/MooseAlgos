Class {
	#name : #MADisjointSetNode,
	#superclass : #MAGraphNode,
	#instVars : [
		'parent'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #accessing }
MADisjointSetNode >> find [

	^ (self = parent) ifTrue: [ self ]
					ifFalse: [ parent find ]
]

{ #category : #accessing }
MADisjointSetNode >> label [

	^ 'DSN '
]

{ #category : #accessing }
MADisjointSetNode >> makeSet [

	parent := self
]

{ #category : #'private-accessing' }
MADisjointSetNode >> parent [
	^ parent
]

{ #category : #'private-accessing' }
MADisjointSetNode >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
MADisjointSetNode >> union: aDSNode [

	aDSNode find parent: self find
]
