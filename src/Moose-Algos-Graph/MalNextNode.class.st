Class {
	#name : #MalNextNode,
	#superclass : #MalDisjointSetNode,
	#traits : 'MATNodeNode - {#from:. #previousNodes}',
	#classTraits : 'MATNodeNode classTrait',
	#instVars : [
		'nextNodes'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #accessing }
MalNextNode >> initialize [

	self flag: #refactor.
	self makeSet. "should be called in super initialize"
	nextNodes := OrderedCollection new
]

{ #category : #accessing }
MalNextNode >> nextNodes [

	^ nextNodes 
]
