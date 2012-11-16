Class {
	#name : #MalKontractorTest,
	#superclass : #TestCase,
	#category : #'Moose-Tests-Algos-Kontractor'
}

{ #category : #testing }
MalKontractorTest >> testCutAndContract [
	"self debug: #testCutAndContract"
	
	self assert: ( (MalKontractor new cut: #('Seaside' 'Citezen') contractUpTo:  4) chopWords: 'Citezen-hello') = '-hello'.
	self assert: ( (MalKontractor new cut: #('Seaside' 'Citezen') contractUpTo:  4) chopWords: 'Citezen-hello-Seaside') = '-hello-'.

]

{ #category : #testing }
MalKontractorTest >> testFrequency [

	self assert: ( (MalKontractor toSize: 3) letterFrequency: 'h') = 0.737.
]

{ #category : #testing }
MalKontractorTest >> testNew [ 
	|k|
	k := MalKontractor toSize:  3.
	self assert: k sizeTo = 3 .
]

{ #category : #testing }
MalKontractorTest >> testReduce [
	"self debug: #testReduce"
	
	self assert: ( (MalKontractor toSize:  4) reduce: 'hello') = 'hllo'.
	self assert: ( (MalKontractor toSize:  3) reduce: 'hello') = 'hlo'.
	self assert: ( (MalKontractor toSize:  3) reduce: 'hell!-o') = 'hlo'.
]

{ #category : #testing }
MalKontractorTest >> testReduceInPresenceOfChop [
	"self debug: #testReduceInPresenceOfChop"
	
	self assert: ( (MalKontractor new cut: #('Seaside') contractUpTo:  4) reduce: 'SeasidehelloSeaside') = 'hllo'.
	
]

{ #category : #testing }
MalKontractorTest >> testReduceInPresenceOfSpace [
	"self debug: #testReduceInPresenceOfSpace"
	self assert: ( MalKontractor reduce: 'hello world' upTo: 6) = 'howold'. 
	self assert: ( MalKontractor reduce: 'hello world' upTo: 5) = 'howod'. 
	
]

{ #category : #testing }
MalKontractorTest >> testReduceUnknownCharacter [
	"self debug: #testReduce"
	
	"J is not in the map."
	self assert: ( (MalKontractor toSize:  4) reduce: 'Jieiei') =  'Jiii' .
	self assert: ( (MalKontractor toSize:  4) reduce: 'Jieieriz') =  'iiiz'.
	self assert: ( (MalKontractor toSize:  4) reduce: 'Jieierjg') = 'iirg'  
	
]

{ #category : #testing }
MalKontractorTest >> testRemoveOne [

	self assert: ( (MalKontractor toSize:  3 ) removeOne: 'hello') = 'hllo'.
	self assert: ( (MalKontractor toSize:  3 ) removeOne: 'hllo') = 'hlo'.
]
