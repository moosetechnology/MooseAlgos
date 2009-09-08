Class {
	#name : #MODisjointSetNode,
	#superclass : #MOGraphNode,
	#instVars : [
		'parent'
	],
	#category : #'MooseAlgos-Graph'
}

{ #category : #accessing }
MODisjointSetNode >> find [

	^ (self = parent) ifTrue: [ self ]
					ifFalse: [ parent find ]
]

{ #category : #accessing }
MODisjointSetNode >> label [

	^ 'DSN '
]

{ #category : #accessing }
MODisjointSetNode >> makeSet [

	parent := self
]

{ #category : #'private-accessing' }
MODisjointSetNode >> parent [
	^ parent
]

{ #category : #'private-accessing' }
MODisjointSetNode >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
MODisjointSetNode >> union: aDSNode [

	aDSNode find parent: self find
]
