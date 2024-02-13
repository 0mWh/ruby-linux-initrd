# ruby linux
a set of tools to construct a bootable linux image that runs only on native programs and ruby scripts.   
there are some wrappers for common coreutils, and common linux shell programs.

the goal is to have a working desktop on only c/c++ and ruby.

## todo
- network
- better kernel module loading system
- graphics
- users (single-user (not root) is what people care about)
- coreutils

## why
i opened a terminal just to immediately open irb more than i cared to count. so i decided to make irb the shell.
- **dynamic typing**: bash doesn't have a well-organized type system, as everything gets treated like a string.
- **maps & folds(reduce)**: bash pipes are nice, but only transfer data as a string (see typing). python's are syntactically ugly, either depending on itertools or frequent explicit type conversions.
- **arithmetic**: representing floating-point numbers and division is possible in ruby. this doesn't exist in vanilla bash, batch, sh, csh, and so on.
- **arrays**: ruby's array structure & usage is similar to enough other languages that support arrays. using arrays in bash depends on declaring a variable to be an array, and frequent parenthesis
- **functions**: like many other languages, function declaration is well-defined. in bash, `function e {...}` doesn't let you name parameters or set defaults.
- **optional parentheses**: an (underappreciated) feature of ruby is that parentheses are optional in many cases. for a shell language, this can be much more readable.
- **compatibility**: very good backwards compatibility at the syntax-level.
