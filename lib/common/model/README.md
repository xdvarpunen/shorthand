# Terminology

Use common types to access operations.

```
point (Point)

line (List<Point>)

lines (List<List<Point>>)
```

turns out lines is redundant
If it’s just a wrapper around a list…
…and nothing else, then:

❌ It is not a model
✅ It is a redundant container
keep models thin this way

---

Use `Toolbox` within types to operate on `List<List<Point>>` type.
Actually hmm. This is why it made frustrating. Should not operate on ´List<List<Point>>´. 

---

// we need type to implement law of demeter
// attach operations


## Base Identifier

// Represents identifier
// Different type of letters identifiers can have more properties or behavior
// Using this as base in order to facilitate management
// Identifier can consist of identifiers (A => Ä => Å => a => å...)
// Identifier can have different meaning in different context
class BaseIdentifier {}

I have no use of it right now but lets keep it here :)

## Reminder

Keep models thin.
Keep models immutable.
