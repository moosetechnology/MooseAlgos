Class {
	#name : #MOCycleEdge,
	#superclass : #MOWeightedEdge,
	#instVars : [
		'color'
	],
	#category : #'MooseAlgos-DependencyTable'
}

{ #category : #accessing }
MOCycleEdge >> = aCycle [

	^ self from = aCycle from and:[self to = aCycle to]
]

{ #category : #accessing }
MOCycleEdge >> color [
	^ color
]

{ #category : #accessing }
MOCycleEdge >> color: anObject [
	color := anObject
]
