
<p align="center">
<!---<img src="assets/logos/128x128.png">-->
 <h1 align="center">FAST 2021 Demo</h1>
  <p align="center">
    FAST 2021 Demo
    <!---
    <br>
    <a href="docs/"><strong>Explore the docs »</strong></a>
    <br>
    -->
    <br>
    <a href="https://github.com/instantiations/fast2021-futures-demo-vast/issues/new?labels=Type%3A+Defect">Report a defect</a>
    |
    <a href="https://github.com/instantiations/fast2021-futures-demo-vast/issues/new?labels=Type%3A+Feature">Request feature</a>
  </p>
</p>

Material used for [F.A.S.T](https://www.fast.org.ar/) 2021 Demo in the [Constant Refinement and Continuing Progress at Instantiations](https://www.meetup.com/BA-Smalltalk/events/278106330/) presentation.

## License
- The code is licensed under [MIT](LICENSE).
- The documentation is licensed under [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/).


## Installation

1. Install [VA Smalltalk 10.0.1 or newer](https://www.instantiations.com/products/vasmalltalk/download.html).
2. Install Tonel support in your development image following [this guide](https://github.com/vasmalltalk/tonel-vast#installation).
3. Clone this repository.
4. The easiest and recommended approach is to install it via a script:

```smalltalk
| loader path |
path := (CfsPath named: '<insert path to root fast2021-futures-demo-vast local repo here>').
loader := TonelLoader readFromPath: path.
loader
	beUnattended; "do not prompt and use all defaults"
	useGitVersion.
loader loadAllMapsWithRequiredMaps.
```

Or you can load the Configuration Map `FAST 2021 - Demo Runtime` from the context menu of the Configuration Maps Browser: `"Import"` -> `"Load Configuration Maps from Tonel repository..."` -> select path to root `fast2021-futures-demo-vast` local repo. This will open a dialog and will use convenient defaults for the load. Refer to [its documentation](https://github.com/instantiations/tonel-vast#using-gui-menus) for more details.



## Examples

Here are some of the examples used during the demo:

Futures - Basic

```smalltalk
"A Future represents the completion of a computation."

|  computeFactorialFuture computeFactorialPlus3Future computeFactorialPlus5Future |
computeFactorialFuture := EsFuture on: [5 factorial]. "or [ 5 factorial ] async"
computeFactorialPlus3Future := computeFactorialFuture then: [:factorial |  TranscriptTTY default show: (factorial + 3) printString; cr].
computeFactorialPlus5Future := computeFactorialFuture then: [:factorial |  TranscriptTTY default show: (factorial + 5) printString; cr].
(EsFuture all: { computeFactorialPlus3Future. computeFactorialPlus5Future. } )
	then: [ TranscriptTTY default show: 'I am done!'; cr ]  
```

Futures - Exceptions

```smalltalk
((EsFuture on: [Exception signal: 'oh no' "throw error somewhere in the async code" ])
	catch: [:exception :stack | TranscriptTTY default show: 'Caught error: ', exception messageText ; cr])
		ensure: [TranscriptTTY default show: 'Finished!'; cr]
```

Promises - Basic

```smalltalk
"A promise to complete a future in a later time"

| future promise |
promise := EsPromise new.
future := promise future.
future then: [:number | TranscriptTTY default show: number printString].
promise complete: 42.  
```

Promises - OsProcess

```smalltalk
(OsProcessStarter start: #('sleep' '5')) onCompletion
	then: [TranscriptTTY default show: 'Process finished' ]
```


## Demo

For the demo, checkout the methods `#syncProcessCovidData` and `#asyncProcessCovidData`
