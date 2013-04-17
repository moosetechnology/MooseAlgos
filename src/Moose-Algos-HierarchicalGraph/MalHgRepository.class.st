Class {
	#name : #MalHgRepository,
	#superclass : #Object,
	#classInstVars : [
		'repository'
	],
	#category : #'Moose-Algos-HierarchicalGraph'
}

{ #category : #accessing }
MalHgRepository class >> flush [
	repository := nil.
]

{ #category : #accessing }
MalHgRepository class >> get: aKey [
	^self repository at: aKey.
]

{ #category : #accessing }
MalHgRepository class >> repo [
	^ self repository
]

{ #category : #accessing }
MalHgRepository class >> repository [
	"returns the repository of all created HiGraphs."

	repository isNil
		ifTrue: [ repository := Dictionary new ].
		
	^ repository
]
