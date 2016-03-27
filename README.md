# Scribe

## What is that?

Scribe is ~~powerfull~~ ~~useful~~ ~~helpful~~ strange Ruby script that allows you to generate **tons of boilerplate Objective C code** using only simple class definitions. It is **extremely** a must if your payment depends on number lines of code you have written. In any other case it could help you to do your data structure more clear and determinate.

Scribe takes your headers written in Objective C (actually it could parse only subset of Objective C grammar but it covers ~90% of usage cases IMO) annotated with `scribe` preprocessor macro that specifies code generation rules.

## Oh man blaze it.

Scribe code generator based on simple idea. Immutable classes is better than mutable. Builder pattern is useful and consistent. Interfaces are marvelous and should be used everywhere instead of real class types. Interfaces allows multiple inheritance and classes is not. And so on.

Scribe engine interprets class definition as a simple contract for immutable class. All readonly fields becomes constructor mandatory parameters, all others becomes readonly class properties. Engine also generates copy constructor automatically if you somehow want to get _exact copy of immutable class man r u mad_.

And this is only begining.

With help of `scribe(implement mutable)` annotation you can generate a mutable copy. It'll have `Mutable` prefix (next to your class prefix), all readonly fields will remain readonly, but all others becomes mutable. And you will allow to make mutable copy of immutable class and then initialize immutable class with changed mutable data like `NSArray`/`NSMutableArray` simular clusters.

Moreover, generator can solve [mutable/immutable class cluster inheritance problem](http://nshipster.com/nsorderedset/). Solution is pretty simple but requires to write tons of boilerplate Objective C code, and Scribe just allows to generate it instead of you. It looks like this:
![Immutable/Mutable class cluster with inheritance](/doc/inheritance_diagram.png)

Scribe can do much more useful stuff but I'm too lazy to write about it now. Engine is developing now, so it is completely not user-friendly, but if you find it and wanna use it, you can try to investigate sources and examples by yourself or just wait when it's done.

Best regards.

## How should I do to make magic happens?

By default Scribe only extracts interfaces and generates immutable class. Maybe it's pretty helpful but definitely not all you might need. For extended features you should use annotations.

There's 2 annotations level: class-level annotations and property-level annotations. All of them defined with keyword `scribe` written in code above statement with nessesary requirements inside.

Class level annotations allows you to generate:
1. Mutable version of class with `implement mutable`
2. Abstract classes using `make abstract`
3. Builder class by defining `implement builder`
4. Serialization code for `NSArchiver` by implementing `NSCoding` with `implement archivable`
5. Code for tracking changes of mutable objects by using `implement tracking`

Property-level annotations allows you to generate:
1. Validation code by defining `implement validator`
2. Collection extended access code with `implement collection`

Full documentation ongoing.

## TODO
* ~~Check object graph~~
* ~~Builder support~~
* ~~Abstract class support~~
* Extract changes from `Mutable` as `ChangesDelta` class
    * Allows operation like:
        * `Immutable` + `ChangesDelta` = `Mutalbe`
        * `ChangesDelta` + `ChangesDelta` = `ChangesDelta`
        * `ChangesDelta`<sup>-1</sup> — Is it nessesary? Could be helpful for UndoManager implementation.
* ~~getter= and setter= support~~
* ~~Inheritance of common base builder if exists~~
* ~~Common Objective C library with implementations used in generated files~~
* ~~Validation?~~
    * Automatic validators for `_Notnull` type annotation.
* Undo manager
    * Based on tracker? It is possible if we ask him to save all history on demand
* `isEqual:` method code generation
    * Based on scribe definition or generate always?
* ~~TESTS~~
    * Tests for parser/gen — how to test them? Check it out
* Scribe directives inheritance and overriding
* Conflicts discovering and investigation
    * ~~Basic validators for inconsistent state~~
    * Validation in descendants should be only more strict
    * Should allow to override property types and generate rules to process it correctly
* Working with XCode project
* ~~Replace `implement` with `derive`~~

## Deal with
* https://www.bignerdranch.com/blog/about-mutability/ — cool Apple optimizations breaks class model and my cool optimizations, it's so sad.
