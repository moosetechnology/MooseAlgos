"
NullStemmer does not stem words, ie null-operation.

Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MANullStemmer,
	#superclass : #MAStemmer,
	#category : #'Moose-Algos-InformationRetrieval'
}

{ #category : #'private-algorithm' }
MANullStemmer >> performStemming: aString [
	
	^aString
]
