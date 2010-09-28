Class {
	#name : #MalFormalContext,
	#superclass : #Object,
	#instVars : [
		'fobjects',
		'fattributes',
		'concepts'
	],
	#category : #'Moose-Algos-FormalConceptAnalysis'
}

{ #category : #examples }
MalFormalContext class >> classHierarchy [
	
	^self classHierarchy: Smalltalk allClasses
]

{ #category : #examples }
MalFormalContext class >> classHierarchy: classes [
	
	| fca |
	fca := MalFormalContext new.
	fca
		with: classes
		using: #yourself
		using: [:each | each allSelectors "\"difference: Object allSelectors].
	^fca
]

{ #category : #examples }
MalFormalContext class >> mammals [
	"(((		self mammals			)))"
	
	| data names fca |
	data := #(#(#ostrich #(#walks #laysEggs #featheres #warmblooded)) #(#mosquito #(#laysEggs #flies #small)) #(#vulture #(#laysEggs #featheres #warmblooded #flies)) #(#horse #(#walks #warmblooded #suckles)) #(#bat #(#warmblooded #flies #small #suckles)) #(#frog #(#quacks #laysEggs #small)) #(#dove #(#laysEggs #featheres #warmblooded #flies #small)) #(#crocodile #(#walks #laysEggs)) #(#robin #(#laysEggs #featheres #warmblooded #flies #sings #small)) #(#platypus #(#walks #laysEggs #warmblooded #suckles))).
	names := #(#robin #dove #vulture #ostrich #bat #horse #platypus #crocodile #frog #mosquito).
	names := String withAll: (names collect: #first).
	fca := MalFormalContext new.
	fca with: data using: #first using: #last.
	^fca
]

{ #category : #examples }
MalFormalContext class >> mammals2 [
	"(((		self mammals2			)))"
	
	| data fca |
	data := #(#(#Cat #(#fourlegs #hair)) #(#Dog #(#fourlegs #hair)) #(#Dolphin #(#smart #marine)) #(#Gibbon #(#hair #smart #thumbed)) #(#Man #(#smart #thumbed)) #(#Whale #(#smart #marine))).
	fca := MalFormalContext new.
	fca with: data using: #first using: #last.
	^fca
]

{ #category : #accessing }
MalFormalContext >> attributes [
	
	^fattributes
]

{ #category : #private }
MalFormalContext >> computeConcepts [
	
	| algorithm |
	algorithm := MalGanterAlgorithm on: self.
	^algorithm allConcepts
]

{ #category : #accessing }
MalFormalContext >> concepts [
	
	^concepts ifNil: [concepts := self computeConcepts]
]

{ #category : #accessing }
MalFormalContext >> objects [
	
	^fobjects
]

{ #category : #printing }
MalFormalContext >> printOn: stream [
	
	super printOn: stream.
	stream
		space;
		nextPut: $(;
		print: self objects size;
		nextPut: $√ó;
		print: self attributes size;
		nextPut: $)
]

{ #category : #'initialize-release' }
MalFormalContext >> with: collection using: foBlock using: faBlock [
	
	| dict fobject fattribute |
	dict := Dictionary new.
	fobjects := "ArrayList"OrderedCollection new.
	fattributes := "ArrayList"OrderedCollection new.
	collection
		do:
			[:eachFo | 
			fobject := MalFCAElement with: (foBlock value: eachFo).
			fobject appendTo: fobjects.
			(faBlock value: eachFo)
				do:
					[:eachFa | 
					fattribute := dict
						at: eachFa
						ifAbsentPut:
							[fattribute := MalFCAElement with: eachFa.
							fattribute appendTo: fattributes].
					fattribute setBit: fobject.
					fobject setBit: fattribute]]
]
