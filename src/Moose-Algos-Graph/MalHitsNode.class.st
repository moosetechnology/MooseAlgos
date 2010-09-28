Class {
	#name : #MalHitsNode,
	#superclass : #MalGraphNode,
	#traits : 'MATNodeNode',
	#classTraits : 'MATNodeNode classTrait',
	#instVars : [
		'previousNodes',
		'nextNodes',
		'auth',
		'hub'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #accessing }
MalHitsNode >> auth [
	^ auth
]

{ #category : #accessing }
MalHitsNode >> auth: anObject [
	auth := anObject
]

{ #category : #accessing }
MalHitsNode >> hub [
	^ hub
]

{ #category : #accessing }
MalHitsNode >> hub: anObject [
	hub := anObject
]

{ #category : #accessing }
MalHitsNode >> initialize [

	previousNodes := OrderedCollection new.
	nextNodes := OrderedCollection new.
]

{ #category : #printing }
MalHitsNode >> label [

	^ 'H '
]

{ #category : #accessing }
MalHitsNode >> nextNodes [
	^ nextNodes
]

{ #category : #accessing }
MalHitsNode >> previousNodes [
	^ previousNodes
]

{ #category : #printing }
MalHitsNode >> printString [

	^ 	'(',
		self model printString,
		' ',
		(self auth printShowingDecimalPlaces: 2),
		' ',
		(self hub printShowingDecimalPlaces: 2),
		') '
]
