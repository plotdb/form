# Widget Values

While widgets can define how they store values from user input, it will be helpful if some kind of formats are followed. For simplicity, `@plotdb/form` defines a generic value format, called `Generic Widget Value`; this is by default supported when a value is required, or will consider input value is Generic Widget Value if not specified.

This format is described as below.


## Generic Widget Value

A Generic Widget Value can be either:

 - a string as a Verbose Text.
 - an array of Generic Widget Value.
 - an object with one of the pattern of following structures:
   - `{v}`: v is a verbose text, or recursively an generic makeform value
   - `{filename}`: filename is a string and usually for name of the file in file related widget
   - `{key,value}`: a key value pair object where key as identifier and value is verbose text.
   - `{list, other}`:
     - list isan array of generic makeform value
     - other: an object `{enabled, text}` where `enabled` is boolean, and `text` is verbose text.


### Verbose Text

we also define `verbose text` as text for verbose purpose - it may be a simple string, or an object that can be converted into string or formatted structure such as rich text.


## Other Value Format

WIP / TBD

Widgets can define their own value formats for different modules to determine if they support the processing of this module. This isn't yet defined or implemented, and is expected to be done in the future.


## Possibly Usage

 1. formatting output to spreadsheet
 2. formatting output to document or HTML
 3. condition evaluation / criteria checking by predefined opset/ops

