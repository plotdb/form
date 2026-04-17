# @plotdb/form

`@plotdb/form` is a form management package with following feature:

 - form construction with block-based widget
 - serializable form spec and filled data

It includes following modules:

 `form.manager`: a recursive manager of a set of widgets.
 `form.widget`: a form widget as a bridge between user and manager.
 `form.opset` and `form.op`: operation set and individual operations for validating given inputs from users.
 `form.term`: validation rule with configs including used opset/op and corresponding configurations.
 `form.condctrl`: controller for form dynamics based on given conditions.


## Draft

### form.block attrubite

An attribute is an aspect of data from a form.block. For example, a File form.block could contains following attributes:

 - `size` - size of all files combined.
 - `count` - count of files.
 - `modifiedtime` - modified time of last touched files.
 - `ext` - type of files.

Every attribute can be associated with one or multiple `form.opset` For example, above `ext` attribute can be associated with `extensions` type, which helps in determining if files in a given `ext` array all belong to certain file type.

