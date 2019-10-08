# swift-spreadsheet-gen

Convert a Google Spreadsheet to a file. This project is heavily inspired by the [xvrh/localize-with-spreadsheet](https://github.com/xvrh/localize-with-spreadsheet), [SwiftGen/SwiftGen](https://github.com/SwiftGen/SwiftGen)

# Usage
To use swift-spreadsheet-gen, simply create a `swift_spreadsheet_gen.yml` YAML file to list all the subcommands to invoke, and for each subcommand, the list of arguments to pass to it. For example:
```
id: "your Google Spreadsheet id"
sheet_number: your Google Spreadsheet number
strings:
  outputs:
    - key: KEY
      value_key: ja
      output: ./ja.lproj/Localizable.strings
      format: strings
    - key: KEY
      value_key: en
      output: ./en.lproj/Localizable.strings
      format: strings
```

# Notes
- Your spreadsheet should be "Published" for this to work
