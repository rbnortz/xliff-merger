var path = require('path');
var xslt4node = require('xslt4node');


var baseFilePath = process.argv[2] ? path.resolve(process.argv[2]) : "";
var otherFilePath = process.argv[3] ? path.resolve(process.argv[3]) : "";
var resultFile = process.argv[4] ? path.resolve(process.argv[4]) : "";
var xsltFile = process.argv[5] ? path.resolve(process.argv[5]) : "";

if (!baseFilePath) {
  console.error("Parameters are missing, usage is: node xliff-merger.js <base file path> [<other file path> [merged.xlf [template.xsl]]]")
  throw new Error('Error: Please provide a base file path.');
}

if (!resultFile && otherFilePath) {
  resultFile = 'merged.xlf'
  console.warn('Defaulting result file to ' + resultFile);
} else if (!resultFile && !otherFilePath) {
  console.warn('No "other" file path provided.');
  console.warn('Base file will be sorted ' + baseFilePath);
  otherFilePath = baseFilePath;
  resultFile = baseFilePath.replace('.xlf', '-sorted.xlf');
}

if (!xsltFile) {
  xsltFile = 'xliff-merger.template.xsl',
  console.log('Defaulting template path to ' + xsltFile);
}

var config = {
  sourcePath: baseFilePath,
  result: resultFile,
  xsltPath: xsltFile,
  params: {
    otherFilePath: otherFilePath
  }
};

console.log("Transforming ", config.sourcePath, "to", config.result);

xslt4node.transform(config, function (err) {
  if (err) {
    console.error(err);
  } else {
    console.log("Done!");
    process.exit();
  }
});

