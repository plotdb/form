# Change Logs

## v0.0.67

 - add `isRequired` api in form.widget


## v0.0.66

 - fix bug: check `_meta` before using in progress
 

## v0.0.65

 - fix bug: check `_meta` before using in progress
 

## v0.0.64

 - fix bug: url op only supports 6 characters long top level domain
 

## v0.0.63

 - fix bug: recursive progress may count nested fields multiple times


## v0.0.62

 - update progress based on recursive manager hierarchy


## v0.0.61

 - fix bug: check term and fallback to `[]` in serialize if term is not available.


## v0.0.60

 - add `ctrl` for accessing custom api in widget


## v0.0.59

 - consider widget internal opset if available for term construction


## v0.0.58

 - support `readonly()` and `disabled()` in `form.widget` api


## v0.0.57

 - `value` of form manager now returns full data including disabled fields.
 - support `partial` option for retrieving value partially without disabled fields.


## v0.0.56

 - add `gte` op in length opset


## v0.0.55

 - fire `init` event when init or deserialize with `init` option.


## v0.0.54

 - fix bug: current formmgr mode doesn't affect newly added widgets
 - upgrade dependencies to fix vulnerabilities


## v0.0.53

 - fix bug: extension check error if filename is not provided


## v0.0.52

 - meta event should provide meta value in `meta` field instead of `value` field.
 - also provide `invalid` count in progress api
 - meta change event only fired if meta digest changes and is not a init call


## v0.0.51

 - fire meta event from manager triggered by widget.
 - upgrade dependencies


## v0.0.50

 - fix bug: set mode for all widgets without filtering out disabled widgets


## v0.0.49

 - extension op: trim input to acces configs with space like `jpg, jpeg`


## v0.0.48

 - make value still work for disabled widgets


## v0.0.47

 - remove unnecessary log


## v0.0.46

 - add opset `image` for checking image size / pixels


## v0.0.45

 - add opset for date with an op `age`


## v0.0.44

 - list opset: support checkbox / radio style content


## v0.0.43

 - length opset: add `range` op for limiting word length in a range.


## v0.0.42

 - support status 3 from custom `validate` which suppress checks but also not considered empty.
 - extend `check` api params in backward compatible fashion to support both boolean and object for configuration.
 - support `skipEmpty` option in `check`
 - pass `check` options into `validate`


## v0.0.41

 - don't validate terms of empty fields that are not required, otherwise they may become forced to be required.


## v0.0.40

 - support `simple-word` algorithm for counting string length in `length` opset. 


## v0.0.39

 - remove unwanted log


## v0.0.38

 - add opset for `list`. use the same code for list count in `list` and `file` opset.
 - check emptyness and terms even if validate function is provided in a widget.


## v0.0.37

 - add `count-min`, `count-max` and `count-range` file ops. deprecate `count-limit` file op.


## v0.0.36

 - support `disabled` flag in widget to indicate widgets to skip in manager.


## v0.0.35

 - fix bug: in manager, getting content for non-existent widgets causing exception


## v0.0.34

 - add `manager` api in mod for supporting recursive form manager


## v0.0.33

 - fix bug: remove widget in form manager use an incorrect object to invoke widget's off function


## v0.0.32

 - upgrade dependencies to fix vulnerabilities
 - fix bug: widget tries to clone `undefined` when firing change event.


## v0.0.31

 - support `url` op in string opset


## v0.0.30

 - fix bug: `manager._restatus` should consider widget status as `0` if it has status `1` and `isRequired` as false.
 - support option in `deserialize` to control `init` flag in subsequential calls to `validate` and `value`. 


## v0.0.29

 - fix bug: `check` should return a list instead of undefined
 - fix bug: `null` should also be treated as `empty`.


## v0.0.28

 - fix bug: extension matching should ignore case


## v0.0.27

 - fix bug: value in widget change event should be cloned, otherwise user can alter widget internal value.


## v0.0.26

 - fix bug: widget value call should return cloned value, and should also store cloned value.


## v0.0.25

 - fix bug: incorrect parameter value ( which should be opt ) passed to submod validator


## v0.0.24

 - support `defaultValue` in widget


## v0.0.23

 - add string `regex` op


## v0.0.22

 - add length `eq` op


## v0.0.21

 - fix bug: internal widget changes affect host object when setting value with `manager.value`.
 - add `isEqual` widget and widget mod api.


## v0.0.20

 - add `msg` field in term for showing error message
 - add `meta` event, fired when `meta` is modified.


## v0.0.19

 - provide `isEmpty(v)` api for accessing `mod.isEmpty`
 - accept param in `content(v)` so `content` can also be an utility function for value testing.


## v0.0.18

 - fix bug: validation sometimes fails due to object content returned for comparison.


## v0.0.17

 - fix bug: file opset validation failed due to illegal value in list
 - add a `content` api in both manager and widget for users to retrieve content defined by widget.
   - also rename `mod.value` to `mod.content` for consistency


## v0.0.16

 - check arguments.length instead of typeof(v) in widget.value to support setting undefined as value
 - add `partial` option to support manager value partially update
 - use `undefined` as initial value for widget
 - support `mod.value` for value parsing
 - change default check for emptiness from (!v) to either undefined or empty strgin ''


## v0.0.15

 - add file opset


## v0.0.14

 - use `isRequired` instead of `config.isRequired` since it's mandatory


## v0.0.13

 - bug fix: set mode failed


## v0.0.12

 - bug fix: setting manager mode doesn't always return a Promise.


## v0.0.11

 - bug fix: don't set value only if it's undefined


## v0.0.10

 - bug fix: `is-empty` of widget mod can't be executed correctly


## v0.0.9

 - bug fix: manager status isn't updated correctly due to status update logic incorrect


## v0.0.8

 - bug fix: race condition in value validation.
 - spec changes: `mode`, `value`, `deserialize` now return Promise, resolves when validation is finished.


## v0.0.7

 - bug fix: `manager.widget` doesn't work


## v0.0.6

 - bug fix: widget status change isn't logged in form manager.
 - bug fix: widget init status isn't logged in form manager.
 - bug fix: progress NaN when there is no widget.


## v0.0.5

 - bug fix: `check` is not finished immediately even if `now` is true
 - bug fix: set value may fail due to empty value provided
 - bug fix: `check` from `status` / `change` events of form.widget causes redundant validation.
 - bug fix: `change` event of form.widget isn't forwarded to form.manager correctly.
 - return invalid widgets from `check` call in ( if applicable, array of ) `{widget, path, status}` object.


## v0.0.4

 - add `root()` function to get root element of an widget


## v0.0.3

 - changes about `mode`:
   - add `mode` in `form.manager`
   - mode change triggers event `mode` with new mode value
   - redefine mode values to `edit`, `view` and `config`
   - update documentation

## v0.0.2

 - add `length` opset
 - add `is` in `number` opset
 - add `convert` in `number` opset
 - support ldform favor `status` and `off` ( removeListener )
 - support form.manager based on `ldform` logic
 - update documentation


## v0.0.1

 - initial release
