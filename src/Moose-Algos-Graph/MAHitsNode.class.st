Class {
	#name : #MAHitsNode,
	#superclass : #MAGraphNode,
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
MAHitsNode >> auth [
	^ auth
]

{ #category : #accessing }
MAHitsNode >> auth: anObject [
	auth := anObject
]

{ #category : #accessing }
MAHitsNode >> hub [
	^ hub
]

{ #category : #accessing }
MAHitsNode >> hub: anObject [
	hub := anObject
]

{ #category : #accessing }
MAHitsNode >> initialize [

	previousNodes := OrderedCollection new.
	nextNodes := OrderedCollection new.
]

{ #category : #printing }
MAHitsNode >> label [

	^ 'H '
]

{ #category : #accessing }
MAHitsNode >> nextNodes [
	^ nextNodes
]

{ #category : #accessing }
MAHitsNode >> previousNodes [
	^ previousNodes
]

{ #category : #printing }
MAHitsNode >> printString [

	^ 	'(',
		self model printString,
		' ',
		(self auth printShowingDecimalPlaces: 2),
		' ',
		(self hub printShowingDecimalPlaces: 2),
		') '
]
