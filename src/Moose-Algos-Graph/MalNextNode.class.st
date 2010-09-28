Class {
	#name : #MalNextNode,
	#superclass : #MalDisjointSetNode,
	#traits : 'MalTNodeNode - {#from:. #previousNodes}',
	#classTraits : 'MalTNodeNode classTrait',
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
