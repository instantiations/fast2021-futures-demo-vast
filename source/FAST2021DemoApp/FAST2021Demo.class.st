Class {
	#name : 'FAST2021Demo',
	#superclass : 'Object',
	#category : 'FAST2021DemoApp'
}

{ #category : 'Processing' }
FAST2021Demo class >> asyncProcessCovidData [

	"Asynchronous Version
	 Make an HTTP REST call to get all COVID-19 Location Data.
	 Parse locations data response into JSON Data Structure
	 For each Country in Location Data
		Make an HTTP REST call to get all COVID-19 Country Data
		Parse country data response into JSON Data Structure
		Write Zip File to File Stream with country stats
		Print country stats to Transcript
	 End For
	 "

	| getLocationsFuture readLocationsFuture time completedFuture transcript |

	time := Time millisecondClockValue.
	transcript := TranscriptTTY default.
	getLocationsFuture := EsFuture on: [SstHttpClient fetch: 'https://coronavirus-tracker-api.herokuapp.com/v2/locations'].
	readLocationsFuture := getLocationsFuture then: [:response | ((NeoJSONReader on: response basicContents readStream) next at: 'locations')].
	completedFuture := readLocationsFuture then: [:readLocationsData |  | allLocationsWriteZipAndPrintToTranscriptFutures | 
			allLocationsWriteZipAndPrintToTranscriptFutures := OrderedCollection new. 
			readLocationsData do: [:locationData | | getLocationFuture writeZipAndPrintToTranscriptFuture |
				getLocationFuture := EsFuture on: [ SstHttpClient fetch: 'https://coronavirus-tracker-api.herokuapp.com/v2/locations/', (locationData at: 'id') asString, '?source=jhu&timelines=false'].
				writeZipAndPrintToTranscriptFuture := getLocationFuture then: [:response | | readLatestFuture writeZipFuture printToTranscriptFuture |
					(response isSstError or: [response basicContents isEmpty]) 
						ifTrue: [ EsFuture on: [transcript show: (self countryAndProvinceFrom: locationData) , ': ---------------------Server Error--------------------'; cr ]]
						ifFalse: [			
							readLatestFuture := EsFuture on: [ ((NeoJSONReader on: response basicContents readStream) next at: 'location') at: 'latest'].
							writeZipFuture := readLatestFuture then: [:latestData |
								self writeZipWith: latestData from: locationData.
							].
							printToTranscriptFuture := readLatestFuture then: [:latestData |
								self printTo: transcript with: latestData from: locationData.
							].
							EsFuture all: { writeZipFuture. printToTranscriptFuture. }.
						]
				].	
				allLocationsWriteZipAndPrintToTranscriptFutures add: writeZipAndPrintToTranscriptFuture.
			].
			EsFuture all: allLocationsWriteZipAndPrintToTranscriptFutures.
	].
	completedFuture then: [:e | transcript cr; show: 'Time spent: ', (Duration milliseconds: Time millisecondClockValue - time) printString; cr ]  
]

{ #category : 'Processing',
  #vaVisibility : 'private' }
FAST2021Demo class >> countryAndProvinceFrom: locationData [

	| provinceName countryName |

	countryName := (locationData at: 'country') asString copyWithout: $*.
	provinceName := (locationData at: 'province') asString copyWithout: $*.
	^countryName , (provinceName isEmpty ifTrue: [''] ifFalse: [' - ' , provinceName])
]

{ #category : 'Processing',
  #vaVisibility : 'private' }
FAST2021Demo class >> printTo: aStream with: latestData from: locationData [

	aStream show: (self countryAndProvinceFrom: locationData).
	aStream show: '     confirmed: ' , (latestData at: 'confirmed') asString.
	aStream show: '     deaths: ' , (latestData at: 'deaths') asString.
	aStream show: '     recovered: ' , (latestData at: 'recovered') asString.
	aStream cr
]

{ #category : 'Processing' }
FAST2021Demo class >> processCovidData [
	^ self asyncProcessCovidData
]

{ #category : 'Processing',
  #vaVisibility : 'private' }
FAST2021Demo class >> servers [

"
 main: https://coronavirus-tracker-api.herokuapp.com
 
 US mirror: https://covid-tracker-us.herokuapp.com
 
 Local docker:  http://192.168.7.140
 
 "

]

{ #category : 'Processing' }
FAST2021Demo class >> syncProcessCovidData [

	"Synchronous Version
	 Make an HTTP REST call to get all COVID-19 Location Data.
	 Parse locations data response into JSON Data Structure
	 For each Country in Location Data
		Make an HTTP REST call to get all COVID-19 Country Data
		Parse country data response into JSON Data Structure
		Write Zip File to File Stream with country stats
		Print country stats to Transcript
	 End For
	"

	[| time response readLocationsData transcript |

	time := Time millisecondClockValue.
	transcript := TranscriptTTY default.
	response := SstHttpClient fetch: 'https://coronavirus-tracker-api.herokuapp.com/v2/locations'.
	readLocationsData := ((NeoJSONReader on: response basicContents readStream) next at: 'locations').
	readLocationsData do: [:locationData | | countryId countryName provinceName stream latestData countryAndProvince |
		countryId := (locationData at: 'id') asString.
		countryName := (locationData at: 'country') asString copyWithout: $*.
		provinceName := (locationData at: 'province') asString copyWithout: $*.
		countryAndProvince := countryName, (provinceName isEmpty ifTrue:[ '' ] ifFalse: [' - ', provinceName]).
		response := SstHttpClient fetch: 'https://coronavirus-tracker-api.herokuapp.com/v2/locations/' , countryId, '?source=jhu&timelines=false'.
		(response isSstError or: [response basicContents isEmpty]) 
				ifTrue: [ transcript show: countryAndProvince,  ': ---------------------Server Error--------------------'; cr ]
				ifFalse: [			
					latestData := ((NeoJSONReader on: response basicContents readStream) next at: 'location') at: 'latest'.
					stream := ZipWriteStream on: (CfsWriteFileStream openEmpty: countryAndProvince, '.zip').
					stream 
						nextPutEntry: (ZipEntry named: countryAndProvince, '.txt');
						nextPutAll: 'confirmed: '; space; nextPutAll: (latestData at: 'confirmed') asString; cr;
						nextPutAll: 'deaths: '; space; nextPutAll: (latestData at: 'deaths') asString; cr;
						nextPutAll: 'recovered: '; space; nextPutAll: (latestData at: 'recovered') asString; cr;
						close.
					transcript show: countryAndProvince.
					transcript show: '     confirmed: ', (latestData at: 'confirmed') asString.
					transcript show: '     deaths: ', (latestData at: 'deaths') asString.
					transcript show: '     recovered: ', (latestData at: 'recovered') asString.
					transcript cr
				]	
	].
	transcript cr; show: 'Time spent: ', (Duration milliseconds: Time millisecondClockValue - time) printString; cr
	]  fork
]

{ #category : 'Processing',
  #vaVisibility : 'private' }
FAST2021Demo class >> writeZipWith: latestData from: locationData [

	| stream countryAndProvince |

	countryAndProvince := self countryAndProvinceFrom: locationData.
	stream := ZipWriteStream on: (CfsWriteFileStream openEmpty: countryAndProvince , '.zip').
	stream
		nextPutEntry: (ZipEntry named: countryAndProvince , '.txt');
		nextPutAll: 'confirmed: ';
		space;
		nextPutAll: (latestData at: 'confirmed') asString;
		cr;
		nextPutAll: 'deaths: ';
		space;
		nextPutAll: (latestData at: 'deaths') asString;
		cr;
		nextPutAll: 'recovered: ';
		space;
		nextPutAll: (latestData at: 'recovered') asString;
		cr;
		close
]
