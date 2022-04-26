# Inflectional rules

- associate an ending and an inflectional class with a morphological form
- in managing rules from delimited-text files, different types of morphological forms are represented by appropriate property values
- rules can be read from delimited-text source with `readrulerow`



## Example

Read a rule from delimited text:

```@example rules
using Kanones
delimited = "adjinfl.osaon1|os_a_on|ος|masculine|nominative|singular|positive|"
adjio = Kanones.AdjectiveIO("adjectives")
rule = Kanones.readrulerow(adjio, delimited)
```

Find its `RuleUrn`:

```@example rules
ruleurn(rule)
```

Find its inflectional type and inflectional ending:

```@example rules
inflectionClass(rule)
```
```@example rules
ending(rule)
```

# morphological data
formabbr = formurn(rule)
expectedabbr = FormUrn("forms.7010001110")
@test formabbr == expectedabbr

formcode = code(rule)
expectedcode = "7010001110"
@test formcode == expectedcode
