sym-diff-prolog
===============

Symbolic Differentiation Implementation in Prolog<br>
Wojtek Jurczyk, Warsaw University of Technology

## About

Sym-diff-prolog is an implementation of symbolic differentiation using Prolog. It is a bit optimized (it has arithmetic operations optimised; see the source code) but the implementation is still very simple. I hope you will find it useful for learning Prolog. Enjoy!

## Functionality

It is capable of calculating derivatives of:
* basic functions
* sum of functions
* subtraction of functions
* multiplication of functions
* division of functions
* powers (thus, square root)
* logarithmic and exponential functions
* some trigonometric functions

Any other functions can be easily added to the code :)

## Examples

Let's ask about some derivative:

<code>| ?- diff(x^(x*log(cos(x))), x, N).</code>

The answer we get is:

<code>N = x^(x*log(cos(x))-1)*(x*log(cos(x))+(log(cos(x))+x*(-sin(x)/cos(x)))*x*log(x)) ?</code>

The answer is correct and you can check it [here](http://www.wolframalpha.com/input/?i=%28diff+x^%28x*log%28cos%28x%29%29%29%29+-+x^%28x*log%28cos%28x%29%29-1%29*%28x*log%28cos%28x%29%29%2B%28log%28cos%28x%29%29%2Bx*%28-sin%28x%29%2Fcos%28x%29%29%29*x*log%28x%29%29) by calculating, using WolframAlpha, derivative - N (it should be 0, and in fact it is).
