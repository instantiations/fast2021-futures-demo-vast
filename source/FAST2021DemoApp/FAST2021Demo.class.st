Class {
	#name : 'FAST2021Demo',
	#superclass : 'Object',
	#category : 'FAST2021DemoApp'
}

{ #category : 'Processing' }
FAST2021Demo >> asyncProcessCovidData [

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

| getLocations readLocations time completed transcript |

time := Time millisecondClockValue.
transcript := TranscriptTTY default.
getLocations := SstAsyncHttpClient fetch: 'https://coronavirus-tracker-api.herokuapp.com/v2/locations'.
readLocations := getLocations then: [:response | ((NeoJSONReader on: response basicContents readStream) next at: 'locations')].
completed := readLocations then: [:readLocationsData |
	EsFuture all: (readLocationsData collect: [:locationData | | countryId countryName getLocation provinceName countryAndProvince |
		countryId := (locationData at: 'id') asString.
		countryName := (locationData at: 'country') asString copyWithout: $*.
		provinceName := (locationData at: 'province') asString copyWithout: $*.
		countryAndProvince := countryName, (provinceName isEmpty ifTrue:[ '' ] ifFalse: [' - ', provinceName]).
		getLocation := SstAsyncHttpClient fetch: 'https://coronavirus-tracker-api.herokuapp.com/v2/locations/' , countryId, '?source=jhu&timelines=false'.
		getLocation then: [:response | | readLatest wroteZip printToTranscript |
			(response isSstError or: [response basicContents isEmpty]) 
				ifTrue: [ EsFuture on: [transcript show: countryAndProvince , ': ---------------------Server Error--------------------'; cr ]]
				ifFalse: [			
					readLatest := EsFuture on: [ ((NeoJSONReader on: response basicContents readStream) next at: 'location') at: 'latest'].
					wroteZip := readLatest then: [:latestData | | stream |
						stream := ZipWriteStream on: (CfsWriteFileStream openEmpty: countryAndProvince, '.zip').
						stream 
							nextPutEntry: (ZipEntry named: countryAndProvince, '.txt');
							nextPutAll: 'confirmed: '; space; nextPutAll: (latestData at: 'confirmed') asString; cr;
							nextPutAll: 'deaths: '; space; nextPutAll: (latestData at: 'deaths') asString; cr;
							nextPutAll: 'recovered: '; space; nextPutAll: (latestData at: 'recovered') asString; cr;
							close
					].
					printToTranscript := readLatest then: [:latestData |
							transcript show: countryAndProvince.
							transcript show: '     confirmed: ', (latestData at: 'confirmed') asString.
							transcript show: '     deaths: ', (latestData at: 'deaths') asString.
							transcript show: '     recovered: ', (latestData at: 'recovered') asString.
							transcript cr].
					EsFuture all: (Array with: wroteZip with: printToTranscript)
				]
		]
	])
].
completed then: [:e | transcript cr; show: 'Time spent: ', (Duration milliseconds: Time millisecondClockValue - time) printString; cr ] 
]

{ #category : 'Processing' }
FAST2021Demo >> processCovidData [
	^ self asyncProcessCovidData
]

{ #category : 'Processing' }
FAST2021Demo >> servers [

"
 
 main: https://coronavirus-tracker-api.herokuapp.com
 
 US mirror: https://covid-tracker-us.herokuapp.com
 
 "

]

{ #category : 'Processing' }
FAST2021Demo >> syncProcessCovidData [

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
| time response readLocationsData transcript |

time := Time millisecondClockValue.
transcript := TranscriptTTY default.
response := SstHttpClient fetch: 'https://coronavirus-tracker-api.herokuapp.com/v2/locations'.
readLocationsData := ((NeoJSONReader on: response basicContents readStream) next at: 'locations').
readLocationsData collect: [:locationData | | countryId countryName provinceName rename latestData countryAndProvince |
	countryId := (locationData at: 'id') asString.
	countryName := (locationData at: 'country') asString copyWithout: $*.
	provinceName := (locationData at: 'province') asString copyWithout: $*.
	countryAndProvince := countryName, (provinceName isEmpty ifTrue:[ '' ] ifFalse: [' - ', provinceName]).
	response := SstHttpClient fetch: 'https://coronavirus-tracker-api.herokuapp.com/v2/locations/' , countryId, '?source=jhu&timelines=false'.
	(response isSstError or: [response basicContents isEmpty]) 
			ifTrue: [ transcript show: countryAndProvince,  ': ---------------------Server Error--------------------'; cr ]
			ifFalse: [			
				latestData := ((NeoJSONReader on: response basicContents readStream) next at: 'location') at: 'latest'.
				rename := ZipWriteStream on: (CfsWriteFileStream openEmpty: countryAndProvince, '.zip').
				rename 
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
  
]
