Class {
	#name : #MANextNode,
	#superclass : #MODisjointSetNode,
	#traits : 'MATNodeNode - {#from:. #previousNodes}',
	#classTraits : 'MATNodeNode classTrait',
	#instVars : [
		'nextNodes'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #accessing }
MANextNode >> initialize [

	self flag: #refactor.
	self makeSet. "should be called in super initialize"
	nextNodes := OrderedCollection new
]

{ #category : #accessing }
MANextNode >> nextNodes [

	^ nextNodes 
]
