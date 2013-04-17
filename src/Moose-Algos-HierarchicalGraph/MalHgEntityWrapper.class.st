Class {
	#name : #MalHgEntityWrapper,
	#superclass : #Object,
	#instVars : [
		'entity'
	],
	#category : #'Moose-Algos-HierarchicalGraph'
}

{ #category : #accessing }
MalHgEntityWrapper >> entity [
	^ entity
]

{ #category : #accessing }
MalHgEntityWrapper >> entity: anEntity [
	entity := anEntity
]
