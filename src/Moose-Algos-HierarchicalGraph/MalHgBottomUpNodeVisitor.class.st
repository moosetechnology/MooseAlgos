Class {
	#name : #MalHgBottomUpNodeVisitor,
	#superclass : #Object,
	#instVars : [
		'tasks',
		'hg'
	],
	#category : #'Moose-Algos-HierarchicalGraph'
}

{ #category : #'instance creation' }
MalHgBottomUpNodeVisitor class >> on: hg [
	^ self new hg: hg; yourself.
]

{ #category : #accessing }
MalHgBottomUpNodeVisitor >> addTask: aTask [
	tasks add: aTask
]

{ #category : #accessing }
MalHgBottomUpNodeVisitor >> addTasks: aCollectionOfTask [
	aCollectionOfTask do: [ :t | tasks add: t ].
	
]

{ #category : #'initialize-release' }
MalHgBottomUpNodeVisitor >> finishTasks [
	tasks do: [ :t | t finish ].
]

{ #category : #visiting }
MalHgBottomUpNodeVisitor >> go [
	| currLevel nodes |
	
	tasks ifNotEmpty: [ 
	
		"Starting at the bottom, then going up level by level."
		currLevel := hg deepestLevel.
	
		[ currLevel >= 0 ] whileTrue: [ 
			nodes := hg level: currLevel.
			nodes do: [ :n | self visiting: n ].
			currLevel := currLevel - 1.
		].

		self finishTasks.
	].
]

{ #category : #accessing }
MalHgBottomUpNodeVisitor >> hg [
	^ hg
]

{ #category : #accessing }
MalHgBottomUpNodeVisitor >> hg: anObject [
	hg := anObject
]

{ #category : #'initialize-release' }
MalHgBottomUpNodeVisitor >> initialize [
	tasks := OrderedCollection new.
]

{ #category : #accessing }
MalHgBottomUpNodeVisitor >> tasks [
	^ tasks
]

{ #category : #visiting }
MalHgBottomUpNodeVisitor >> visiting: aNode [
	tasks do: [ :t | t visit: aNode ].
]
