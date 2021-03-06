# xliff-merger
Tested with:
 * node: `v12.22.7, v12.18.3`
 * npm: `6.14.15, 7.6.1`
 * WSL2
 * Mac OS

_xliff-merger_ is a tool that takes a generated xliff file (_base.xlf_)  and merges it with an existing and already translated xliff file (_other.xlf_).

 It reads every `<trans-unit>` tag found in the _base.xlf_ file and looks for new translations in the _other.xlf_ file. A translation is found as a `<target>` tag, this tag is then copied as a child node of the `<trans-unit>` tag. In the end, the result will be saved in a file called `merged.xlf`, all tags will be indented and sorted by the `<trans-unit>`'s _id_ attribute.

_xliff-merger_ uses [xslt4node](https://www.npmjs.com/package/xslt4node), _a XSLT package wrapping the XSLT interface of the Java API for XML Processing (JAXP)_, only available in Java 8 or earlier.

## Pre-requisites:
* [node-gyp](https://github.com/nodejs/node-gyp) Generally `npm install -g node-gyp`
  * Mac OS:
* Java JRE 6, 7 & 8 on Mac OS:
  * Install JDK from https://www.oracle.com/ca-en/java/technologies/javase/javase8-archive-downloads.html
  * If using _sdkman_ you'll need to link it: `sdk install java 8-oracle-mac /Library/Java/JavaVirtualMachines/jdk1.8.0_202.jdk/Contents/Home`
  * Then switch: `sdk use java 8-oracle-mac`
  * Update the `JAVA_HOME` environment variable: `export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_202.jdk/Contents/Home`
  * JVM's _JNI_ capabilities must be enabled under the _JavaVM_ `<dict>` tag:
    * `/Library/Java/JavaVirtualMachines/jdk1.8.0_202.jdk/Contents/Info.plist`
      ``` xml
      ...
      <key>JavaVM</key>
        <dict>
          <key>JVMCapabilities</key>
            <array>
                <string>CommandLine</string>
                <string>JNI</string>
            </array>
      ...

## Setup:
Run `npm install`

## Usage:

`node xliff-merger.js <base file path> [<other file path> [merged.xlf [template.xsl]]]`

xliff-merger will merge the following files:
* `<base file path>` is the translation file generated by angular, usually by doing: `ng extract-i18n --format=xlf`
* `<other file path>` is the file with the translations, this is the one that your translation team will send you back.
* If no `<other file path>` is specified, then the `<base file path>` will be sorted and saved as `<base file path>-sorted.xlf`

## Examples:
* *Merge two files*: `node xliff-merger.js base.xlf other.xlf`
  * The merged file will be saved in a file called `merged.xlf` by default.
* *Sort a file (`base.xlf`):* `node xliff-merger.js base.xlf`
  * The sorted file will be saved in a file called `base-sorted.xlf` by default.

## Future:
* Make it work without Java or Java 11+.
* Compile and share this tool to be added to angular projects as a node script.
* Test it using yarn instead of npm.
* Find a way to publish this tool to avoid the pre-requisites, [see here.](https://sunzhongkui.wordpress.com/2013/07/26/create-and-publish-node-js-c-addon/)
