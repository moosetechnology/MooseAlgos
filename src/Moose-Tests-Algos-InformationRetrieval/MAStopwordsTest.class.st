"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MAStopwordsTest,
	#superclass : #TestCase,
	#instVars : [
		'sw'
	],
	#category : #'Moose-Tests-Algos-InformationRetrieval'
}

{ #category : #running }
MAStopwordsTest >> testFewWords [
	
	sw := MAStopwords fromString: 'and the super of a'.
	self assert: sw size = 5.
	^sw
]

{ #category : #running }
MAStopwordsTest >> testIncludesFalse [
	
	sw := MAStopwords fromString: 'and the super of a'.
	self assert: (sw includes: 'A') not.
	self assert: (sw includes: 'offer') not.
	self assert: (sw includes: '') not.
	self assert: (sw includes: 'object') not.
	self assert: (sw includes: nil) not.
	^sw
]

{ #category : #running }
MAStopwordsTest >> testIncludesTrue [
	
	sw := MAStopwords fromString: 'and the super of a'.
	self assert: (sw includes: 'a').
	self assert: (sw includes: 'of').
	self assert: (sw includes: 'and').
	self assert: (sw includes: 'the').
	self assert: (sw includes: 'super').
	^sw
]
