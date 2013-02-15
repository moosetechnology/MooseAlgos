"
I'm a word compacting class. I remove the most used letters from a word to compact it to a given size. 

	(Kontract upToCharacterNumber: 3)
		 reduce: 'hello' -> 'hlo'
"
Class {
	#name : #MalKontractor,
	#superclass : #Object,
	#instVars : [
		'sizeTo',
		'wordsToBeRemoved',
		'pairs'
	],
	#classVars : [
		'LetterFrequency'
	],
	#category : #'Moose-Algos-Kontractor'
}

{ #category : #benchs }
MalKontractor class >> bench [ 
"
	MessageTally spyOn:
	MessageTally spyOn: [1000 timesRepeat: [ (Kontract new: 3 ) removeOne: 'hllo']]
	
"	
	Time millisecondsToRun: [10000 timesRepeat: [ (self new: 3 ) removeOne: 'hllo']]
]

{ #category : #initialize }
MalKontractor class >> initialize [
	"self initialize"
	
	
	LetterFrequency := Dictionary new.		
	#(	
		#('e' 14.715)
		#('s' 7.948)
		#('a' 7.636)
		#('i' 7.529)
		#('t' 7.244)
		#('n' 7.095)
	#('r' 6.553)
	#('u' 6.311)
	#('l' 5.456)
	#('o' 5.378)
	#('d' 3.669)
	#('c' 3.260)
	#('p' 3.021)
	#('m' 2.968)
	#('é' 1.904)
	#('v' 1.628)
	#('q' 1.362)
	#('f' 1.066)
	#('b' 0.901)
	#('g' 0.866)
			#('j' 0.866)
	#('h' 0.737)
	#('i' 0.545)
	#('à' 0.486)
	#('x' 0.387)
	#('y' 0.308)
	#('è' 0.271)
	#('ê' 0.225)
	#('z' 0.136)
	#('w' 0.114)
	#('ç' 0.085)
	#('ù' 0.058)
	#('k' 0.049)
	#('î' 0.045)
	#('ï' 0.005)
	#('ë' 0.000)
	
	#('E' 7.948*0.01)
	#('S' 7.948*0.01)
	#('A' 7.636*0.01)
	#('I' 7.529*0.01)
	#('T' 7.244*0.01)
	#('N' 7.095*0.01)
	#('R' 6.553*0.01)
	#('U' 6.311*0.01)
	#('L' 5.456*0.01)
	#('O' 5.378*0.01)
	#('D' 3.669*0.01)
	#('C' 3.260*0.01)
	#('P' 3.021*0.01)
	#('M' 2.968*0.01)
	#('V' 1.628*0.01)
	#('Q' 1.362*0.01)
	#('F' 1.066*0.01)
	#('B' 0.901*0.01)
	#('G' 0.866*0.01)
	#('H' 0.737*0.01)
	#('I' 0.545*0.01)
	#('X' 0.387*0.01)
	#('Y' 0.308*0.01)
	#('Z' 0.136*0.01)
	#('W' 0.114*0.01)
	#('K' 0.049*0.01)
	
	#('1' 8.9)
	#('2' 8.8)
	#('3' 8.7)
	#('4' 8.6)
	#('5' 8.5)
	#('6' 8.4)
	#('7' 8.3)
	#('8' 8.2)
	#('9' 8.1)
	#('0' 8)
	#('_' 10)
	#('-' 9)
	#( ' ' 16)
	#('!' 11)
	#('@' 11)
	#('#' 11)
	#('$' 11)
	#('%' 11)
	#('^' 11)
	#('&' 11)
	#('*' 11)
	#('(' 11)
	#(')' 11)
	#('+' 11)
	#('=' 11)
	#('{' 11)
	#('}' 11)
	#('[' 11)
	#(']' 11)
	#('|' 11)
	#('\' 11)
	#(';' 11)
	#(':' 11)
	#('"' 11)
	#(',' 11)
	#('<' 11)
	#('>' 11)
	#('.' 11)
	#('?' 11)
	#('/' 11)	) do: [:each | LetterFrequency at: (each first) put: each second].
	
	
	
			
	


]

{ #category : #'instance creation' }
MalKontractor class >> new: anInteger [
	
	^self new sizeTo: anInteger
]

{ #category : #'instance creation' }
MalKontractor class >> reduce: aString upTo: anInteger [
	"self reduce: 'hello world' upTo: 6"
	
	^ (self new sizeTo: anInteger) reduce: aString 
]

{ #category : #'instance creation' }
MalKontractor class >> toSize: anInteger [
	"self upToCharacterNumber: 3"
	
	^self new sizeTo: anInteger
]

{ #category : #public }
MalKontractor >> chopWords: aString [

	| t |
	t := aString.
	wordsToBeRemoved do: [:each |
			t := t copyReplaceAll: each with: ''].
	^ t

	

	
]

{ #category : #public }
MalKontractor >> cut: aCollectionOfRoots contractUpTo: anInteger [

	wordsToBeRemoved := aCollectionOfRoots.
	self sizeTo: anInteger.
		
	
]

{ #category : #'initialize-release' }
MalKontractor >> initialize [
	
	super initialize.
	wordsToBeRemoved := #().
	pairs := {}.
	self sizeTo: 5
]

{ #category : #computing }
MalKontractor >> letterFrequency: aString [

	^ LetterFrequency at: aString ifAbsent: [12]
]

{ #category : #public }
MalKontractor >> reduce: aString [

	|reducedString|
	reducedString := self chopWords: aString.
	[reducedString size > self sizeTo] whileTrue: [
			reducedString := self removeOne: reducedString].
	^reducedString  


]

{ #category : #computing }
MalKontractor >> removeOne: aString [

	|comp note currentNote value |
	comp := 1.
	note := 0.
	[ comp <= aString size ] whileTrue: [
		currentNote := self letterFrequency: (aString copyFrom: comp to: comp). 
		(currentNote > note ) ifTrue: [
					note := currentNote.
					value := comp].  
	comp := comp + 1.].
	^ aString copyWithoutIndex: value.
]

{ #category : #accessing }
MalKontractor >> sizeTo [
	^ sizeTo
]

{ #category : #accessing }
MalKontractor >> sizeTo: anInteger [
	sizeTo := anInteger
]