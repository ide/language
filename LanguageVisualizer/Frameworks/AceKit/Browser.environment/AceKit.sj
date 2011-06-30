@STATIC;1.0;p;8;AceKit.jt;66;@STATIC;1.0;i;9;AceView.jt;36;
objj_executeFile("AceView.j",YES);
p;9;AceView.jt;1955;@STATIC;1.0;I;15;AppKit/CPView.ji;11;_Ace/ace.jsi;22;_Ace/theme-twilight.jst;1873;
objj_executeFile("AppKit/CPView.j",NO);
objj_executeFile("_Ace/ace.js",YES);
objj_executeFile("_Ace/theme-twilight.js",YES);
var _1=objj_allocateClassPair(CPView,"AceView"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("m_editor")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithFrame:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("AceView").super_class},"initWithFrame:",_5);
if(_3){
m_editor=ace.edit(_DOMElement);
m_editor.setTheme("ace/theme/twilight");
}
return _3;
}
}),new objj_method(sel_getUid("string"),function(_6,_7){
with(_6){
return m_editor.getSession().getValue();
}
}),new objj_method(sel_getUid("mouseDown:"),function(_8,_9,_a){
with(_8){
objj_msgSend(objj_msgSend(objj_msgSend(_8,"window"),"platformWindow"),"_propagateCurrentDOMEvent:",YES);
}
}),new objj_method(sel_getUid("mouseUp:"),function(_b,_c,_d){
with(_b){
objj_msgSend(objj_msgSend(objj_msgSend(_b,"window"),"platformWindow"),"_propagateCurrentDOMEvent:",YES);
}
}),new objj_method(sel_getUid("mouseDragged:"),function(_e,_f,_10){
with(_e){
objj_msgSend(objj_msgSend(objj_msgSend(_e,"window"),"platformWindow"),"_propagateCurrentDOMEvent:",YES);
}
}),new objj_method(sel_getUid("keyDown:"),function(_11,_12,_13){
with(_11){
objj_msgSend(objj_msgSend(objj_msgSend(_11,"window"),"platformWindow"),"_propagateCurrentDOMEvent:",YES);
}
}),new objj_method(sel_getUid("keyUp:"),function(_14,_15,_16){
with(_14){
objj_msgSend(objj_msgSend(objj_msgSend(_14,"window"),"platformWindow"),"_propagateCurrentDOMEvent:",YES);
}
}),new objj_method(sel_getUid("scrollWheel:"),function(_17,_18,_19){
with(_17){
objj_msgSend(objj_msgSend(objj_msgSend(_17,"window"),"platformWindow"),"_propagateCurrentDOMEvent:",YES);
}
}),new objj_method(sel_getUid("acceptsFirstResponder"),function(_1a,_1b){
with(_1a){
return YES;
}
})]);
p;24;_Ace/ace-uncompressed.jst;503712;/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

/**
 * Define a module along with a payload
 * @param module a name for the payload
 * @param payload a function to call with (require, exports, module) params
 */
 
(function() {
    
var global = (function() {
    return this;
})();
    
// if we find an existing require function use it.
if (global.require && global.define) {
    require.packaged = true;
    return;
}
    
var _define = function(module, deps, payload) {
    if (typeof module !== 'string') {
        if (_define.original)
            _define.original.apply(window, arguments);
        else {
            console.error('dropping module because define wasn\'t a string.');
            console.trace();
        }
        return;
    }

    if (arguments.length == 2)
        payload = deps;

    if (!define.modules)
        define.modules = {};
        
    define.modules[module] = payload;
};
if (global.define)
    _define.original = global.define;
    
global.define = _define;


/**
 * Get at functionality define()ed using the function above
 */
var _require = function(module, callback) {
    if (Object.prototype.toString.call(module) === "[object Array]") {
        var params = [];
        for (var i = 0, l = module.length; i < l; ++i) {
            var dep = lookup(module[i]);
            if (!dep && _require.original)
                return _require.original.apply(window, arguments);
            params.push(dep);
        }
        if (callback) {
            callback.apply(null, params);
        }
    }
    else if (typeof module === 'string') {
        var payload = lookup(module);
        if (!payload && _require.original)
            return _require.original.apply(window, arguments);
        
        if (callback) {
            callback();
        }
    
        return payload;
    }
    else {
        if (_require.original)
            return _require.original.apply(window, arguments);
    }
};

if (global.require)
    _require.original = global.require;
    
global.require = _require;
require.packaged = true;

/**
 * Internal function to lookup moduleNames and resolve them by calling the
 * definition function if needed.
 */
var lookup = function(moduleName) {
    var module = define.modules[moduleName];
    if (module == null) {
        console.error('Missing module: ' + moduleName);
        return null;
    }

    if (typeof module === 'function') {
        var exports = {};
        module(require, exports, { id: moduleName, uri: '' });
        // cache the resulting module object for next time
        define.modules[moduleName] = exports;
        return exports;
    }

    return module;
};

})();// vim:set ts=4 sts=4 sw=4 st:
// -- kriskowal Kris Kowal Copyright (C) 2009-2010 MIT License
// -- tlrobinson Tom Robinson Copyright (C) 2009-2010 MIT License (Narwhal Project)
// -- dantman Daniel Friesen Copyright(C) 2010 XXX No License Specified
// -- fschaefer Florian Schäfer Copyright (C) 2010 MIT License
// -- Irakli Gozalishvili Copyright (C) 2010 MIT License

/*!
    Copyright (c) 2009, 280 North Inc. http://280north.com/
    MIT License. http://github.com/280north/narwhal/blob/master/README.md
*/

define('pilot/fixoldbrowsers', ['require', 'exports', 'module' ], function(require, exports, module) {

/**
 * Brings an environment as close to ECMAScript 5 compliance
 * as is possible with the facilities of erstwhile engines.
 *
 * ES5 Draft
 * http://www.ecma-international.org/publications/files/drafts/tc39-2009-050.pdf
 *
 * NOTE: this is a draft, and as such, the URL is subject to change.  If the
 * link is broken, check in the parent directory for the latest TC39 PDF.
 * http://www.ecma-international.org/publications/files/drafts/
 *
 * Previous ES5 Draft
 * http://www.ecma-international.org/publications/files/drafts/tc39-2009-025.pdf
 * This is a broken link to the previous draft of ES5 on which most of the
 * numbered specification references and quotes herein were taken.  Updating
 * these references and quotes to reflect the new document would be a welcome
 * volunteer project.
 *
 * @module
 */

/*whatsupdoc*/

//
// Function
// ========
//

// ES-5 15.3.4.5
// http://www.ecma-international.org/publications/files/drafts/tc39-2009-025.pdf

if (!Function.prototype.bind) {
    var slice = Array.prototype.slice;
    Function.prototype.bind = function bind(that) { // .length is 1
        // 1. Let Target be the this value.
        var target = this;
        // 2. If IsCallable(Target) is false, throw a TypeError exception.
        // XXX this gets pretty close, for all intents and purposes, letting
        // some duck-types slide
        if (typeof target.apply !== "function" || typeof target.call !== "function")
            return new TypeError();
        // 3. Let A be a new (possibly empty) internal list of all of the
        //   argument values provided after thisArg (arg1, arg2 etc), in order.
        var args = slice.call(arguments);
        // 4. Let F be a new native ECMAScript object.
        // 9. Set the [[Prototype]] internal property of F to the standard
        //   built-in Function prototype object as specified in 15.3.3.1.
        // 10. Set the [[Call]] internal property of F as described in
        //   15.3.4.5.1.
        // 11. Set the [[Construct]] internal property of F as described in
        //   15.3.4.5.2.
        // 12. Set the [[HasInstance]] internal property of F as described in
        //   15.3.4.5.3.
        // 13. The [[Scope]] internal property of F is unused and need not
        //   exist.
        var bound = function bound() {

            if (this instanceof bound) {
                // 15.3.4.5.2 [[Construct]]
                // When the [[Construct]] internal method of a function object,
                // F that was created using the bind function is called with a
                // list of arguments ExtraArgs the following steps are taken:
                // 1. Let target be the value of F's [[TargetFunction]]
                //   internal property.
                // 2. If target has no [[Construct]] internal method, a
                //   TypeError exception is thrown.
                // 3. Let boundArgs be the value of F's [[BoundArgs]] internal
                //   property.
                // 4. Let args be a new list containing the same values as the
                //   list boundArgs in the same order followed by the same
                //   values as the list ExtraArgs in the same order.

                var self = Object.create(target.prototype);
                target.apply(self, args.concat(slice.call(arguments)));
                return self;

            } else {
                // 15.3.4.5.1 [[Call]]
                // When the [[Call]] internal method of a function object, F,
                // which was created using the bind function is called with a
                // this value and a list of arguments ExtraArgs the following
                // steps are taken:
                // 1. Let boundArgs be the value of F's [[BoundArgs]] internal
                //   property.
                // 2. Let boundThis be the value of F's [[BoundThis]] internal
                //   property.
                // 3. Let target be the value of F's [[TargetFunction]] internal
                //   property.
                // 4. Let args be a new list containing the same values as the list
                //   boundArgs in the same order followed by the same values as
                //   the list ExtraArgs in the same order. 5.  Return the
                //   result of calling the [[Call]] internal method of target
                //   providing boundThis as the this value and providing args
                //   as the arguments.

                // equiv: target.call(this, ...boundArgs, ...args)
                return target.call.apply(
                    target,
                    args.concat(slice.call(arguments))
                );

            }

        };
        bound.length = (
            // 14. If the [[Class]] internal property of Target is "Function", then
            typeof target === "function" ?
            // a. Let L be the length property of Target minus the length of A.
            // b. Set the length own property of F to either 0 or L, whichever is larger.
            Math.max(target.length - args.length, 0) :
            // 15. Else set the length own property of F to 0.
            0
        )
        // 16. The length own property of F is given attributes as specified in
        //   15.3.5.1.
        // TODO
        // 17. Set the [[Extensible]] internal property of F to true.
        // TODO
        // 18. Call the [[DefineOwnProperty]] internal method of F with
        //   arguments "caller", PropertyDescriptor {[[Value]]: null,
        //   [[Writable]]: false, [[Enumerable]]: false, [[Configurable]]:
        //   false}, and false.
        // TODO
        // 19. Call the [[DefineOwnProperty]] internal method of F with
        //   arguments "arguments", PropertyDescriptor {[[Value]]: null,
        //   [[Writable]]: false, [[Enumerable]]: false, [[Configurable]]:
        //   false}, and false.
        // TODO
        // NOTE Function objects created using Function.prototype.bind do not
        // have a prototype property.
        // XXX can't delete it in pure-js.
        return bound;
    };
}

// Shortcut to an often accessed properties, in order to avoid multiple
// dereference that costs universally.
// _Please note: Shortcuts are defined after `Function.prototype.bind` as we
// us it in defining shortcuts.
var call = Function.prototype.call;
var prototypeOfArray = Array.prototype;
var prototypeOfObject = Object.prototype;
var owns = call.bind(prototypeOfObject.hasOwnProperty);

var defineGetter, defineSetter, lookupGetter, lookupSetter, supportsAccessors;
// If JS engine supports accessors creating shortcuts.
if ((supportsAccessors = owns(prototypeOfObject, '__defineGetter__'))) {
    defineGetter = call.bind(prototypeOfObject.__defineGetter__);
    defineSetter = call.bind(prototypeOfObject.__defineSetter__);
    lookupGetter = call.bind(prototypeOfObject.__lookupGetter__);
    lookupSetter = call.bind(prototypeOfObject.__lookupSetter__);
}


//
// Array
// =====
//

// ES5 15.4.3.2
if (!Array.isArray) {
    Array.isArray = function isArray(obj) {
        return Object.prototype.toString.call(obj) === "[object Array]";
    };
}

// ES5 15.4.4.18
if (!Array.prototype.forEach) {
    Array.prototype.forEach =  function forEach(block, thisObject) {
        var len = +this.length;
        for (var i = 0; i < len; i++) {
            if (i in this) {
                block.call(thisObject, this[i], i, this);
            }
        }
    };
}

// ES5 15.4.4.19
// https://developer.mozilla.org/en/Core_JavaScript_1.5_Reference/Objects/Array/map
if (!Array.prototype.map) {
    Array.prototype.map = function map(fun /*, thisp*/) {
        var len = +this.length;
        if (typeof fun !== "function")
          throw new TypeError();

        var res = new Array(len);
        var thisp = arguments[1];
        for (var i = 0; i < len; i++) {
            if (i in this)
                res[i] = fun.call(thisp, this[i], i, this);
        }

        return res;
    };
}

// ES5 15.4.4.20
if (!Array.prototype.filter) {
    Array.prototype.filter = function filter(block /*, thisp */) {
        var values = [];
        var thisp = arguments[1];
        for (var i = 0; i < this.length; i++)
            if (block.call(thisp, this[i]))
                values.push(this[i]);
        return values;
    };
}

// ES5 15.4.4.16
if (!Array.prototype.every) {
    Array.prototype.every = function every(block /*, thisp */) {
        var thisp = arguments[1];
        for (var i = 0; i < this.length; i++)
            if (!block.call(thisp, this[i]))
                return false;
        return true;
    };
}

// ES5 15.4.4.17
if (!Array.prototype.some) {
    Array.prototype.some = function some(block /*, thisp */) {
        var thisp = arguments[1];
        for (var i = 0; i < this.length; i++)
            if (block.call(thisp, this[i]))
                return true;
        return false;
    };
}

// ES5 15.4.4.21
// https://developer.mozilla.org/en/Core_JavaScript_1.5_Reference/Objects/Array/reduce
if (!Array.prototype.reduce) {
    Array.prototype.reduce = function reduce(fun /*, initial*/) {
        var len = +this.length;
        if (typeof fun !== "function")
            throw new TypeError();

        // no value to return if no initial value and an empty array
        if (len === 0 && arguments.length === 1)
            throw new TypeError();

        var i = 0;
        if (arguments.length >= 2) {
            var rv = arguments[1];
        } else {
            do {
                if (i in this) {
                    rv = this[i++];
                    break;
                }

                // if array contains no values, no initial value to return
                if (++i >= len)
                    throw new TypeError();
            } while (true);
        }

        for (; i < len; i++) {
            if (i in this)
                rv = fun.call(null, rv, this[i], i, this);
        }

        return rv;
    };
}

// ES5 15.4.4.22
// https://developer.mozilla.org/en/Core_JavaScript_1.5_Reference/Objects/Array/reduceRight
if (!Array.prototype.reduceRight) {
    Array.prototype.reduceRight = function reduceRight(fun /*, initial*/) {
        var len = +this.length;
        if (typeof fun !== "function")
            throw new TypeError();

        // no value to return if no initial value, empty array
        if (len === 0 && arguments.length === 1)
            throw new TypeError();

        var i = len - 1;
        if (arguments.length >= 2) {
            var rv = arguments[1];
        } else {
            do {
                if (i in this) {
                    rv = this[i--];
                    break;
                }

                // if array contains no values, no initial value to return
                if (--i < 0)
                    throw new TypeError();
            } while (true);
        }

        for (; i >= 0; i--) {
            if (i in this)
                rv = fun.call(null, rv, this[i], i, this);
        }

        return rv;
    };
}

// ES5 15.4.4.14
if (!Array.prototype.indexOf) {
    Array.prototype.indexOf = function indexOf(value /*, fromIndex */ ) {
        var length = this.length;
        if (!length)
            return -1;
        var i = arguments[1] || 0;
        if (i >= length)
            return -1;
        if (i < 0)
            i += length;
        for (; i < length; i++) {
            if (!owns(this, i))
                continue;
            if (value === this[i])
                return i;
        }
        return -1;
    };
}

// ES5 15.4.4.15
if (!Array.prototype.lastIndexOf) {
    Array.prototype.lastIndexOf = function lastIndexOf(value /*, fromIndex */) {
        var length = this.length;
        if (!length)
            return -1;
        var i = arguments[1] || length;
        if (i < 0)
            i += length;
        i = Math.min(i, length - 1);
        for (; i >= 0; i--) {
            if (!owns(this, i))
                continue;
            if (value === this[i])
                return i;
        }
        return -1;
    };
}

//
// Object
// ======
//

// ES5 15.2.3.2
if (!Object.getPrototypeOf) {
    // https://github.com/kriskowal/es5-shim/issues#issue/2
    // http://ejohn.org/blog/objectgetprototypeof/
    // recommended by fschaefer on github
    Object.getPrototypeOf = function getPrototypeOf(object) {
        return object.__proto__ || object.constructor.prototype;
        // or undefined if not available in this engine
    };
}

// ES5 15.2.3.3
if (!Object.getOwnPropertyDescriptor) {
    var ERR_NON_OBJECT = "Object.getOwnPropertyDescriptor called on a " +
                         "non-object: ";
    Object.getOwnPropertyDescriptor = function getOwnPropertyDescriptor(object, property) {
        if ((typeof object !== "object" && typeof object !== "function") || object === null)
            throw new TypeError(ERR_NON_OBJECT + object);
        // If object does not owns property return undefined immediately.
        if (!owns(object, property))
            return undefined;

        var despriptor, getter, setter;

        // If object has a property then it's for sure both `enumerable` and
        // `configurable`.
        despriptor =  { enumerable: true, configurable: true };

        // If JS engine supports accessor properties then property may be a
        // getter or setter.
        if (supportsAccessors) {
            // Unfortunately `__lookupGetter__` will return a getter even
            // if object has own non getter property along with a same named
            // inherited getter. To avoid misbehavior we temporary remove
            // `__proto__` so that `__lookupGetter__` will return getter only
            // if it's owned by an object.
            var prototype = object.__proto__;
            object.__proto__ = prototypeOfObject;

            var getter = lookupGetter(object, property);
            var setter = lookupSetter(object, property);

            // Once we have getter and setter we can put values back.
            object.__proto__ = prototype;

            if (getter || setter) {
                if (getter) descriptor.get = getter;
                if (setter) descriptor.set = setter;

                // If it was accessor property we're done and return here
                // in order to avoid adding `value` to the descriptor.
                return descriptor;
            }
        }

        // If we got this far we know that object has an own property that is
        // not an accessor so we set it as a value and return descriptor.
        descriptor.value = object[property];
        return descriptor;
    };
}

// ES5 15.2.3.4
if (!Object.getOwnPropertyNames) {
    Object.getOwnPropertyNames = function getOwnPropertyNames(object) {
        return Object.keys(object);
    };
}

// ES5 15.2.3.5
if (!Object.create) {
    Object.create = function create(prototype, properties) {
        var object;
        if (prototype === null) {
            object = { "__proto__": null };
        } else {
            if (typeof prototype !== "object")
                throw new TypeError("typeof prototype["+(typeof prototype)+"] != 'object'");
            var Type = function () {};
            Type.prototype = prototype;
            object = new Type();
            // IE has no built-in implementation of `Object.getPrototypeOf`
            // neither `__proto__`, but this manually setting `__proto__` will
            // guarantee that `Object.getPrototypeOf` will work as expected with
            // objects created using `Object.create`
            object.__proto__ = prototype;
        }
        if (typeof properties !== "undefined")
            Object.defineProperties(object, properties);
        return object;
    };
}

// ES5 15.2.3.6
if (!Object.defineProperty) {
    var ERR_NON_OBJECT_DESCRIPTOR = "Property description must be an object: ";
    var ERR_NON_OBJECT_TARGET = "Object.defineProperty called on non-object: "
    var ERR_ACCESSORS_NOT_SUPPORTED = "getters & setters can not be defined " +
                                      "on this javascript engine";

    Object.defineProperty = function defineProperty(object, property, descriptor) {
        if (typeof object !== "object" && typeof object !== "function")
            throw new TypeError(ERR_NON_OBJECT_TARGET + object);
        if (typeof object !== "object" || object === null)
            throw new TypeError(ERR_NON_OBJECT_DESCRIPTOR + descriptor);

        // If it's a data property.
        if (owns(descriptor, "value")) {
            // fail silently if "writable", "enumerable", or "configurable"
            // are requested but not supported
            /*
            // alternate approach:
            if ( // can't implement these features; allow false but not true
                !(owns(descriptor, "writable") ? descriptor.writable : true) ||
                !(owns(descriptor, "enumerable") ? descriptor.enumerable : true) ||
                !(owns(descriptor, "configurable") ? descriptor.configurable : true)
            )
                throw new RangeError(
                    "This implementation of Object.defineProperty does not " +
                    "support configurable, enumerable, or writable."
                );
            */

            if (supportsAccessors && (lookupGetter(object, property) ||
                                      lookupSetter(object, property)))
            {
                // As accessors are supported only on engines implementing
                // `__proto__` we can safely override `__proto__` while defining
                // a property to make sure that we don't hit an inherited
                // accessor.
                var prototype = object.__proto__;
                object.__proto__ = prototypeOfObject;
                // Deleting a property anyway since getter / setter may be
                // defined on object itself.
                delete object[property];
                object[property] = descriptor.value;
                // Setting original `__proto__` back now.
                object.prototype;
            } else {
                object[property] = descriptor.value;
            }
        } else {
            if (!supportsAccessors)
                throw new TypeError(ERR_ACCESSORS_NOT_SUPPORTED);
            // If we got that far then getters and setters can be defined !!
            if (owns(descriptor, "get"))
                defineGetter(object, property, descriptor.get);
            if (owns(descriptor, "set"))
                defineSetter(object, property, descriptor.set);
        }

        return object;
    };
}

// ES5 15.2.3.7
if (!Object.defineProperties) {
    Object.defineProperties = function defineProperties(object, properties) {
        for (var property in properties) {
            if (owns(properties, property))
                Object.defineProperty(object, property, properties[property]);
        }
        return object;
    };
}

// ES5 15.2.3.8
if (!Object.seal) {
    Object.seal = function seal(object) {
        // this is misleading and breaks feature-detection, but
        // allows "securable" code to "gracefully" degrade to working
        // but insecure code.
        return object;
    };
}

// ES5 15.2.3.9
if (!Object.freeze) {
    Object.freeze = function freeze(object) {
        // this is misleading and breaks feature-detection, but
        // allows "securable" code to "gracefully" degrade to working
        // but insecure code.
        return object;
    };
}

// detect a Rhino bug and patch it
try {
    Object.freeze(function () {});
} catch (exception) {
    Object.freeze = (function freeze(freezeObject) {
        return function freeze(object) {
            if (typeof object === "function") {
                return object;
            } else {
                return freezeObject(object);
            }
        };
    })(Object.freeze);
}

// ES5 15.2.3.10
if (!Object.preventExtensions) {
    Object.preventExtensions = function preventExtensions(object) {
        // this is misleading and breaks feature-detection, but
        // allows "securable" code to "gracefully" degrade to working
        // but insecure code.
        return object;
    };
}

// ES5 15.2.3.11
if (!Object.isSealed) {
    Object.isSealed = function isSealed(object) {
        return false;
    };
}

// ES5 15.2.3.12
if (!Object.isFrozen) {
    Object.isFrozen = function isFrozen(object) {
        return false;
    };
}

// ES5 15.2.3.13
if (!Object.isExtensible) {
    Object.isExtensible = function isExtensible(object) {
        return true;
    };
}

// ES5 15.2.3.14
// http://whattheheadsaid.com/2010/10/a-safer-object-keys-compatibility-implementation
if (!Object.keys) {

    var hasDontEnumBug = true,
        dontEnums = [
            'toString',
            'toLocaleString',
            'valueOf',
            'hasOwnProperty',
            'isPrototypeOf',
            'propertyIsEnumerable',
            'constructor'
        ],
        dontEnumsLength = dontEnums.length;

    for (var key in {"toString": null})
        hasDontEnumBug = false;

    Object.keys = function keys(object) {

        if (
            typeof object !== "object" && typeof object !== "function"
            || object === null
        )
            throw new TypeError("Object.keys called on a non-object");

        var keys = [];
        for (var name in object) {
            if (owns(object, name)) {
                keys.push(name);
            }
        }

        if (hasDontEnumBug) {
            for (var i = 0, ii = dontEnumsLength; i < ii; i++) {
                var dontEnum = dontEnums[i];
                if (owns(object, dontEnum)) {
                    keys.push(dontEnum);
                }
            }
        }

        return keys;
    };

}

//
// Date
// ====
//

// ES5 15.9.5.43
// Format a Date object as a string according to a subset of the ISO-8601 standard.
// Useful in Atom, among other things.
if (!Date.prototype.toISOString) {
    Date.prototype.toISOString = function toISOString() {
        return (
            this.getUTCFullYear() + "-" +
            (this.getUTCMonth() + 1) + "-" +
            this.getUTCDate() + "T" +
            this.getUTCHours() + ":" +
            this.getUTCMinutes() + ":" +
            this.getUTCSeconds() + "Z"
        );
    }
}

// ES5 15.9.4.4
if (!Date.now) {
    Date.now = function now() {
        return new Date().getTime();
    };
}

// ES5 15.9.5.44
if (!Date.prototype.toJSON) {
    Date.prototype.toJSON = function toJSON(key) {
        // This function provides a String representation of a Date object for
        // use by JSON.stringify (15.12.3). When the toJSON method is called
        // with argument key, the following steps are taken:

        // 1.  Let O be the result of calling ToObject, giving it the this
        // value as its argument.
        // 2. Let tv be ToPrimitive(O, hint Number).
        // 3. If tv is a Number and is not finite, return null.
        // XXX
        // 4. Let toISO be the result of calling the [[Get]] internal method of
        // O with argument "toISOString".
        // 5. If IsCallable(toISO) is false, throw a TypeError exception.
        if (typeof this.toISOString !== "function")
            throw new TypeError();
        // 6. Return the result of calling the [[Call]] internal method of
        // toISO with O as the this value and an empty argument list.
        return this.toISOString();

        // NOTE 1 The argument is ignored.

        // NOTE 2 The toJSON function is intentionally generic; it does not
        // require that its this value be a Date object. Therefore, it can be
        // transferred to other kinds of objects for use as a method. However,
        // it does require that any such object have a toISOString method. An
        // object is free to use the argument key to filter its
        // stringification.
    };
}

// 15.9.4.2 Date.parse (string)
// 15.9.1.15 Date Time String Format
// Date.parse
// based on work shared by Daniel Friesen (dantman)
// http://gist.github.com/303249
if (isNaN(Date.parse("T00:00"))) {
    // XXX global assignment won't work in embeddings that use
    // an alternate object for the context.
    Date = (function(NativeDate) {

        // Date.length === 7
        var Date = function(Y, M, D, h, m, s, ms) {
            var length = arguments.length;
            if (this instanceof NativeDate) {
                var date = length === 1 && String(Y) === Y ? // isString(Y)
                    // We explicitly pass it through parse:
                    new NativeDate(Date.parse(Y)) :
                    // We have to manually make calls depending on argument
                    // length here
                    length >= 7 ? new NativeDate(Y, M, D, h, m, s, ms) :
                    length >= 6 ? new NativeDate(Y, M, D, h, m, s) :
                    length >= 5 ? new NativeDate(Y, M, D, h, m) :
                    length >= 4 ? new NativeDate(Y, M, D, h) :
                    length >= 3 ? new NativeDate(Y, M, D) :
                    length >= 2 ? new NativeDate(Y, M) :
                    length >= 1 ? new NativeDate(Y) :
                                  new NativeDate();
                // Prevent mixups with unfixed Date object
                date.constructor = Date;
                return date;
            }
            return NativeDate.apply(this, arguments);
        };

        // 15.9.1.15 Date Time String Format
        var isoDateExpression = new RegExp("^" +
            "(?:" + // optional year-month-day
                "(" + // year capture
                    "(?:[+-]\\d\\d)?" + // 15.9.1.15.1 Extended years
                    "\\d\\d\\d\\d" + // four-digit year
                ")" +
                "(?:-" + // optional month-day
                    "(\\d\\d)" + // month capture
                    "(?:-" + // optional day
                        "(\\d\\d)" + // day capture
                    ")?" +
                ")?" +
            ")?" +
            "(?:T" + // hour:minute:second.subsecond
                "(\\d\\d)" + // hour capture
                ":(\\d\\d)" + // minute capture
                "(?::" + // optional :second.subsecond
                    "(\\d\\d)" + // second capture
                    "(?:\\.(\\d\\d\\d))?" + // milisecond capture
                ")?" +
            ")?" +
            "(?:" + // time zone
                "Z|" + // UTC capture
                "([+-])(\\d\\d):(\\d\\d)" + // timezone offset
                // capture sign, hour, minute
            ")?" +
        "$");

        // Copy any custom methods a 3rd party library may have added
        for (var key in NativeDate)
            Date[key] = NativeDate[key];

        // Copy "native" methods explicitly; they may be non-enumerable
        Date.now = NativeDate.now;
        Date.UTC = NativeDate.UTC;
        Date.prototype = NativeDate.prototype;
        Date.prototype.constructor = Date;

        // Upgrade Date.parse to handle the ISO dates we use
        // TODO review specification to ascertain whether it is
        // necessary to implement partial ISO date strings.
        Date.parse = function parse(string) {
            var match = isoDateExpression.exec(string);
            if (match) {
                match.shift(); // kill match[0], the full match
                // recognize times without dates before normalizing the
                // numeric values, for later use
                var timeOnly = match[0] === undefined;
                // parse numerics
                for (var i = 0; i < 10; i++) {
                    // skip + or - for the timezone offset
                    if (i === 7)
                        continue;
                    // Note: parseInt would read 0-prefix numbers as
                    // octal.  Number constructor or unary + work better
                    // here:
                    match[i] = +(match[i] || (i < 3 ? 1 : 0));
                    // match[1] is the month. Months are 0-11 in JavaScript
                    // Date objects, but 1-12 in ISO notation, so we
                    // decrement.
                    if (i === 1)
                        match[i]--;
                }
                // if no year-month-date is provided, return a milisecond
                // quantity instead of a UTC date number value.
                if (timeOnly)
                    return ((match[3] * 60 + match[4]) * 60 + match[5]) * 1000 + match[6];

                // account for an explicit time zone offset if provided
                var offset = (match[8] * 60 + match[9]) * 60 * 1000;
                if (match[6] === "-")
                    offset = -offset;

                return NativeDate.UTC.apply(this, match.slice(0, 7)) + offset;
            }
            return NativeDate.parse.apply(this, arguments);
        };

        return Date;
    })(Date);
}

//
// String
// ======
//

// ES5 15.5.4.20
if (!String.prototype.trim) {
    // http://blog.stevenlevithan.com/archives/faster-trim-javascript
    var trimBeginRegexp = /^\s\s*/;
    var trimEndRegexp = /\s\s*$/;
    String.prototype.trim = function trim() {
        return String(this).replace(trimBeginRegexp, '').replace(trimEndRegexp, '');
    };
}

});/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Mozilla Skywriter.
 *
 * The Initial Developer of the Original Code is
 * Mozilla.
 * Portions created by the Initial Developer are Copyright (C) 2009
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Kevin Dangoor (kdangoor@mozilla.com)
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('ace/ace', ['require', 'exports', 'module' , 'pilot/index', 'pilot/fixoldbrowsers', 'pilot/plugin_manager', 'pilot/dom', 'pilot/event', 'ace/editor', 'ace/edit_session', 'ace/undomanager', 'ace/virtual_renderer', 'ace/theme/textmate', 'pilot/environment'], function(require, exports, module) {

    require("pilot/index");
    require("pilot/fixoldbrowsers");
    var catalog = require("pilot/plugin_manager").catalog;
    catalog.registerPlugins([ "pilot/index" ]);

    var Dom = require("pilot/dom");
    var Event = require("pilot/event");

    var Editor = require("ace/editor").Editor;
    var EditSession = require("ace/edit_session").EditSession;
    var UndoManager = require("ace/undomanager").UndoManager;
    var Renderer = require("ace/virtual_renderer").VirtualRenderer;

    exports.edit = function(el) {
        if (typeof(el) == "string") {
            el = document.getElementById(el);
        }

        var doc = new EditSession(Dom.getInnerText(el));
        doc.setUndoManager(new UndoManager());
        el.innerHTML = '';

        var editor = new Editor(new Renderer(el, require("ace/theme/textmate")));
        editor.setSession(doc);

        var env = require("pilot/environment").create();
        catalog.startupPlugins({ env: env }).then(function() {
            env.document = doc;
            env.editor = editor;
            editor.resize();
            Event.addListener(window, "resize", function() {
                editor.resize();
            });
            el.env = env;
        });
        // Store env on editor such that it can be accessed later on from
        // the returned object.
        editor.env = env;
        return editor;
    };
});/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Mozilla Skywriter.
 *
 * The Initial Developer of the Original Code is
 * Mozilla.
 * Portions created by the Initial Developer are Copyright (C) 2009
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Kevin Dangoor (kdangoor@mozilla.com)
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('pilot/index', ['require', 'exports', 'module' , 'pilot/fixoldbrowsers', 'pilot/types/basic', 'pilot/types/command', 'pilot/types/settings', 'pilot/commands/settings', 'pilot/commands/basic', 'pilot/settings/canon', 'pilot/canon'], function(require, exports, module) {

exports.startup = function(data, reason) {
    require('pilot/fixoldbrowsers');

    require('pilot/types/basic').startup(data, reason);
    require('pilot/types/command').startup(data, reason);
    require('pilot/types/settings').startup(data, reason);
    require('pilot/commands/settings').startup(data, reason);
    require('pilot/commands/basic').startup(data, reason);
    // require('pilot/commands/history').startup(data, reason);
    require('pilot/settings/canon').startup(data, reason);
    require('pilot/canon').startup(data, reason);
};

exports.shutdown = function(data, reason) {
    require('pilot/types/basic').shutdown(data, reason);
    require('pilot/types/command').shutdown(data, reason);
    require('pilot/types/settings').shutdown(data, reason);
    require('pilot/commands/settings').shutdown(data, reason);
    require('pilot/commands/basic').shutdown(data, reason);
    // require('pilot/commands/history').shutdown(data, reason);
    require('pilot/settings/canon').shutdown(data, reason);
    require('pilot/canon').shutdown(data, reason);
};


});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Mozilla Skywriter.
 *
 * The Initial Developer of the Original Code is
 * Mozilla.
 * Portions created by the Initial Developer are Copyright (C) 2009
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Joe Walker (jwalker@mozilla.com)
 *      Kevin Dangoor (kdangoor@mozilla.com)
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('pilot/types/basic', ['require', 'exports', 'module' , 'pilot/types'], function(require, exports, module) {

var types = require("pilot/types");
var Type = types.Type;
var Conversion = types.Conversion;
var Status = types.Status;

/**
 * These are the basic types that we accept. They are vaguely based on the
 * Jetpack settings system (https://wiki.mozilla.org/Labs/Jetpack/JEP/24)
 * although clearly more restricted.
 *
 * <p>In addition to these types, Jetpack also accepts range, member, password
 * that we are thinking of adding.
 *
 * <p>This module probably should not be accessed directly, but instead used
 * through types.js
 */

/**
 * 'text' is the default if no type is given.
 */
var text = new Type();

text.stringify = function(value) {
    return value;
};

text.parse = function(value) {
    if (typeof value != 'string') {
        throw new Error('non-string passed to text.parse()');
    }
    return new Conversion(value);
};

text.name = 'text';

/**
 * We don't currently plan to distinguish between integers and floats
 */
var number = new Type();

number.stringify = function(value) {
    if (!value) {
        return null;
    }
    return '' + value;
};

number.parse = function(value) {
    if (typeof value != 'string') {
        throw new Error('non-string passed to number.parse()');
    }

    if (value.replace(/\s/g, '').length === 0) {
        return new Conversion(null, Status.INCOMPLETE, '');
    }

    var reply = new Conversion(parseInt(value, 10));
    if (isNaN(reply.value)) {
        reply.status = Status.INVALID;
        reply.message = 'Can\'t convert "' + value + '" to a number.';
    }

    return reply;
};

number.decrement = function(value) {
    return value - 1;
};

number.increment = function(value) {
    return value + 1;
};

number.name = 'number';

/**
 * One of a known set of options
 */
function SelectionType(typeSpec) {
    if (!Array.isArray(typeSpec.data) && typeof typeSpec.data !== 'function') {
        throw new Error('instances of SelectionType need typeSpec.data to be an array or function that returns an array:' + JSON.stringify(typeSpec));
    }
    Object.keys(typeSpec).forEach(function(key) {
        this[key] = typeSpec[key];
    }, this);
};

SelectionType.prototype = new Type();

SelectionType.prototype.stringify = function(value) {
    return value;
};

SelectionType.prototype.parse = function(str) {
    if (typeof str != 'string') {
        throw new Error('non-string passed to parse()');
    }
    if (!this.data) {
        throw new Error('Missing data on selection type extension.');
    }
    var data = (typeof(this.data) === 'function') ? this.data() : this.data;

    // The matchedValue could be the boolean value false
    var hasMatched = false;
    var matchedValue;
    var completions = [];
    data.forEach(function(option) {
        if (str == option) {
            matchedValue = this.fromString(option);
            hasMatched = true;
        }
        else if (option.indexOf(str) === 0) {
            completions.push(this.fromString(option));
        }
    }, this);

    if (hasMatched) {
        return new Conversion(matchedValue);
    }
    else {
        // This is something of a hack it basically allows us to tell the
        // setting type to forget its last setting hack.
        if (this.noMatch) {
            this.noMatch();
        }

        if (completions.length > 0) {
            var msg = 'Possibilities' +
                (str.length === 0 ? '' : ' for \'' + str + '\'');
            return new Conversion(null, Status.INCOMPLETE, msg, completions);
        }
        else {
            var msg = 'Can\'t use \'' + str + '\'.';
            return new Conversion(null, Status.INVALID, msg, completions);
        }
    }
};

SelectionType.prototype.fromString = function(str) {
    return str;
};

SelectionType.prototype.decrement = function(value) {
    var data = (typeof this.data === 'function') ? this.data() : this.data;
    var index;
    if (value == null) {
        index = data.length - 1;
    }
    else {
        var name = this.stringify(value);
        var index = data.indexOf(name);
        index = (index === 0 ? data.length - 1 : index - 1);
    }
    return this.fromString(data[index]);
};

SelectionType.prototype.increment = function(value) {
    var data = (typeof this.data === 'function') ? this.data() : this.data;
    var index;
    if (value == null) {
        index = 0;
    }
    else {
        var name = this.stringify(value);
        var index = data.indexOf(name);
        index = (index === data.length - 1 ? 0 : index + 1);
    }
    return this.fromString(data[index]);
};

SelectionType.prototype.name = 'selection';

/**
 * SelectionType is a base class for other types
 */
exports.SelectionType = SelectionType;

/**
 * true/false values
 */
var bool = new SelectionType({
    name: 'bool',
    data: [ 'true', 'false' ],
    stringify: function(value) {
        return '' + value;
    },
    fromString: function(str) {
        return str === 'true' ? true : false;
    }
});


/**
 * A we don't know right now, but hope to soon.
 */
function DeferredType(typeSpec) {
    if (typeof typeSpec.defer !== 'function') {
        throw new Error('Instances of DeferredType need typeSpec.defer to be a function that returns a type');
    }
    Object.keys(typeSpec).forEach(function(key) {
        this[key] = typeSpec[key];
    }, this);
};

DeferredType.prototype = new Type();

DeferredType.prototype.stringify = function(value) {
    return this.defer().stringify(value);
};

DeferredType.prototype.parse = function(value) {
    return this.defer().parse(value);
};

DeferredType.prototype.decrement = function(value) {
    var deferred = this.defer();
    return (deferred.decrement ? deferred.decrement(value) : undefined);
};

DeferredType.prototype.increment = function(value) {
    var deferred = this.defer();
    return (deferred.increment ? deferred.increment(value) : undefined);
};

DeferredType.prototype.name = 'deferred';

/**
 * DeferredType is a base class for other types
 */
exports.DeferredType = DeferredType;


/**
 * A set of objects of the same type
 */
function ArrayType(typeSpec) {
    if (typeSpec instanceof Type) {
        this.subtype = typeSpec;
    }
    else if (typeof typeSpec === 'string') {
        this.subtype = types.getType(typeSpec);
        if (this.subtype == null) {
            throw new Error('Unknown array subtype: ' + typeSpec);
        }
    }
    else {
        throw new Error('Can\' handle array subtype');
    }
};

ArrayType.prototype = new Type();

ArrayType.prototype.stringify = function(values) {
    // TODO: Check for strings with spaces and add quotes
    return values.join(' ');
};

ArrayType.prototype.parse = function(value) {
    return this.defer().parse(value);
};

ArrayType.prototype.name = 'array';

/**
 * Registration and de-registration.
 */
var isStarted = false;
exports.startup = function() {
    if (isStarted) {
        return;
    }
    isStarted = true;
    types.registerType(text);
    types.registerType(number);
    types.registerType(bool);
    types.registerType(SelectionType);
    types.registerType(DeferredType);
    types.registerType(ArrayType);
};

exports.shutdown = function() {
    isStarted = false;
    types.unregisterType(text);
    types.unregisterType(number);
    types.unregisterType(bool);
    types.unregisterType(SelectionType);
    types.unregisterType(DeferredType);
    types.unregisterType(ArrayType);
};


});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Skywriter.
 *
 * The Initial Developer of the Original Code is
 * Mozilla.
 * Portions created by the Initial Developer are Copyright (C) 2009
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Joe Walker (jwalker@mozilla.com)
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('pilot/types', ['require', 'exports', 'module' ], function(require, exports, module) {

/**
 * Some types can detect validity, that is to say they can distinguish between
 * valid and invalid values.
 * TODO: Change these constants to be numbers for more performance?
 */
var Status = {
    /**
     * The conversion process worked without any problem, and the value is
     * valid. There are a number of failure states, so the best way to check
     * for failure is (x !== Status.VALID)
     */
    VALID: {
        toString: function() { return 'VALID'; },
        valueOf: function() { return 0; }
    },

    /**
     * A conversion process failed, however it was noted that the string
     * provided to 'parse()' could be VALID by the addition of more characters,
     * so the typing may not be actually incorrect yet, just unfinished.
     * @see Status.INVALID
     */
    INCOMPLETE: {
        toString: function() { return 'INCOMPLETE'; },
        valueOf: function() { return 1; }
    },

    /**
     * The conversion process did not work, the value should be null and a
     * reason for failure should have been provided. In addition some completion
     * values may be available.
     * @see Status.INCOMPLETE
     */
    INVALID: {
        toString: function() { return 'INVALID'; },
        valueOf: function() { return 2; }
    },

    /**
     * A combined status is the worser of the provided statuses
     */
    combine: function(statuses) {
        var combined = Status.VALID;
        for (var i = 0; i < statuses.length; i++) {
            if (statuses[i].valueOf() > combined.valueOf()) {
                combined = statuses[i];
            }
        }
        return combined;
    }
};
exports.Status = Status;

/**
 * The type.parse() method returns a Conversion to inform the user about not
 * only the result of a Conversion but also about what went wrong.
 * We could use an exception, and throw if the conversion failed, but that
 * seems to violate the idea that exceptions should be exceptional. Typos are
 * not. Also in order to store both a status and a message we'd still need
 * some sort of exception type...
 */
function Conversion(value, status, message, predictions) {
    /**
     * The result of the conversion process. Will be null if status != VALID
     */
    this.value = value;

    /**
     * The status of the conversion.
     * @see Status
     */
    this.status = status || Status.VALID;

    /**
     * A message to go with the conversion. This could be present for any status
     * including VALID in the case where we want to note a warning for example.
     * I18N: On the one hand this nasty and un-internationalized, however with
     * a command line it is hard to know where to start.
     */
    this.message = message;

    /**
     * A array of strings which are the systems best guess at better inputs than
     * the one presented.
     * We generally expect there to be about 7 predictions (to match human list
     * comprehension ability) however it is valid to provide up to about 20,
     * or less. It is the job of the predictor to decide a smart cut-off.
     * For example if there are 4 very good matches and 4 very poor ones,
     * probably only the 4 very good matches should be presented.
     */
    this.predictions = predictions || [];
}
exports.Conversion = Conversion;

/**
 * Most of our types are 'static' e.g. there is only one type of 'text', however
 * some types like 'selection' and 'deferred' are customizable. The basic
 * Type type isn't useful, but does provide documentation about what types do.
 */
function Type() {
};
Type.prototype = {
    /**
     * Convert the given <tt>value</tt> to a string representation.
     * Where possible, there should be round-tripping between values and their
     * string representations.
     */
    stringify: function(value) { throw new Error("not implemented"); },

    /**
     * Convert the given <tt>str</tt> to an instance of this type.
     * Where possible, there should be round-tripping between values and their
     * string representations.
     * @return Conversion
     */
    parse: function(str) { throw new Error("not implemented"); },

    /**
     * The plug-in system, and other things need to know what this type is
     * called. The name alone is not enough to fully specify a type. Types like
     * 'selection' and 'deferred' need extra data, however this function returns
     * only the name, not the extra data.
     * <p>In old bespin, equality was based on the name. This may turn out to be
     * important in Ace too.
     */
    name: undefined,

    /**
     * If there is some concept of a higher value, return it,
     * otherwise return undefined.
     */
    increment: function(value) {
        return undefined;
    },

    /**
     * If there is some concept of a lower value, return it,
     * otherwise return undefined.
     */
    decrement: function(value) {
        return undefined;
    },

    /**
     * There is interesting information (like predictions) in a conversion of
     * nothing, the output of this can sometimes be customized.
     * @return Conversion
     */
    getDefault: function() {
        return this.parse('');
    }
};
exports.Type = Type;

/**
 * Private registry of types
 * Invariant: types[name] = type.name
 */
var types = {};

/**
 * Add a new type to the list available to the system.
 * You can pass 2 things to this function - either an instance of Type, in
 * which case we return this instance when #getType() is called with a 'name'
 * that matches type.name.
 * Also you can pass in a constructor (i.e. function) in which case when
 * #getType() is called with a 'name' that matches Type.prototype.name we will
 * pass the typeSpec into this constructor. See #reconstituteType().
 */
exports.registerType = function(type) {
    if (typeof type === 'object') {
        if (type instanceof Type) {
            if (!type.name) {
                throw new Error('All registered types must have a name');
            }
            types[type.name] = type;
        }
        else {
            throw new Error('Can\'t registerType using: ' + type);
        }
    }
    else if (typeof type === 'function') {
        if (!type.prototype.name) {
            throw new Error('All registered types must have a name');
        }
        types[type.prototype.name] = type;
    }
    else {
        throw new Error('Unknown type: ' + type);
    }
};

exports.registerTypes = function registerTypes(types) {
    Object.keys(types).forEach(function (name) {
        var type = types[name];
        type.name = name;
        exports.registerType(type);
    });
};

/**
 * Remove a type from the list available to the system
 */
exports.deregisterType = function(type) {
    delete types[type.name];
};

/**
 * See description of #exports.registerType()
 */
function reconstituteType(name, typeSpec) {
    if (name.substr(-2) === '[]') { // i.e. endsWith('[]')
        var subtypeName = name.slice(0, -2);
        return new types['array'](subtypeName);
    }

    var type = types[name];
    if (typeof type === 'function') {
        type = new type(typeSpec);
    }
    return type;
}

/**
 * Find a type, previously registered using #registerType()
 */
exports.getType = function(typeSpec) {
    if (typeof typeSpec === 'string') {
        return reconstituteType(typeSpec);
    }

    if (typeof typeSpec === 'object') {
        if (!typeSpec.name) {
            throw new Error('Missing \'name\' member to typeSpec');
        }
        return reconstituteType(typeSpec.name, typeSpec);
    }

    throw new Error('Can\'t extract type from ' + typeSpec);
};


});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Mozilla Skywriter.
 *
 * The Initial Developer of the Original Code is
 * Mozilla.
 * Portions created by the Initial Developer are Copyright (C) 2009
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Joe Walker (jwalker@mozilla.com)
 *      Kevin Dangoor (kdangoor@mozilla.com)
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('pilot/types/command', ['require', 'exports', 'module' , 'pilot/canon', 'pilot/types/basic', 'pilot/types'], function(require, exports, module) {

var canon = require("pilot/canon");
var SelectionType = require("pilot/types/basic").SelectionType;
var types = require("pilot/types");


/**
 * Select from the available commands
 */
var command = new SelectionType({
    name: 'command',
    data: function() {
        return canon.getCommandNames();
    },
    stringify: function(command) {
        return command.name;
    },
    fromString: function(str) {
        return canon.getCommand(str);
    }
});


/**
 * Registration and de-registration.
 */
exports.startup = function() {
    types.registerType(command);
};

exports.shutdown = function() {
    types.unregisterType(command);
};


});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Mozilla Skywriter.
 *
 * The Initial Developer of the Original Code is
 * Mozilla.
 * Portions created by the Initial Developer are Copyright (C) 2009
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Joe Walker (jwalker@mozilla.com)
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('pilot/canon', ['require', 'exports', 'module' , 'pilot/console', 'pilot/stacktrace', 'pilot/oop', 'pilot/useragent', 'pilot/keys', 'pilot/event_emitter', 'pilot/typecheck', 'pilot/catalog', 'pilot/types', 'pilot/lang'], function(require, exports, module) {

var console = require('pilot/console');
var Trace = require('pilot/stacktrace').Trace;
var oop = require('pilot/oop');
var useragent = require('pilot/useragent');
var keyUtil = require('pilot/keys');
var EventEmitter = require('pilot/event_emitter').EventEmitter;
var typecheck = require('pilot/typecheck');
var catalog = require('pilot/catalog');
var Status = require('pilot/types').Status;
var types = require('pilot/types');
var lang = require('pilot/lang');

/*
// TODO: this doesn't belong here - or maybe anywhere?
var dimensionsChangedExtensionSpec = {
    name: 'dimensionsChanged',
    description: 'A dimensionsChanged is a way to be notified of ' +
            'changes to the dimension of Skywriter'
};
exports.startup = function(data, reason) {
    catalog.addExtensionSpec(commandExtensionSpec);
};
exports.shutdown = function(data, reason) {
    catalog.removeExtensionSpec(commandExtensionSpec);
};
*/

var commandExtensionSpec = {
    name: 'command',
    description: 'A command is a bit of functionality with optional ' +
            'typed arguments which can do something small like moving ' +
            'the cursor around the screen, or large like cloning a ' +
            'project from VCS.',
    indexOn: 'name'
};

exports.startup = function(data, reason) {
    // TODO: this is probably all kinds of evil, but we need something working
    catalog.addExtensionSpec(commandExtensionSpec);
};

exports.shutdown = function(data, reason) {
    catalog.removeExtensionSpec(commandExtensionSpec);
};

/**
 * Manage a list of commands in the current canon
 */

/**
 * A Command is a discrete action optionally with a set of ways to customize
 * how it happens. This is here for documentation purposes.
 * TODO: Document better
 */
var thingCommand = {
    name: 'thing',
    description: 'thing is an example command',
    params: [{
        name: 'param1',
        description: 'an example parameter',
        type: 'text',
        defaultValue: null
    }],
    exec: function(env, args, request) {
        thing();
    }
};

/**
 * A lookup hash of our registered commands
 */
var commands = {};

/**
 * A lookup has for command key bindings that use a string as sender.
 */
var commmandKeyBinding = {};

/**
 * Array with command key bindings that use a function to determ the sender.
 */
var commandKeyBindingFunc = { };

function splitSafe(s, separator, limit, bLowerCase) {
    return (bLowerCase && s.toLowerCase() || s)
        .replace(/(?:^\s+|\n|\s+$)/g, "")
        .split(new RegExp("[\\s ]*" + separator + "[\\s ]*", "g"), limit || 999);
}

function parseKeys(keys, val, ret) {
    var key,
        hashId = 0,
        parts  = splitSafe(keys, "\\-", null, true),
        i      = 0,
        l      = parts.length;

    for (; i < l; ++i) {
        if (keyUtil.KEY_MODS[parts[i]])
            hashId = hashId | keyUtil.KEY_MODS[parts[i]];
        else
            key = parts[i] || "-"; //when empty, the splitSafe removed a '-'
    }

    if (ret == null) {
        return {
            key: key,
            hashId: hashId
        }   
    } else {
        (ret[hashId] || (ret[hashId] = {}))[key] = val;
    }
}

var platform = useragent.isMac ? "mac" : "win";
function buildKeyHash(command) {
    var binding = command.bindKey,
        key = binding[platform],
        ckb = commmandKeyBinding,
        ckbf = commandKeyBindingFunc

    if (!binding.sender) {
        throw new Error('All key bindings must have a sender');   
    }
    if (!binding.mac && binding.mac !== null) {
        throw new Error('All key bindings must have a mac key binding');
    }
    if (!binding.win && binding.win !== null) {
        throw new Error('All key bindings must have a windows key binding');
    }
    if(!binding[platform]) {
        // No keymapping for this platform.
        return;   
    }
    if (typeof binding.sender == 'string') {
        var targets = splitSafe(binding.sender, "\\|", null, true);
        targets.forEach(function(target) {
            if (!ckb[target]) {
                ckb[target] = { };
            }
            key.split("|").forEach(function(keyPart) {
                parseKeys(keyPart, command, ckb[target]);        
            });
        });
    } else if (typecheck.isFunction(binding.sender)) {
        var val = {
            command: command,
            sender:  binding.sender
        };
        
        keyData = parseKeys(key);
        if (!ckbf[keyData.hashId]) {
            ckbf[keyData.hashId] = { };
        }
        if (!ckbf[keyData.hashId][keyData.key]) {
            ckbf[keyData.hashId][keyData.key] = [ val ];   
        } else {
            ckbf[keyData.hashId][keyData.key].push(val);
        }
    } else {
        throw new Error('Key binding must have a sender that is a string or function');   
    }
}

function findKeyCommand(env, sender, hashId, textOrKey) {
    // Convert keyCode to the string representation.
    if (typecheck.isNumber(textOrKey)) {
        textOrKey = keyUtil.keyCodeToString(textOrKey);
    }
    
    // Check bindings with functions as sender first.    
    var bindFuncs = (commandKeyBindingFunc[hashId]  || {})[textOrKey] || [];
    for (var i = 0; i < bindFuncs.length; i++) {
        if (bindFuncs[i].sender(env, sender, hashId, textOrKey)) {
            return bindFuncs[i].command;
        }
    }
    
    var ckbr = commmandKeyBinding[sender]
    return ckbr && ckbr[hashId] && ckbr[hashId][textOrKey];
}

function execKeyCommand(env, sender, hashId, textOrKey) {
    var command = findKeyCommand(env, sender, hashId, textOrKey);
    if (command) {
        return exec(command, env, sender, { });   
    } else {
        return false;
    }
}

/**
 * A sorted list of command names, we regularly want them in order, so pre-sort
 */
var commandNames = [];

/**
 * This registration method isn't like other Ace registration methods because
 * it doesn't return a decorated command because there is no functional
 * decoration to be done.
 * TODO: Are we sure that in the future there will be no such decoration?
 */
function addCommand(command) {
    if (!command.name) {
        throw new Error('All registered commands must have a name');
    }
    if (command.params == null) {
        command.params = [];
    }
    if (!Array.isArray(command.params)) {
        throw new Error('command.params must be an array in ' + command.name);
    }
    // Replace the type
    command.params.forEach(function(param) {
        if (!param.name) {
            throw new Error('In ' + command.name + ': all params must have a name');
        }
        upgradeType(command.name, param);
    }, this);
    commands[command.name] = command;

    if (command.bindKey) {
        buildKeyHash(command);   
    }

    commandNames.push(command.name);
    commandNames.sort();
};

function upgradeType(name, param) {
    var lookup = param.type;
    param.type = types.getType(lookup);
    if (param.type == null) {
        throw new Error('In ' + name + '/' + param.name +
            ': can\'t find type for: ' + JSON.stringify(lookup));
    }
}

function removeCommand(command) {
    var name = (typeof command === 'string' ? command : command.name);
    delete commands[name];
    lang.arrayRemove(commandNames, name);
};

function getCommand(name) {
    return commands[name];
};

function getCommandNames() {
    return commandNames;
};

/**
 * Default ArgumentProvider that is used if no ArgumentProvider is provided
 * by the command's sender.
 */
function defaultArgsProvider(request, callback) {
    var args  = request.args,
        params = request.command.params;

    for (var i = 0; i < params.length; i++) {
        var param = params[i];

        // If the parameter is already valid, then don't ask for it anymore.
        if (request.getParamStatus(param) != Status.VALID ||
            // Ask for optional parameters as well.
            param.defaultValue === null) 
        {
            var paramPrompt = param.description;
            if (param.defaultValue === null) {
                paramPrompt += " (optional)";
            }
            var value = prompt(paramPrompt, param.defaultValue || "");
            // No value but required -> nope.
            if (!value) {
                callback();
                return;
            } else {
                args[param.name] = value;
            }           
        }
    }
    callback();
}

/**
 * Entry point for keyboard accelerators or anything else that wants to execute
 * a command. A new request object is created and a check performed, if the
 * passed in arguments are VALID/INVALID or INCOMPLETE. If they are INCOMPLETE
 * the ArgumentProvider on the sender is called or otherwise the default 
 * ArgumentProvider to get the still required arguments.
 * If they are valid (or valid after the ArgumentProvider is done), the command
 * is executed.
 * 
 * @param command   Either a command, or the name of one
 * @param env       Current environment to execute the command in
 * @param sender    String that should be the same as the senderObject stored on 
 *                  the environment in env[sender]
 * @param args      Arguments for the command
 * @param typed     (Optional)
 */
function exec(command, env, sender, args, typed) {
    if (typeof command === 'string') {
        command = commands[command];
    }
    if (!command) {
        // TODO: Should we complain more than returning false?
        return false;
    }

    var request = new Request({
        sender: sender,
        command: command,
        args: args || {},
        typed: typed
    });
    
    /**
     * Executes the command and ensures request.done is called on the request in 
     * case it's not marked to be done already or async.
     */
    function execute() {
        command.exec(env, request.args, request);
        
        // If the request isn't asnync and isn't done, then make it done.
        if (!request.isAsync && !request.isDone) {
            request.done();
        }
    }
    
    
    if (request.getStatus() == Status.INVALID) {
        console.error("Canon.exec: Invalid parameter(s) passed to " + 
                            command.name);
        return false;   
    } 
    // If the request isn't complete yet, try to complete it.
    else if (request.getStatus() == Status.INCOMPLETE) {
        // Check if the sender has a ArgsProvider, otherwise use the default
        // build in one.
        var argsProvider;
        var senderObj = env[sender];
        if (!senderObj || !senderObj.getArgsProvider ||
            !(argsProvider = senderObj.getArgsProvider())) 
        {
            argsProvider = defaultArgsProvider;
        }

        // Ask the paramProvider to complete the request.
        argsProvider(request, function() {
            if (request.getStatus() == Status.VALID) {
                execute();
            }
        });
        return true;
    } else {
        execute();
        return true;
    }
};

exports.removeCommand = removeCommand;
exports.addCommand = addCommand;
exports.getCommand = getCommand;
exports.getCommandNames = getCommandNames;
exports.findKeyCommand = findKeyCommand;
exports.exec = exec;
exports.execKeyCommand = execKeyCommand;
exports.upgradeType = upgradeType;


/**
 * We publish a 'output' event whenever new command begins output
 * TODO: make this more obvious
 */
oop.implement(exports, EventEmitter);


/**
 * Current requirements are around displaying the command line, and provision
 * of a 'history' command and cursor up|down navigation of history.
 * <p>Future requirements could include:
 * <ul>
 * <li>Multiple command lines
 * <li>The ability to recall key presses (i.e. requests with no output) which
 * will likely be needed for macro recording or similar
 * <li>The ability to store the command history either on the server or in the
 * browser local storage.
 * </ul>
 * <p>The execute() command doesn't really live here, except as part of that
 * last future requirement, and because it doesn't really have anywhere else to
 * live.
 */

/**
 * The array of requests that wish to announce their presence
 */
var requests = [];

/**
 * How many requests do we store?
 */
var maxRequestLength = 100;

/**
 * To create an invocation, you need to do something like this (all the ctor
 * args are optional):
 * <pre>
 * var request = new Request({
 *     command: command,
 *     args: args,
 *     typed: typed
 * });
 * </pre>
 * @constructor
 */
function Request(options) {
    options = options || {};

    // Will be used in the keyboard case and the cli case
    this.command = options.command;

    // Will be used only in the cli case
    this.args = options.args;
    this.typed = options.typed;

    // Have we been initialized?
    this._begunOutput = false;

    this.start = new Date();
    this.end = null;
    this.completed = false;
    this.error = false;
};

oop.implement(Request.prototype, EventEmitter);

/**
 * Return the status of a parameter on the request object.
 */
Request.prototype.getParamStatus = function(param) {
    var args = this.args || {};
    
    // Check if there is already a value for this parameter.
    if (param.name in args) {
        // If there is no value set and then the value is VALID if it's not
        // required or INCOMPLETE if not set yet.
        if (args[param.name] == null) {
            if (param.defaultValue === null) {
                return Status.VALID;
            } else {
                return Status.INCOMPLETE;   
            } 
        }
        
        // Check if the parameter value is valid.
        var reply,
            // The passed in value when parsing a type is a string.
            argsValue = args[param.name].toString();
        
        // Type.parse can throw errors. 
        try {
            reply = param.type.parse(argsValue);
        } catch (e) {
            return Status.INVALID;   
        }
        
        if (reply.status != Status.VALID) {
            return reply.status;   
        }
    } 
    // Check if the param is marked as required.
    else if (param.defaultValue === undefined) {
        // The parameter is not set on the args object but it's required,
        // which means, things are invalid.
        return Status.INCOMPLETE;
    }
    
    return Status.VALID;
}

/**
 * Return the status of a parameter name on the request object.
 */
Request.prototype.getParamNameStatus = function(paramName) {
    var params = this.command.params || [];
    
    for (var i = 0; i < params.length; i++) {
        if (params[i].name == paramName) {
            return this.getParamStatus(params[i]);   
        }
    }
    
    throw "Parameter '" + paramName + 
                "' not defined on command '" + this.command.name + "'"; 
}

/**
 * Checks if all required arguments are set on the request such that it can
 * get executed.
 */
Request.prototype.getStatus = function() {
    var args = this.args || {},
        params = this.command.params;

    // If there are not parameters, then it's valid.
    if (!params || params.length == 0) {
        return Status.VALID;
    }

    var status = [];
    for (var i = 0; i < params.length; i++) {
        status.push(this.getParamStatus(params[i]));        
    }

    return Status.combine(status);
}

/**
 * Lazy init to register with the history should only be done on output.
 * init() is expensive, and won't be used in the majority of cases
 */
Request.prototype._beginOutput = function() {
    this._begunOutput = true;
    this.outputs = [];

    requests.push(this);
    // This could probably be optimized with some maths, but 99.99% of the
    // time we will only be off by one, and I'm feeling lazy.
    while (requests.length > maxRequestLength) {
        requests.shiftObject();
    }

    exports._dispatchEvent('output', { requests: requests, request: this });
};

/**
 * Sugar for:
 * <pre>request.error = true; request.done(output);</pre>
 */
Request.prototype.doneWithError = function(content) {
    this.error = true;
    this.done(content);
};

/**
 * Declares that this function will not be automatically done when
 * the command exits
 */
Request.prototype.async = function() {
    this.isAsync = true;
    if (!this._begunOutput) {
        this._beginOutput();
    }
};

/**
 * Complete the currently executing command with successful output.
 * @param output Either DOM node, an SproutCore element or something that
 * can be used in the content of a DIV to create a DOM node.
 */
Request.prototype.output = function(content) {
    if (!this._begunOutput) {
        this._beginOutput();
    }

    if (typeof content !== 'string' && !(content instanceof Node)) {
        content = content.toString();
    }

    this.outputs.push(content);
    this.isDone = true;
    this._dispatchEvent('output', {});

    return this;
};

/**
 * All commands that do output must call this to indicate that the command
 * has finished execution.
 */
Request.prototype.done = function(content) {
    this.completed = true;
    this.end = new Date();
    this.duration = this.end.getTime() - this.start.getTime();

    if (content) {
        this.output(content);
    }
    
    // Ensure to finish the request only once.
    if (!this.isDone) {
        this.isDone = true;
        this._dispatchEvent('output', {});   
    }
};
exports.Request = Request;


});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Mozilla Skywriter.
 *
 * The Initial Developer of the Original Code is
 * Mozilla.
 * Portions created by the Initial Developer are Copyright (C) 2009
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Joe Walker (jwalker@mozilla.com)
 *   Patrick Walton (pwalton@mozilla.com)
 *   Julian Viereck (jviereck@mozilla.com)
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */
define('pilot/console', ['require', 'exports', 'module' ], function(require, exports, module) {
    
/**
 * This object represents a "safe console" object that forwards debugging
 * messages appropriately without creating a dependency on Firebug in Firefox.
 */

var noop = function() {};

// These are the functions that are available in Chrome 4/5, Safari 4
// and Firefox 3.6. Don't add to this list without checking browser support
var NAMES = [
    "assert", "count", "debug", "dir", "dirxml", "error", "group", "groupEnd",
    "info", "log", "profile", "profileEnd", "time", "timeEnd", "trace", "warn"
];

if (typeof(window) === 'undefined') {
    // We're in a web worker. Forward to the main thread so the messages
    // will show up.
    NAMES.forEach(function(name) {
        exports[name] = function() {
            var args = Array.prototype.slice.call(arguments);
            var msg = { op: 'log', method: name, args: args };
            postMessage(JSON.stringify(msg));
        };
    });
} else {
    // For each of the console functions, copy them if they exist, stub if not
    NAMES.forEach(function(name) {
        if (window.console && window.console[name]) {
            exports[name] = Function.prototype.bind.call(window.console[name], window.console);
        } else {
            exports[name] = noop;
        }
    });
}

});
define('pilot/stacktrace', ['require', 'exports', 'module' , 'pilot/useragent', 'pilot/console'], function(require, exports, module) {
    
var ua = require("pilot/useragent");
var console = require('pilot/console');

// Changed to suit the specific needs of running within Skywriter

// Domain Public by Eric Wendelin http://eriwen.com/ (2008)
//                  Luke Smith http://lucassmith.name/ (2008)
//                  Loic Dachary <loic@dachary.org> (2008)
//                  Johan Euphrosine <proppy@aminche.com> (2008)
//                  Øyvind Sean Kinsey http://kinsey.no/blog
//
// Information and discussions
// http://jspoker.pokersource.info/skin/test-printstacktrace.html
// http://eriwen.com/javascript/js-stack-trace/
// http://eriwen.com/javascript/stacktrace-update/
// http://pastie.org/253058
// http://browsershots.org/http://jspoker.pokersource.info/skin/test-printstacktrace.html
//

//
// guessFunctionNameFromLines comes from firebug
//
// Software License Agreement (BSD License)
//
// Copyright (c) 2007, Parakey Inc.
// All rights reserved.
//
// Redistribution and use of this software in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above
//   copyright notice, this list of conditions and the
//   following disclaimer.
//
// * Redistributions in binary form must reproduce the above
//   copyright notice, this list of conditions and the
//   following disclaimer in the documentation and/or other
//   materials provided with the distribution.
//
// * Neither the name of Parakey Inc. nor the names of its
//   contributors may be used to endorse or promote products
//   derived from this software without specific prior
//   written permission of Parakey Inc.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
// IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
// FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
// CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
// IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.



/**
 * Different browsers create stack traces in different ways.
 * <strike>Feature</strike> Browser detection baby ;).
 */
var mode = (function() {

    // We use SC's browser detection here to avoid the "break on error"
    // functionality provided by Firebug. Firebug tries to do the right
    // thing here and break, but it happens every time you load the page.
    // bug 554105
    if (ua.isGecko) {
        return 'firefox';
    } else if (ua.isOpera) {
        return 'opera';
    } else {
        return 'other';
    }

    // SC doesn't do any detection of Chrome at this time.

    // this is the original feature detection code that is used as a
    // fallback.
    try {
        (0)();
    } catch (e) {
        if (e.arguments) {
            return 'chrome';
        }
        if (e.stack) {
            return 'firefox';
        }
        if (window.opera && !('stacktrace' in e)) { //Opera 9-
            return 'opera';
        }
    }
    return 'other';
})();

/**
 *
 */
function stringifyArguments(args) {
    for (var i = 0; i < args.length; ++i) {
        var argument = args[i];
        if (typeof argument == 'object') {
            args[i] = '#object';
        } else if (typeof argument == 'function') {
            args[i] = '#function';
        } else if (typeof argument == 'string') {
            args[i] = '"' + argument + '"';
        }
    }
    return args.join(',');
}

/**
 * Extract a stack trace from the format emitted by each browser.
 */
var decoders = {
    chrome: function(e) {
        var stack = e.stack;
        if (!stack) {
            console.log(e);
            return [];
        }
        return stack.replace(/^.*?\n/, '').
                replace(/^.*?\n/, '').
                replace(/^.*?\n/, '').
                replace(/^[^\(]+?[\n$]/gm, '').
                replace(/^\s+at\s+/gm, '').
                replace(/^Object.<anonymous>\s*\(/gm, '{anonymous}()@').
                split('\n');
    },

    firefox: function(e) {
        var stack = e.stack;
        if (!stack) {
            console.log(e);
            return [];
        }
        // stack = stack.replace(/^.*?\n/, '');
        stack = stack.replace(/(?:\n@:0)?\s+$/m, '');
        stack = stack.replace(/^\(/gm, '{anonymous}(');
        return stack.split('\n');
    },

    // Opera 7.x and 8.x only!
    opera: function(e) {
        var lines = e.message.split('\n'), ANON = '{anonymous}',
            lineRE = /Line\s+(\d+).*?script\s+(http\S+)(?:.*?in\s+function\s+(\S+))?/i, i, j, len;

        for (i = 4, j = 0, len = lines.length; i < len; i += 2) {
            if (lineRE.test(lines[i])) {
                lines[j++] = (RegExp.$3 ? RegExp.$3 + '()@' + RegExp.$2 + RegExp.$1 : ANON + '()@' + RegExp.$2 + ':' + RegExp.$1) +
                ' -- ' +
                lines[i + 1].replace(/^\s+/, '');
            }
        }

        lines.splice(j, lines.length - j);
        return lines;
    },

    // Safari, Opera 9+, IE, and others
    other: function(curr) {
        var ANON = '{anonymous}', fnRE = /function\s*([\w\-$]+)?\s*\(/i, stack = [], j = 0, fn, args;

        var maxStackSize = 10;
        while (curr && stack.length < maxStackSize) {
            fn = fnRE.test(curr.toString()) ? RegExp.$1 || ANON : ANON;
            args = Array.prototype.slice.call(curr['arguments']);
            stack[j++] = fn + '(' + stringifyArguments(args) + ')';

            //Opera bug: if curr.caller does not exist, Opera returns curr (WTF)
            if (curr === curr.caller && window.opera) {
                //TODO: check for same arguments if possible
                break;
            }
            curr = curr.caller;
        }
        return stack;
    }
};

/**
 *
 */
function NameGuesser() {
}

NameGuesser.prototype = {

    sourceCache: {},

    ajax: function(url) {
        var req = this.createXMLHTTPObject();
        if (!req) {
            return;
        }
        req.open('GET', url, false);
        req.setRequestHeader('User-Agent', 'XMLHTTP/1.0');
        req.send('');
        return req.responseText;
    },

    createXMLHTTPObject: function() {
	    // Try XHR methods in order and store XHR factory
        var xmlhttp, XMLHttpFactories = [
            function() {
                return new XMLHttpRequest();
            }, function() {
                return new ActiveXObject('Msxml2.XMLHTTP');
            }, function() {
                return new ActiveXObject('Msxml3.XMLHTTP');
            }, function() {
                return new ActiveXObject('Microsoft.XMLHTTP');
            }
        ];
        for (var i = 0; i < XMLHttpFactories.length; i++) {
            try {
                xmlhttp = XMLHttpFactories[i]();
                // Use memoization to cache the factory
                this.createXMLHTTPObject = XMLHttpFactories[i];
                return xmlhttp;
            } catch (e) {}
        }
    },

    getSource: function(url) {
        if (!(url in this.sourceCache)) {
            this.sourceCache[url] = this.ajax(url).split('\n');
        }
        return this.sourceCache[url];
    },

    guessFunctions: function(stack) {
        for (var i = 0; i < stack.length; ++i) {
            var reStack = /{anonymous}\(.*\)@(\w+:\/\/([-\w\.]+)+(:\d+)?[^:]+):(\d+):?(\d+)?/;
            var frame = stack[i], m = reStack.exec(frame);
            if (m) {
                var file = m[1], lineno = m[4]; //m[7] is character position in Chrome
                if (file && lineno) {
                    var functionName = this.guessFunctionName(file, lineno);
                    stack[i] = frame.replace('{anonymous}', functionName);
                }
            }
        }
        return stack;
    },

    guessFunctionName: function(url, lineNo) {
        try {
            return this.guessFunctionNameFromLines(lineNo, this.getSource(url));
        } catch (e) {
            return 'getSource failed with url: ' + url + ', exception: ' + e.toString();
        }
    },

    guessFunctionNameFromLines: function(lineNo, source) {
        var reFunctionArgNames = /function ([^(]*)\(([^)]*)\)/;
        var reGuessFunction = /['"]?([0-9A-Za-z_]+)['"]?\s*[:=]\s*(function|eval|new Function)/;
        // Walk backwards from the first line in the function until we find the line which
        // matches the pattern above, which is the function definition
        var line = '', maxLines = 10;
        for (var i = 0; i < maxLines; ++i) {
            line = source[lineNo - i] + line;
            if (line !== undefined) {
                var m = reGuessFunction.exec(line);
                if (m) {
                    return m[1];
                }
                else {
                    m = reFunctionArgNames.exec(line);
                }
                if (m && m[1]) {
                    return m[1];
                }
            }
        }
        return '(?)';
    }
};

var guesser = new NameGuesser();

var frameIgnorePatterns = [
    /http:\/\/localhost:4020\/sproutcore.js:/
];

exports.ignoreFramesMatching = function(regex) {
    frameIgnorePatterns.push(regex);
};

/**
 * Create a stack trace from an exception
 * @param ex {Error} The error to create a stacktrace from (optional)
 * @param guess {Boolean} If we should try to resolve the names of anonymous functions
 */
exports.Trace = function Trace(ex, guess) {
    this._ex = ex;
    this._stack = decoders[mode](ex);

    if (guess) {
        this._stack = guesser.guessFunctions(this._stack);
    }
};

/**
 * Log to the console a number of lines (default all of them)
 * @param lines {number} Maximum number of lines to wrote to console
 */
exports.Trace.prototype.log = function(lines) {
    if (lines <= 0) {
        // You aren't going to have more lines in your stack trace than this
        // and it still fits in a 32bit integer
        lines = 999999999;
    }

    var printed = 0;
    for (var i = 0; i < this._stack.length && printed < lines; i++) {
        var frame = this._stack[i];
        var display = true;
        frameIgnorePatterns.forEach(function(regex) {
            if (regex.test(frame)) {
                display = false;
            }
        });
        if (display) {
            console.debug(frame);
            printed++;
        }
    }
};

});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('pilot/useragent', ['require', 'exports', 'module' ], function(require, exports, module) {

var os = (navigator.platform.match(/mac|win|linux/i) || ["other"])[0].toLowerCase();
var ua = navigator.userAgent;
var av = navigator.appVersion;

/** Is the user using a browser that identifies itself as Windows */
exports.isWin = (os == "win");

/** Is the user using a browser that identifies itself as Mac OS */
exports.isMac = (os == "mac");

/** Is the user using a browser that identifies itself as Linux */
exports.isLinux = (os == "linux");

exports.isIE = ! + "\v1";

/** Is this Firefox or related? */
exports.isGecko = exports.isMozilla = window.controllers && window.navigator.product === "Gecko";

/** oldGecko == rev < 2.0 **/
exports.isOldGecko = exports.isGecko && /rv\:1/.test(navigator.userAgent);

/** Is this Opera */
exports.isOpera = window.opera && Object.prototype.toString.call(window.opera) == "[object Opera]";

/** Is the user using a browser that identifies itself as WebKit */
exports.isWebKit = parseFloat(ua.split("WebKit/")[1]) || undefined;

exports.isAIR = ua.indexOf("AdobeAIR") >= 0;

exports.isIPad = ua.indexOf("iPad") >= 0;

/**
 * I hate doing this, but we need some way to determine if the user is on a Mac
 * The reason is that users have different expectations of their key combinations.
 *
 * Take copy as an example, Mac people expect to use CMD or APPLE + C
 * Windows folks expect to use CTRL + C
 */
exports.OS = {
    LINUX: 'LINUX',
    MAC: 'MAC',
    WINDOWS: 'WINDOWS'
};

/**
 * Return an exports.OS constant
 */
exports.getOS = function() {
    if (exports.isMac) {
        return exports.OS['MAC'];
    } else if (exports.isLinux) {
        return exports.OS['LINUX'];
    } else {
        return exports.OS['WINDOWS'];
    }
};

});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('pilot/oop', ['require', 'exports', 'module' ], function(require, exports, module) {

exports.inherits = (function() {
    var tempCtor = function() {};
    return function(ctor, superCtor) {
        tempCtor.prototype = superCtor.prototype;
        ctor.super_ = superCtor.prototype;
        ctor.prototype = new tempCtor();
        ctor.prototype.constructor = ctor;
    }
}());

exports.mixin = function(obj, mixin) {
    for (var key in mixin) {
        obj[key] = mixin[key];
    }
};

exports.implement = function(proto, mixin) {
    exports.mixin(proto, mixin);
};

});
/*! @license
==========================================================================
SproutCore -- JavaScript Application Framework
copyright 2006-2009, Sprout Systems Inc., Apple Inc. and contributors.

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

SproutCore and the SproutCore logo are trademarks of Sprout Systems, Inc.

For more information about SproutCore, visit http://www.sproutcore.com


==========================================================================
@license */

// Most of the following code is taken from SproutCore with a few changes.

define('pilot/keys', ['require', 'exports', 'module' , 'pilot/oop'], function(require, exports, module) {

var oop = require("pilot/oop");

/**
 * Helper functions and hashes for key handling.
 */
var Keys = (function() {
    var ret = {
        MODIFIER_KEYS: {
            16: 'Shift', 17: 'Ctrl', 18: 'Alt', 224: 'Meta'
        },

        KEY_MODS: {
            "ctrl": 1, "alt": 2, "option" : 2,
            "shift": 4, "meta": 8, "command": 8
        },

        FUNCTION_KEYS : {
            8  : "Backspace",
            9  : "Tab",
            13 : "Return",
            19 : "Pause",
            27 : "Esc",
            32 : "Space",
            33 : "PageUp",
            34 : "PageDown",
            35 : "End",
            36 : "Home",
            37 : "Left",
            38 : "Up",
            39 : "Right",
            40 : "Down",
            44 : "Print",
            45 : "Insert",
            46 : "Delete",
            112: "F1",
            113: "F2",
            114: "F3",
            115: "F4",
            116: "F5",
            117: "F6",
            118: "F7",
            119: "F8",
            120: "F9",
            121: "F10",
            122: "F11",
            123: "F12",
            144: "Numlock",
            145: "Scrolllock"
        },

        PRINTABLE_KEYS: {
           32: ' ',  48: '0',  49: '1',  50: '2',  51: '3',  52: '4', 53:  '5',
           54: '6',  55: '7',  56: '8',  57: '9',  59: ';',  61: '=', 65:  'a',
           66: 'b',  67: 'c',  68: 'd',  69: 'e',  70: 'f',  71: 'g', 72:  'h',
           73: 'i',  74: 'j',  75: 'k',  76: 'l',  77: 'm',  78: 'n', 79:  'o',
           80: 'p',  81: 'q',  82: 'r',  83: 's',  84: 't',  85: 'u', 86:  'v',
           87: 'w',  88: 'x',  89: 'y',  90: 'z', 107: '+', 109: '-', 110: '.',
          188: ',', 190: '.', 191: '/', 192: '`', 219: '[', 220: '\\',
          221: ']', 222: '\"'
        }
    };

    // A reverse map of FUNCTION_KEYS
    for (i in ret.FUNCTION_KEYS) {
        var name = ret.FUNCTION_KEYS[i].toUpperCase();
        ret[name] = parseInt(i, 10);
    }

    // Add the MODIFIER_KEYS, FUNCTION_KEYS and PRINTABLE_KEYS to the KEY
    // variables as well.
    oop.mixin(ret, ret.MODIFIER_KEYS);
    oop.mixin(ret, ret.PRINTABLE_KEYS);
    oop.mixin(ret, ret.FUNCTION_KEYS);

    return ret;
})();
oop.mixin(exports, Keys);

exports.keyCodeToString = function(keyCode) {
    return (Keys[keyCode] || String.fromCharCode(keyCode)).toLowerCase();
}

});
/* vim:ts=4:sts=4:sw=4:
 * ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *      Irakli Gozalishvili <rfobic@gmail.com> (http://jeditoolkit.com)
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('pilot/event_emitter', ['require', 'exports', 'module' ], function(require, exports, module) {

var EventEmitter = {};

EventEmitter._emit =
EventEmitter._dispatchEvent = function(eventName, e) {
    this._eventRegistry = this._eventRegistry || {};

    var listeners = this._eventRegistry[eventName];
    if (!listeners || !listeners.length) return;

    var e = e || {};
    e.type = eventName;

    for (var i=0; i<listeners.length; i++) {
        listeners[i](e);
    }
};

EventEmitter.on =
EventEmitter.addEventListener = function(eventName, callback) {
    this._eventRegistry = this._eventRegistry || {};

    var listeners = this._eventRegistry[eventName];
    if (!listeners) {
      var listeners = this._eventRegistry[eventName] = [];
    }
    if (listeners.indexOf(callback) == -1) {
        listeners.push(callback);
    }
};

EventEmitter.removeListener =
EventEmitter.removeEventListener = function(eventName, callback) {
    this._eventRegistry = this._eventRegistry || {};

    var listeners = this._eventRegistry[eventName];
    if (!listeners) {
      return;
    }
    var index = listeners.indexOf(callback);
    if (index !== -1) {
        listeners.splice(index, 1);
    }
};

EventEmitter.removeAllListeners = function(eventName) {
    if (this._eventRegistry) this._eventRegistry[eventName] = [];
}

exports.EventEmitter = EventEmitter;

});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Skywriter.
 *
 * The Initial Developer of the Original Code is
 * Mozilla.
 * Portions created by the Initial Developer are Copyright (C) 2009
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Joe Walker (jwalker@mozilla.com)
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('pilot/typecheck', ['require', 'exports', 'module' ], function(require, exports, module) {

var objectToString = Object.prototype.toString;

/**
 * Return true if it is a String
 */
exports.isString = function(it) {
    return it && objectToString.call(it) === "[object String]";
};

/**
 * Returns true if it is a Boolean.
 */
exports.isBoolean = function(it) {
    return it && objectToString.call(it) === "[object Boolean]";
};

/**
 * Returns true if it is a Number.
 */
exports.isNumber = function(it) {
    return it && objectToString.call(it) === "[object Number]" && isFinite(it);
};

/**
 * Hack copied from dojo.
 */
exports.isObject = function(it) {
    return it !== undefined &&
        (it === null || typeof it == "object" ||
        Array.isArray(it) || exports.isFunction(it));
};

/**
 * Is the passed object a function?
 * From dojo.isFunction()
 */
exports.isFunction = function(it) {
    return it && objectToString.call(it) === "[object Function]";
};

});/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Mozilla Skywriter.
 *
 * The Initial Developer of the Original Code is
 * Mozilla.
 * Portions created by the Initial Developer are Copyright (C) 2009
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Julian Viereck (jviereck@mozilla.com)
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('pilot/catalog', ['require', 'exports', 'module' ], function(require, exports, module) {


var extensionSpecs = {};

exports.addExtensionSpec = function(extensionSpec) {
    extensionSpecs[extensionSpec.name] = extensionSpec;
};

exports.removeExtensionSpec = function(extensionSpec) {
    if (typeof extensionSpec === "string") {
        delete extensionSpecs[extensionSpec];
    }
    else {
        delete extensionSpecs[extensionSpec.name];
    }
};

exports.getExtensionSpec = function(name) {
    return extensionSpecs[name];
};

exports.getExtensionSpecs = function() {
    return Object.keys(extensionSpecs);
};


});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('pilot/lang', ['require', 'exports', 'module' ], function(require, exports, module) {

exports.stringReverse = function(string) {
    return string.split("").reverse().join("");
};

exports.stringRepeat = function (string, count) {
     return new Array(count + 1).join(string);
};

var trimBeginRegexp = /^\s\s*/;
var trimEndRegexp = /\s\s*$/;

exports.stringTrimLeft = function (string) {
    return string.replace(trimBeginRegexp, '')
};

exports.stringTrimRight = function (string) {
    return string.replace(trimEndRegexp, '');
};

exports.copyObject = function(obj) {
    var copy = {};
    for (var key in obj) {
        copy[key] = obj[key];
    }
    return copy;
};

exports.copyArray = function(array){
    var copy = [];
    for (i=0, l=array.length; i<l; i++) {
        if (array[i] && typeof array[i] == "object")
            copy[i] = this.copyObject( array[i] );
        else 
            copy[i] = array[i]
    }
    return copy;
};

exports.deepCopy = function (obj) {
    if (typeof obj != "object") {
        return obj;
    }
    
    var copy = obj.constructor();
    for (var key in obj) {
        if (typeof obj[key] == "object") {
            copy[key] = this.deepCopy(obj[key]);
        } else {
            copy[key] = obj[key];
        }
    }
    return copy;
}

exports.arrayToMap = function(arr) {
    var map = {};
    for (var i=0; i<arr.length; i++) {
        map[arr[i]] = 1;
    }
    return map;

};

/**
 * splice out of 'array' anything that === 'value'
 */
exports.arrayRemove = function(array, value) {
  for (var i = 0; i <= array.length; i++) {
    if (value === array[i]) {
      array.splice(i, 1);
    }
  }
};

exports.escapeRegExp = function(str) {
    return str.replace(/([.*+?^${}()|[\]\/\\])/g, '\\$1');
};

exports.deferredCall = function(fcn) {

    var timer = null;
    var callback = function() {
        timer = null;
        fcn();
    };

    var deferred = function(timeout) {
        if (!timer) {
            timer = setTimeout(callback, timeout || 0);
        }
        return deferred;
    }

    deferred.schedule = deferred;

    deferred.call = function() {
        this.cancel();
        fcn();
        return deferred;
    };

    deferred.cancel = function() {
        clearTimeout(timer);
        timer = null;
        return deferred;
    };

    return deferred;
};

});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Mozilla Skywriter.
 *
 * The Initial Developer of the Original Code is
 * Mozilla.
 * Portions created by the Initial Developer are Copyright (C) 2009
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Joe Walker (jwalker@mozilla.com)
 *      Kevin Dangoor (kdangoor@mozilla.com)
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('pilot/types/settings', ['require', 'exports', 'module' , 'pilot/types/basic', 'pilot/types', 'pilot/settings'], function(require, exports, module) {

var SelectionType = require('pilot/types/basic').SelectionType;
var DeferredType = require('pilot/types/basic').DeferredType;
var types = require('pilot/types');
var settings = require('pilot/settings').settings;


/**
 * EVIL: This relies on us using settingValue in the same event as setting
 * The alternative is to have some central place where we store the current
 * command line, but this might be a lesser evil for now.
 */
var lastSetting;

/**
 * Select from the available settings
 */
var setting = new SelectionType({
    name: 'setting',
    data: function() {
        return env.settings.getSettingNames();
    },
    stringify: function(setting) {
        lastSetting = setting;
        return setting.name;
    },
    fromString: function(str) {
        lastSetting = settings.getSetting(str);
        return lastSetting;
    },
    noMatch: function() {
        lastSetting = null;
    }
});

/**
 * Something of a hack to allow the set command to give a clearer definition
 * of the type to the command line.
 */
var settingValue = new DeferredType({
    name: 'settingValue',
    defer: function() {
        if (lastSetting) {
            return lastSetting.type;
        }
        else {
            return types.getType('text');
        }
    },
    /**
     * Promote the current value in any list of predictions, and add it if
     * there are none.
     */
    getDefault: function() {
        var conversion = this.parse('');
        if (lastSetting) {
            var current = lastSetting.get();
            if (conversion.predictions.length === 0) {
                conversion.predictions.push(current);
            }
            else {
                // Remove current from predictions
                var removed = false;
                while (true) {
                    var index = conversion.predictions.indexOf(current);
                    if (index === -1) {
                        break;
                    }
                    conversion.predictions.splice(index, 1);
                    removed = true;
                }
                // If the current value wasn't something we would predict, leave it
                if (removed) {
                    conversion.predictions.push(current);
                }
            }
        }
        return conversion;
    }
});

var env;

/**
 * Registration and de-registration.
 */
exports.startup = function(data, reason) {
    // TODO: this is probably all kinds of evil, but we need something working
    env = data.env;
    types.registerType(setting);
    types.registerType(settingValue);
};

exports.shutdown = function(data, reason) {
    types.unregisterType(setting);
    types.unregisterType(settingValue);
};


});
/* vim:ts=4:sts=4:sw=4:
 * ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Mozilla Skywriter.
 *
 * The Initial Developer of the Original Code is
 * Mozilla.
 * Portions created by the Initial Developer are Copyright (C) 2009
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Joe Walker (jwalker@mozilla.com)
 *   Julian Viereck (jviereck@mozilla.com)
 *   Kevin Dangoor (kdangoor@mozilla.com)
 *   Irakli Gozalishvili <rfobic@gmail.com> (http://jeditoolkit.com)
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('pilot/settings', ['require', 'exports', 'module' , 'pilot/console', 'pilot/oop', 'pilot/types', 'pilot/event_emitter', 'pilot/catalog'], function(require, exports, module) {

/**
 * This plug-in manages settings.
 */

var console = require('pilot/console');
var oop = require('pilot/oop');
var types = require('pilot/types');
var EventEmitter = require('pilot/event_emitter').EventEmitter;
var catalog = require('pilot/catalog');

var settingExtensionSpec = {
    name: 'setting',
    description: 'A setting is something that the application offers as a ' +
            'way to customize how it works',
    register: 'env.settings.addSetting',
    indexOn: 'name'
};

exports.startup = function(data, reason) {
    catalog.addExtensionSpec(settingExtensionSpec);
};

exports.shutdown = function(data, reason) {
    catalog.removeExtensionSpec(settingExtensionSpec);
};


/**
 * Create a new setting.
 * @param settingSpec An object literal that looks like this:
 * {
 *   name: 'thing',
 *   description: 'Thing is an example setting',
 *   type: 'string',
 *   defaultValue: 'something'
 * }
 */
function Setting(settingSpec, settings) {
    this._settings = settings;

    Object.keys(settingSpec).forEach(function(key) {
        this[key] = settingSpec[key];
    }, this);

    this.type = types.getType(this.type);
    if (this.type == null) {
        throw new Error('In ' + this.name +
            ': can\'t find type for: ' + JSON.stringify(settingSpec.type));
    }

    if (!this.name) {
        throw new Error('Setting.name == undefined. Ignoring.', this);
    }

    if (!this.defaultValue === undefined) {
        throw new Error('Setting.defaultValue == undefined', this);
    }

    if (this.onChange) {
        this.on('change', this.onChange.bind(this))
    }

    this.set(this.defaultValue);
}
Setting.prototype = {
    get: function() {
        return this.value;
    },

    set: function(value) {
        if (this.value === value) {
            return;
        }

        this.value = value;
        if (this._settings.persister) {
            this._settings.persister.persistValue(this._settings, this.name, value);
        }

        this._dispatchEvent('change', { setting: this, value: value });
    },

    /**
     * Reset the value of the <code>key</code> setting to it's default
     */
    resetValue: function() {
        this.set(this.defaultValue);
    }
};
oop.implement(Setting.prototype, EventEmitter);


/**
 * A base class for all the various methods of storing settings.
 * <p>Usage:
 * <pre>
 * // Create manually, or require 'settings' from the container.
 * // This is the manual version:
 * var settings = plugins.catalog.getObject('settings');
 * // Add a new setting
 * settings.addSetting({ name:'foo', ... });
 * // Display the default value
 * alert(settings.get('foo'));
 * // Alter the value, which also publishes the change etc.
 * settings.set('foo', 'bar');
 * // Reset the value to the default
 * settings.resetValue('foo');
 * </pre>
 * @constructor
 */
function Settings(persister) {
    // Storage for deactivated values
    this._deactivated = {};

    // Storage for the active settings
    this._settings = {};
    // We often want sorted setting names. Cache
    this._settingNames = [];

    if (persister) {
        this.setPersister(persister);
    }
};

Settings.prototype = {
    /**
     * Function to add to the list of available settings.
     * <p>Example usage:
     * <pre>
     * var settings = plugins.catalog.getObject('settings');
     * settings.addSetting({
     *     name: 'tabsize', // For use in settings.get('X')
     *     type: 'number',  // To allow value checking.
     *     defaultValue: 4  // Default value for use when none is directly set
     * });
     * </pre>
     * @param {object} settingSpec Object containing name/type/defaultValue members.
     */
    addSetting: function(settingSpec) {
        var setting = new Setting(settingSpec, this);
        this._settings[setting.name] = setting;
        this._settingNames.push(setting.name);
        this._settingNames.sort();
    },

    addSettings: function addSettings(settings) {
        Object.keys(settings).forEach(function (name) {
            var setting = settings[name];
            if (!('name' in setting)) setting.name = name;
            this.addSetting(setting);
        }, this);
    },

    removeSetting: function(setting) {
        var name = (typeof setting === 'string' ? setting : setting.name);
        setting = this._settings[name];
        delete this._settings[name];
        util.arrayRemove(this._settingNames, name);
        settings.removeAllListeners('change');
    },

    removeSettings: function removeSettings(settings) {
        Object.keys(settings).forEach(function(name) {
            var setting = settings[name];
            if (!('name' in setting)) setting.name = name;
            this.removeSettings(setting);
        }, this);
    },

    getSettingNames: function() {
        return this._settingNames;
    },

    getSetting: function(name) {
        return this._settings[name];
    },

    /**
     * A Persister is able to store settings. It is an object that defines
     * two functions:
     * loadInitialValues(settings) and persistValue(settings, key, value).
     */
    setPersister: function(persister) {
        this._persister = persister;
        if (persister) {
            persister.loadInitialValues(this);
        }
    },

    resetAll: function() {
        this.getSettingNames().forEach(function(key) {
            this.resetValue(key);
        }, this);
    },

    /**
     * Retrieve a list of the known settings and their values
     */
    _list: function() {
        var reply = [];
        this.getSettingNames().forEach(function(setting) {
            reply.push({
                'key': setting,
                'value': this.getSetting(setting).get()
            });
        }, this);
        return reply;
    },

    /**
     * Prime the local cache with the defaults.
     */
    _loadDefaultValues: function() {
        this._loadFromObject(this._getDefaultValues());
    },

    /**
     * Utility to load settings from an object
     */
    _loadFromObject: function(data) {
        // We iterate over data rather than keys so we don't forget values
        // which don't have a setting yet.
        for (var key in data) {
            if (data.hasOwnProperty(key)) {
                var setting = this._settings[key];
                if (setting) {
                    var value = setting.type.parse(data[key]);
                    this.set(key, value);
                } else {
                    this.set(key, data[key]);
                }
            }
        }
    },

    /**
     * Utility to grab all the settings and export them into an object
     */
    _saveToObject: function() {
        return this.getSettingNames().map(function(key) {
            return this._settings[key].type.stringify(this.get(key));
        }.bind(this));
    },

    /**
     * The default initial settings
     */
    _getDefaultValues: function() {
        return this.getSettingNames().map(function(key) {
            return this._settings[key].spec.defaultValue;
        }.bind(this));
    }
};
exports.settings = new Settings();

/**
 * Save the settings in a cookie
 * This code has not been tested since reboot
 * @constructor
 */
function CookiePersister() {
};

CookiePersister.prototype = {
    loadInitialValues: function(settings) {
        settings._loadDefaultValues();
        var data = cookie.get('settings');
        settings._loadFromObject(JSON.parse(data));
    },

    persistValue: function(settings, key, value) {
        try {
            var stringData = JSON.stringify(settings._saveToObject());
            cookie.set('settings', stringData);
        } catch (ex) {
            console.error('Unable to JSONify the settings! ' + ex);
            return;
        }
    }
};

exports.CookiePersister = CookiePersister;

});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Skywriter.
 *
 * The Initial Developer of the Original Code is
 * Mozilla.
 * Portions created by the Initial Developer are Copyright (C) 2009
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Skywriter Team (skywriter@mozilla.com)
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('pilot/commands/settings', ['require', 'exports', 'module' , 'pilot/canon'], function(require, exports, module) {


var setCommandSpec = {
    name: 'set',
    params: [
        {
            name: 'setting',
            type: 'setting',
            description: 'The name of the setting to display or alter',
            defaultValue: null
        },
        {
            name: 'value',
            type: 'settingValue',
            description: 'The new value for the chosen setting',
            defaultValue: null
        }
    ],
    description: 'define and show settings',
    exec: function(env, args, request) {
        var html;
        if (!args.setting) {
            // 'set' by itself lists all the settings
            var names = env.settings.getSettingNames();
            html = '';
            // first sort the settingsList based on the name
            names.sort(function(name1, name2) {
                return name1.localeCompare(name2);
            });

            names.forEach(function(name) {
                var setting = env.settings.getSetting(name);
                var url = 'https://wiki.mozilla.org/Labs/Skywriter/Settings#' +
                        setting.name;
                html += '<a class="setting" href="' + url +
                        '" title="View external documentation on setting: ' +
                        setting.name +
                        '" target="_blank">' +
                        setting.name +
                        '</a> = ' +
                        setting.value +
                        '<br/>';
            });
        } else {
            // set with only a setting, shows the value for that setting
            if (args.value === undefined) {
                html = '<strong>' + setting.name + '</strong> = ' +
                        setting.get();
            } else {
                // Actually change the setting
                args.setting.set(args.value);
                html = 'Setting: <strong>' + args.setting.name + '</strong> = ' +
                        args.setting.get();
            }
        }
        request.done(html);
    }
};

var unsetCommandSpec = {
    name: 'unset',
    params: [
        {
            name: 'setting',
            type: 'setting',
            description: 'The name of the setting to return to defaults'
        }
    ],
    description: 'unset a setting entirely',
    exec: function(env, args, request) {
        var setting = env.settings.get(args.setting);
        if (!setting) {
            request.doneWithError('No setting with the name <strong>' +
                args.setting + '</strong>.');
            return;
        }

        setting.reset();
        request.done('Reset ' + setting.name + ' to default: ' +
                env.settings.get(args.setting));
    }
};

var canon = require('pilot/canon');

exports.startup = function(data, reason) {
    canon.addCommand(setCommandSpec);
    canon.addCommand(unsetCommandSpec);
};

exports.shutdown = function(data, reason) {
    canon.removeCommand(setCommandSpec);
    canon.removeCommand(unsetCommandSpec);
};


});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Skywriter.
 *
 * The Initial Developer of the Original Code is
 * Mozilla.
 * Portions created by the Initial Developer are Copyright (C) 2009
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Skywriter Team (skywriter@mozilla.com)
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('pilot/commands/basic', ['require', 'exports', 'module' , 'pilot/typecheck', 'pilot/canon'], function(require, exports, module) {


var checks = require("pilot/typecheck");
var canon = require('pilot/canon');

/**
 * 
 */
var helpMessages = {
    plainPrefix:
        '<h2>Welcome to Skywriter - Code in the Cloud</h2><ul>' +
        '<li><a href="http://labs.mozilla.com/projects/skywriter" target="_blank">Home Page</a></li>' +
        '<li><a href="https://wiki.mozilla.org/Labs/Skywriter" target="_blank">Wiki</a></li>' +
        '<li><a href="https://wiki.mozilla.org/Labs/Skywriter/UserGuide" target="_blank">User Guide</a></li>' +
        '<li><a href="https://wiki.mozilla.org/Labs/Skywriter/Tips" target="_blank">Tips and Tricks</a></li>' +
        '<li><a href="https://wiki.mozilla.org/Labs/Skywriter/FAQ" target="_blank">FAQ</a></li>' +
        '<li><a href="https://wiki.mozilla.org/Labs/Skywriter/DeveloperGuide" target="_blank">Developers Guide</a></li>' +
        '</ul>',
    plainSuffix:
        'For more information, see the <a href="https://wiki.mozilla.org/Labs/Skywriter">Skywriter Wiki</a>.'
};

/**
 * 'help' command
 */
var helpCommandSpec = {
    name: 'help',
    params: [
        {
            name: 'search',
            type: 'text',
            description: 'Search string to narrow the output.',
            defaultValue: null
        }
    ],
    description: 'Get help on the available commands.',
    exec: function(env, args, request) {
        var output = [];

        var command = canon.getCommand(args.search);
        if (command && command.exec) {
            // caught a real command
            output.push(command.description ?
                    command.description :
                    'No description for ' + args.search);
        } else {
            var showHidden = false;

            if (!args.search && helpMessages.plainPrefix) {
                output.push(helpMessages.plainPrefix);
            }

            if (command) {
                // We must be looking at sub-commands
                output.push('<h2>Sub-Commands of ' + command.name + '</h2>');
                output.push('<p>' + command.description + '</p>');
            }
            else if (args.search) {
                if (args.search == 'hidden') { // sneaky, sneaky.
                    args.search = '';
                    showHidden = true;
                }
                output.push('<h2>Commands starting with \'' + args.search + '\':</h2>');
            }
            else {
                output.push('<h2>Available Commands:</h2>');
            }

            var commandNames = canon.getCommandNames();
            commandNames.sort();

            output.push('<table>');
            for (var i = 0; i < commandNames.length; i++) {
                command = canon.getCommand(commandNames[i]);
                if (!showHidden && command.hidden) {
                    continue;
                }
                if (command.description === undefined) {
                    // Ignore editor actions
                    continue;
                }
                if (args.search && command.name.indexOf(args.search) !== 0) {
                    // Filtered out by the user
                    continue;
                }
                if (!args.search && command.name.indexOf(' ') != -1) {
                    // sub command
                    continue;
                }
                if (command && command.name == args.search) {
                    // sub command, and we've already given that help
                    continue;
                }

                // todo add back a column with parameter information, perhaps?

                output.push('<tr>');
                output.push('<th class="right">' + command.name + '</th>');
                output.push('<td>' + command.description + '</td>');
                output.push('</tr>');
            }
            output.push('</table>');

            if (!args.search && helpMessages.plainSuffix) {
                output.push(helpMessages.plainSuffix);
            }
        }

        request.done(output.join(''));
    }
};

/**
 * 'eval' command
 */
var evalCommandSpec = {
    name: 'eval',
    params: [
        {
            name: 'javascript',
            type: 'text',
            description: 'The JavaScript to evaluate'
        }
    ],
    description: 'evals given js code and show the result',
    hidden: true,
    exec: function(env, args, request) {
        var result;
        var javascript = args.javascript;
        try {
            result = eval(javascript);
        } catch (e) {
            result = '<b>Error: ' + e.message + '</b>';
        }

        var msg = '';
        var type = '';
        var x;

        if (checks.isFunction(result)) {
            // converts the function to a well formated string
            msg = (result + '').replace(/\n/g, '<br>').replace(/ /g, '&#160');
            type = 'function';
        } else if (checks.isObject(result)) {
            if (Array.isArray(result)) {
                type = 'array';
            } else {
                type = 'object';
            }

            var items = [];
            var value;

            for (x in result) {
                if (result.hasOwnProperty(x)) {
                    if (checks.isFunction(result[x])) {
                        value = '[function]';
                    } else if (checks.isObject(result[x])) {
                        value = '[object]';
                    } else {
                        value = result[x];
                    }

                    items.push({name: x, value: value});
                }
            }

            items.sort(function(a,b) {
                return (a.name.toLowerCase() < b.name.toLowerCase()) ? -1 : 1;
            });

            for (x = 0; x < items.length; x++) {
                msg += '<b>' + items[x].name + '</b>: ' + items[x].value + '<br>';
            }

        } else {
            msg = result;
            type = typeof result;
        }

        request.done('Result for eval <b>\'' + javascript + '\'</b>' +
                ' (type: '+ type+'): <br><br>'+ msg);
    }
};

/**
 * 'version' command
 */
var versionCommandSpec = {
    name: 'version',
    description: 'show the Skywriter version',
    hidden: true,
    exec: function(env, args, request) {
        var version = 'Skywriter ' + skywriter.versionNumber + ' (' +
                skywriter.versionCodename + ')';
        request.done(version);
    }
};

/**
 * 'skywriter' command
 */
var skywriterCommandSpec = {
    name: 'skywriter',
    hidden: true,
    exec: function(env, args, request) {
        var index = Math.floor(Math.random() * messages.length);
        request.done('Skywriter ' + messages[index]);
    }
};
var messages = [
    'really wants you to trick it out in some way.',
    'is your Web editor.',
    'would love to be like Emacs on the Web.',
    'is written on the Web platform, so you can tweak it.'
];


var canon = require('pilot/canon');

exports.startup = function(data, reason) {
    canon.addCommand(helpCommandSpec);
    canon.addCommand(evalCommandSpec);
    // canon.addCommand(versionCommandSpec);
    canon.addCommand(skywriterCommandSpec);
};

exports.shutdown = function(data, reason) {
    canon.removeCommand(helpCommandSpec);
    canon.removeCommand(evalCommandSpec);
    // canon.removeCommand(versionCommandSpec);
    canon.removeCommand(skywriterCommandSpec);
};


});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Mozilla Skywriter.
 *
 * The Initial Developer of the Original Code is
 * Mozilla.
 * Portions created by the Initial Developer are Copyright (C) 2009
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Joe Walker (jwalker@mozilla.com)
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('pilot/settings/canon', ['require', 'exports', 'module' ], function(require, exports, module) {


var historyLengthSetting = {
    name: "historyLength",
    description: "How many typed commands do we recall for reference?",
    type: "number",
    defaultValue: 50
};

exports.startup = function(data, reason) {
    data.env.settings.addSetting(historyLengthSetting);
};

exports.shutdown = function(data, reason) {
    data.env.settings.removeSetting(historyLengthSetting);
};


});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Skywriter.
 *
 * The Initial Developer of the Original Code is
 * Mozilla.
 * Portions created by the Initial Developer are Copyright (C) 2009
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Kevin Dangoor (kdangoor@mozilla.com)
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('pilot/plugin_manager', ['require', 'exports', 'module' , 'pilot/promise'], function(require, exports, module) {

var Promise = require("pilot/promise").Promise;

exports.REASONS = {
    APP_STARTUP: 1,
    APP_SHUTDOWN: 2,
    PLUGIN_ENABLE: 3,
    PLUGIN_DISABLE: 4,
    PLUGIN_INSTALL: 5,
    PLUGIN_UNINSTALL: 6,
    PLUGIN_UPGRADE: 7,
    PLUGIN_DOWNGRADE: 8
};

exports.Plugin = function(name) {
    this.name = name;
    this.status = this.INSTALLED;
};

exports.Plugin.prototype = {
    /**
     * constants for the state
     */
    NEW: 0,
    INSTALLED: 1,
    REGISTERED: 2,
    STARTED: 3,
    UNREGISTERED: 4,
    SHUTDOWN: 5,

    install: function(data, reason) {
        var pr = new Promise();
        if (this.status > this.NEW) {
            pr.resolve(this);
            return pr;
        }
        require([this.name], function(pluginModule) {
            if (pluginModule.install) {
                pluginModule.install(data, reason);
            }
            this.status = this.INSTALLED;
            pr.resolve(this);
        }.bind(this));
        return pr;
    },

    register: function(data, reason) {
        var pr = new Promise();
        if (this.status != this.INSTALLED) {
            pr.resolve(this);
            return pr;
        }
        require([this.name], function(pluginModule) {
            if (pluginModule.register) {
                pluginModule.register(data, reason);
            }
            this.status = this.REGISTERED;
            pr.resolve(this);
        }.bind(this));
        return pr;
    },

    startup: function(data, reason) {
        reason = reason || exports.REASONS.APP_STARTUP;
        var pr = new Promise();
        if (this.status != this.REGISTERED) {
            pr.resolve(this);
            return pr;
        }
        require([this.name], function(pluginModule) {
            if (pluginModule.startup) {
                pluginModule.startup(data, reason);
            }
            this.status = this.STARTED;
            pr.resolve(this);
        }.bind(this));
        return pr;
    },

    shutdown: function(data, reason) {
        if (this.status != this.STARTED) {
            return;
        }
        pluginModule = require(this.name);
        if (pluginModule.shutdown) {
            pluginModule.shutdown(data, reason);
        }
    }
};

exports.PluginCatalog = function() {
    this.plugins = {};
};

exports.PluginCatalog.prototype = {
    registerPlugins: function(pluginList, data, reason) {
        var registrationPromises = [];
        pluginList.forEach(function(pluginName) {
            var plugin = this.plugins[pluginName];
            if (plugin === undefined) {
                plugin = new exports.Plugin(pluginName);
                this.plugins[pluginName] = plugin;
                registrationPromises.push(plugin.register(data, reason));
            }
        }.bind(this));
        return Promise.group(registrationPromises);
    },

    startupPlugins: function(data, reason) {
        var startupPromises = [];
        for (var pluginName in this.plugins) {
            var plugin = this.plugins[pluginName];
            startupPromises.push(plugin.startup(data, reason));
        }
        return Promise.group(startupPromises);
    }
};

exports.catalog = new exports.PluginCatalog();

});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Mozilla Skywriter.
 *
 * The Initial Developer of the Original Code is
 * Mozilla.
 * Portions created by the Initial Developer are Copyright (C) 2009
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Joe Walker (jwalker@mozilla.com)
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('pilot/promise', ['require', 'exports', 'module' , 'pilot/console', 'pilot/stacktrace'], function(require, exports, module) {

var console = require("pilot/console");
var Trace = require('pilot/stacktrace').Trace;

/**
 * A promise can be in one of 2 states.
 * The ERROR and SUCCESS states are terminal, the PENDING state is the only
 * start state.
 */
var ERROR = -1;
var PENDING = 0;
var SUCCESS = 1;

/**
 * We give promises and ID so we can track which are outstanding
 */
var _nextId = 0;

/**
 * Debugging help if 2 things try to complete the same promise.
 * This can be slow (especially on chrome due to the stack trace unwinding) so
 * we should leave this turned off in normal use.
 */
var _traceCompletion = false;

/**
 * Outstanding promises. Handy list for debugging only.
 */
var _outstanding = [];

/**
 * Recently resolved promises. Also for debugging only.
 */
var _recent = [];

/**
 * Create an unfulfilled promise
 */
Promise = function () {
    this._status = PENDING;
    this._value = undefined;
    this._onSuccessHandlers = [];
    this._onErrorHandlers = [];

    // Debugging help
    this._id = _nextId++;
    //this._createTrace = new Trace(new Error());
    _outstanding[this._id] = this;
};

/**
 * Yeay for RTTI.
 */
Promise.prototype.isPromise = true;

/**
 * Have we either been resolve()ed or reject()ed?
 */
Promise.prototype.isComplete = function() {
    return this._status != PENDING;
};

/**
 * Have we resolve()ed?
 */
Promise.prototype.isResolved = function() {
    return this._status == SUCCESS;
};

/**
 * Have we reject()ed?
 */
Promise.prototype.isRejected = function() {
    return this._status == ERROR;
};

/**
 * Take the specified action of fulfillment of a promise, and (optionally)
 * a different action on promise rejection.
 */
Promise.prototype.then = function(onSuccess, onError) {
    if (typeof onSuccess === 'function') {
        if (this._status === SUCCESS) {
            onSuccess.call(null, this._value);
        } else if (this._status === PENDING) {
            this._onSuccessHandlers.push(onSuccess);
        }
    }

    if (typeof onError === 'function') {
        if (this._status === ERROR) {
            onError.call(null, this._value);
        } else if (this._status === PENDING) {
            this._onErrorHandlers.push(onError);
        }
    }

    return this;
};

/**
 * Like then() except that rather than returning <tt>this</tt> we return
 * a promise which
 */
Promise.prototype.chainPromise = function(onSuccess) {
    var chain = new Promise();
    chain._chainedFrom = this;
    this.then(function(data) {
        try {
            chain.resolve(onSuccess(data));
        } catch (ex) {
            chain.reject(ex);
        }
    }, function(ex) {
        chain.reject(ex);
    });
    return chain;
};

/**
 * Supply the fulfillment of a promise
 */
Promise.prototype.resolve = function(data) {
    return this._complete(this._onSuccessHandlers, SUCCESS, data, 'resolve');
};

/**
 * Renege on a promise
 */
Promise.prototype.reject = function(data) {
    return this._complete(this._onErrorHandlers, ERROR, data, 'reject');
};

/**
 * Internal method to be called on resolve() or reject().
 * @private
 */
Promise.prototype._complete = function(list, status, data, name) {
    // Complain if we've already been completed
    if (this._status != PENDING) {
        console.group('Promise already closed');
        console.error('Attempted ' + name + '() with ', data);
        console.error('Previous status = ', this._status,
                ', previous value = ', this._value);
        console.trace();

        if (this._completeTrace) {
            console.error('Trace of previous completion:');
            this._completeTrace.log(5);
        }
        console.groupEnd();
        return this;
    }

    if (_traceCompletion) {
        this._completeTrace = new Trace(new Error());
    }

    this._status = status;
    this._value = data;

    // Call all the handlers, and then delete them
    list.forEach(function(handler) {
        handler.call(null, this._value);
    }, this);
    this._onSuccessHandlers.length = 0;
    this._onErrorHandlers.length = 0;

    // Remove the given {promise} from the _outstanding list, and add it to the
    // _recent list, pruning more than 20 recent promises from that list.
    delete _outstanding[this._id];
    _recent.push(this);
    while (_recent.length > 20) {
        _recent.shift();
    }

    return this;
};

/**
 * Takes an array of promises and returns a promise that that is fulfilled once
 * all the promises in the array are fulfilled
 * @param group The array of promises
 * @return the promise that is fulfilled when all the array is fulfilled
 */
Promise.group = function(promiseList) {
    if (!(promiseList instanceof Array)) {
        promiseList = Array.prototype.slice.call(arguments);
    }

    // If the original array has nothing in it, return now to avoid waiting
    if (promiseList.length === 0) {
        return new Promise().resolve([]);
    }

    var groupPromise = new Promise();
    var results = [];
    var fulfilled = 0;

    var onSuccessFactory = function(index) {
        return function(data) {
            results[index] = data;
            fulfilled++;
            // If the group has already failed, silently drop extra results
            if (groupPromise._status !== ERROR) {
                if (fulfilled === promiseList.length) {
                    groupPromise.resolve(results);
                }
            }
        };
    };

    promiseList.forEach(function(promise, index) {
        var onSuccess = onSuccessFactory(index);
        var onError = groupPromise.reject.bind(groupPromise);
        promise.then(onSuccess, onError);
    });

    return groupPromise;
};

exports.Promise = Promise;
exports._outstanding = _outstanding;
exports._recent = _recent;

});
/* vim:ts=4:sts=4:sw=4:
 * ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *      Mihai Sucan <mihai AT sucan AT gmail ODT com>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('pilot/dom', ['require', 'exports', 'module' ], function(require, exports, module) {

var XHTML_NS = "http://www.w3.org/1999/xhtml";

exports.createElement = function(tag, ns) {
    return document.createElementNS ?
           document.createElementNS(ns || XHTML_NS, tag) :
           document.createElement(tag);
};

exports.setText = function(elem, text) {
    if (elem.innerText !== undefined) {
        elem.innerText = text;
    }
    if (elem.textContent !== undefined) {
        elem.textContent = text;
    }
};

if (!document.documentElement.classList) {
    exports.hasCssClass = function(el, name) {
        var classes = el.className.split(/\s+/g);
        return classes.indexOf(name) !== -1;
    };

    /**
    * Add a CSS class to the list of classes on the given node
    */
    exports.addCssClass = function(el, name) {
        if (!exports.hasCssClass(el, name)) {
            el.className += " " + name;
        }
    };

    /**
    * Remove a CSS class from the list of classes on the given node
    */
    exports.removeCssClass = function(el, name) {
        var classes = el.className.split(/\s+/g);
        while (true) {
            var index = classes.indexOf(name);
            if (index == -1) {
                break;
            }
            classes.splice(index, 1);
        }
        el.className = classes.join(" ");
    };

    exports.toggleCssClass = function(el, name) {
        var classes = el.className.split(/\s+/g), add = true;
        while (true) {
            var index = classes.indexOf(name);
            if (index == -1) {
                break;
            }
            add = false;
            classes.splice(index, 1);
        }
        if(add)
            classes.push(name);

        el.className = classes.join(" ");
        return add;
    };
} else {
    exports.hasCssClass = function(el, name) {
        return el.classList.contains(name);
    };

    exports.addCssClass = function(el, name) {
        el.classList.add(name);
    };

    exports.removeCssClass = function(el, name) {
        el.classList.remove(name);
    };

    exports.toggleCssClass = function(el, name) {
        return el.classList.toggle(name);
    };
}

/**
 * Add or remove a CSS class from the list of classes on the given node
 * depending on the value of <tt>include</tt>
 */
exports.setCssClass = function(node, className, include) {
    if (include) {
        exports.addCssClass(node, className);
    } else {
        exports.removeCssClass(node, className);
    }
};

exports.importCssString = function(cssText, doc){
    doc = doc || document;

    if (doc.createStyleSheet) {
        var sheet = doc.createStyleSheet();
        sheet.cssText = cssText;
    }
    else {
        var style = doc.createElementNS ?
                    doc.createElementNS(XHTML_NS, "style") :
                    doc.createElement("style");

        style.appendChild(doc.createTextNode(cssText));

        var head = doc.getElementsByTagName("head")[0] || doc.documentElement;
        head.appendChild(style);
    }
};

exports.getInnerWidth = function(element) {
    return (parseInt(exports.computedStyle(element, "paddingLeft"))
            + parseInt(exports.computedStyle(element, "paddingRight")) + element.clientWidth);
};

exports.getInnerHeight = function(element) {
    return (parseInt(exports.computedStyle(element, "paddingTop"))
            + parseInt(exports.computedStyle(element, "paddingBottom")) + element.clientHeight);
};

if (window.pageYOffset !== undefined) {
    exports.getPageScrollTop = function() {
        return window.pageYOffset;
    };

    exports.getPageScrollLeft = function() {
        return window.pageXOffset;
    };
}
else {
    exports.getPageScrollTop = function() {
        return document.body.scrollTop;
    };

    exports.getPageScrollLeft = function() {
        return document.body.scrollLeft;
    };
}

if (window.getComputedStyle)
    exports.computedStyle = function(element, style) {
        if (style)
            return (window.getComputedStyle(element, "") || {})[style] || "";
        return window.getComputedStyle(element, "") || {}
    };
else
    exports.computedStyle = function(element, style) {
        if (style)
            return element.currentStyle[style];
        return element.currentStyle
    };

exports.scrollbarWidth = function() {

    var inner = exports.createElement("p");
    inner.style.width = "100%";
    inner.style.height = "200px";

    var outer = exports.createElement("div");
    var style = outer.style;

    style.position = "absolute";
    style.left = "-10000px";
    style.overflow = "hidden";
    style.width = "200px";
    style.height = "150px";

    outer.appendChild(inner);

    var body = document.body || document.documentElement;
    body.appendChild(outer);

    var noScrollbar = inner.offsetWidth;

    style.overflow = "scroll";
    var withScrollbar = inner.offsetWidth;

    if (noScrollbar == withScrollbar) {
        withScrollbar = outer.clientWidth;
    }

    body.removeChild(outer);

    return noScrollbar-withScrollbar;
};

/**
 * Optimized set innerHTML. This is faster than plain innerHTML if the element
 * already contains a lot of child elements.
 *
 * See http://blog.stevenlevithan.com/archives/faster-than-innerhtml for details
 */
exports.setInnerHtml = function(el, innerHtml) {
    var element = el.cloneNode(false);//document.createElement("div");
    element.innerHTML = innerHtml;
    el.parentNode.replaceChild(element, el);
    return element;
};

exports.setInnerText = function(el, innerText) {
    if (document.body && "textContent" in document.body)
        el.textContent = innerText;
    else
        el.innerText = innerText;

};

exports.getInnerText = function(el) {
    if (document.body && "textContent" in document.body)
        return el.textContent;
    else
         return el.innerText || el.textContent || "";
};

exports.getParentWindow = function(document) {
    return document.defaultView || document.parentWindow;
};

exports.getSelectionStart = function(textarea) {
    // TODO IE
    var start;
    try {
        start = textarea.selectionStart || 0;
    } catch (e) {
        start = 0;
    }
    return start;
};

exports.setSelectionStart = function(textarea, start) {
    // TODO IE
    return textarea.selectionStart = start;
};

exports.getSelectionEnd = function(textarea) {
    // TODO IE
    var end;
    try {
        end = textarea.selectionEnd || 0;
    } catch (e) {
        end = 0;
    }
    return end;
};

exports.setSelectionEnd = function(textarea, end) {
    // TODO IE
    return textarea.selectionEnd = end;
};

});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('pilot/event', ['require', 'exports', 'module' , 'pilot/keys', 'pilot/useragent', 'pilot/dom'], function(require, exports, module) {

var keys = require("pilot/keys");
var useragent = require("pilot/useragent");
var dom = require("pilot/dom");

exports.addListener = function(elem, type, callback) {
    if (elem.addEventListener) {
        return elem.addEventListener(type, callback, false);
    }
    if (elem.attachEvent) {
        var wrapper = function() {
            callback(window.event);
        };
        callback._wrapper = wrapper;
        elem.attachEvent("on" + type, wrapper);
    }
};

exports.removeListener = function(elem, type, callback) {
    if (elem.removeEventListener) {
        return elem.removeEventListener(type, callback, false);
    }
    if (elem.detachEvent) {
        elem.detachEvent("on" + type, callback._wrapper || callback);
    }
};

/**
* Prevents propagation and clobbers the default action of the passed event
*/
exports.stopEvent = function(e) {
    exports.stopPropagation(e);
    exports.preventDefault(e);
    return false;
};

exports.stopPropagation = function(e) {
    if (e.stopPropagation)
        e.stopPropagation();
    else
        e.cancelBubble = true;
};

exports.preventDefault = function(e) {
    if (e.preventDefault)
        e.preventDefault();
    else
        e.returnValue = false;
};

exports.getDocumentX = function(e) {
    if (e.clientX) {        
        return e.clientX + dom.getPageScrollLeft();
    } else {
        return e.pageX;
    }
};

exports.getDocumentY = function(e) {
    if (e.clientY) {
        return e.clientY + dom.getPageScrollTop();
    } else {
        return e.pageY;
    }
};

/**
 * @return {Number} 0 for left button, 1 for middle button, 2 for right button
 */
exports.getButton = function(e) {
    if (e.type == "dblclick")
        return 0;
    else if (e.type == "contextmenu")
        return 2;
        
    // DOM Event
    if (e.preventDefault) {
        return e.button;
    }
    // old IE
    else {
        return {1:0, 2:2, 4:1}[e.button];
    }
};

if (document.documentElement.setCapture) {
    exports.capture = function(el, eventHandler, releaseCaptureHandler) {
        function onMouseMove(e) {
            eventHandler(e);
            return exports.stopPropagation(e);
        }

        function onReleaseCapture(e) {
            eventHandler && eventHandler(e);
            releaseCaptureHandler && releaseCaptureHandler();

            exports.removeListener(el, "mousemove", eventHandler);
            exports.removeListener(el, "mouseup", onReleaseCapture);
            exports.removeListener(el, "losecapture", onReleaseCapture);

            el.releaseCapture();
        }

        exports.addListener(el, "mousemove", eventHandler);
        exports.addListener(el, "mouseup", onReleaseCapture);
        exports.addListener(el, "losecapture", onReleaseCapture);
        el.setCapture();
    };
}
else {
    exports.capture = function(el, eventHandler, releaseCaptureHandler) {
        function onMouseMove(e) {
            eventHandler(e);
            e.stopPropagation();
        }

        function onMouseUp(e) {
            eventHandler && eventHandler(e);
            releaseCaptureHandler && releaseCaptureHandler();

            document.removeEventListener("mousemove", onMouseMove, true);
            document.removeEventListener("mouseup", onMouseUp, true);

            e.stopPropagation();
        }

        document.addEventListener("mousemove", onMouseMove, true);
        document.addEventListener("mouseup", onMouseUp, true);
    };
}

exports.addMouseWheelListener = function(el, callback) {
    var listener = function(e) {
        if (e.wheelDelta !== undefined) {
            if (e.wheelDeltaX !== undefined) {
                e.wheelX = -e.wheelDeltaX / 8;
                e.wheelY = -e.wheelDeltaY / 8;
            } else {
                e.wheelX = 0;
                e.wheelY = -e.wheelDelta / 8;
            }
        }
        else {
            if (e.axis && e.axis == e.HORIZONTAL_AXIS) {
                e.wheelX = (e.detail || 0) * 5;
                e.wheelY = 0;
            } else {
                e.wheelX = 0;
                e.wheelY = (e.detail || 0) * 5;
            }
        }
        callback(e);
    };
    exports.addListener(el, "DOMMouseScroll", listener);
    exports.addListener(el, "mousewheel", listener);
};

exports.addMultiMouseDownListener = function(el, button, count, timeout, callback) {
    var clicks = 0;
    var startX, startY;

    var listener = function(e) {
        clicks += 1;
        if (clicks == 1) {
            startX = e.clientX;
            startY = e.clientY;

            setTimeout(function() {
                clicks = 0;
            }, timeout || 600);
        }

        var isButton = exports.getButton(e) == button;
        if (!isButton || Math.abs(e.clientX - startX) > 5 || Math.abs(e.clientY - startY) > 5)
            clicks = 0;

        if (clicks == count) {
            clicks = 0;
            callback(e);
        }
        
        if (isButton)
            return exports.preventDefault(e);
    };

    exports.addListener(el, "mousedown", listener);
    useragent.isIE && exports.addListener(el, "dblclick", listener);
};

function normalizeCommandKeys(callback, e, keyCode) {
    var hashId = 0;
    if (useragent.isOpera && useragent.isMac) {
        hashId = 0 | (e.metaKey ? 1 : 0) | (e.altKey ? 2 : 0)
            | (e.shiftKey ? 4 : 0) | (e.ctrlKey ? 8 : 0);
    } else {
        hashId = 0 | (e.ctrlKey ? 1 : 0) | (e.altKey ? 2 : 0)
            | (e.shiftKey ? 4 : 0) | (e.metaKey ? 8 : 0);
    }

    if (keyCode in keys.MODIFIER_KEYS) {
        switch (keys.MODIFIER_KEYS[keyCode]) {
            case "Alt":
                hashId = 2;
                break;
            case "Shift":
                hashId = 4;
                break
            case "Ctrl":
                hashId = 1;
                break;
            default:
                hashId = 8;
                break;
        }
        keyCode = 0;
    }

    if (hashId & 8 && (keyCode == 91 || keyCode == 93)) {
        keyCode = 0;
    }

    // If there is no hashID and the keyCode is not a function key, then
    // we don't call the callback as we don't handle a command key here
    // (it's a normal key/character input).
    if (hashId == 0 && !(keyCode in keys.FUNCTION_KEYS)) {
        return false;
    }

    return callback(e, hashId, keyCode);
}

exports.addCommandKeyListener = function(el, callback) {
    var addListener = exports.addListener;
    if (useragent.isOldGecko) {
        // Old versions of Gecko aka. Firefox < 4.0 didn't repeat the keydown
        // event if the user pressed the key for a longer time. Instead, the
        // keydown event was fired once and later on only the keypress event.
        // To emulate the 'right' keydown behavior, the keyCode of the initial
        // keyDown event is stored and in the following keypress events the
        // stores keyCode is used to emulate a keyDown event.
        var lastKeyDownKeyCode = null;
        addListener(el, "keydown", function(e) {
            lastKeyDownKeyCode = e.keyCode;
        });
        addListener(el, "keypress", function(e) {
            return normalizeCommandKeys(callback, e, lastKeyDownKeyCode);
        });
    } else {
        var lastDown = null;

        addListener(el, "keydown", function(e) {
            lastDown = e.keyIdentifier || e.keyCode;
            return normalizeCommandKeys(callback, e, e.keyCode);
        });

        // repeated keys are fired as keypress and not keydown events
        if (useragent.isMac && useragent.isOpera) {
            addListener(el, "keypress", function(e) {
                var keyId = e.keyIdentifier || e.keyCode;
                if (lastDown !== keyId) {
                    return normalizeCommandKeys(callback, e, e.keyCode);
                } else {
                    lastDown = null;
                }
            });
        }
    }
};

});
/* vim:ts=4:sts=4:sw=4:
 * ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *      Irakli Gozalishvili <rfobic@gmail.com> (http://jeditoolkit.com)
 *      Julian Viereck <julian.viereck@gmail.com>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('ace/editor', ['require', 'exports', 'module' , 'pilot/fixoldbrowsers', 'pilot/oop', 'pilot/event', 'pilot/lang', 'pilot/useragent', 'ace/keyboard/textinput', 'ace/mouse_handler', 'ace/keyboard/keybinding', 'ace/edit_session', 'ace/search', 'ace/range', 'pilot/event_emitter'], function(require, exports, module) {

require("pilot/fixoldbrowsers");

var oop = require("pilot/oop");
var event = require("pilot/event");
var lang = require("pilot/lang");
var useragent = require("pilot/useragent");
var TextInput = require("ace/keyboard/textinput").TextInput;
var MouseHandler = require("ace/mouse_handler").MouseHandler;
//var TouchHandler = require("ace/touch_handler").TouchHandler;
var KeyBinding = require("ace/keyboard/keybinding").KeyBinding;
var EditSession = require("ace/edit_session").EditSession;
var Search = require("ace/search").Search;
var Range = require("ace/range").Range;
var EventEmitter = require("pilot/event_emitter").EventEmitter;

var Editor =function(renderer, session) {
    var container = renderer.getContainerElement();
    this.container = container;
    this.renderer = renderer;

    this.textInput  = new TextInput(renderer.getTextAreaContainer(), this);
    this.keyBinding = new KeyBinding(this);

    // TODO detect touch event support
    if (useragent.isIPad) {
        //this.$mouseHandler = new TouchHandler(this);
    } else {
        this.$mouseHandler = new MouseHandler(this);
    }

    this.$blockScrolling = 0;
    this.$search = new Search().set({
        wrap: true
    });

    this.setSession(session || new EditSession(""));
};

(function(){

    oop.implement(this, EventEmitter);

    this.$forwardEvents = {
        gutterclick: 1,
        gutterdblclick: 1
    };

    this.$originalAddEventListener = this.addEventListener;
    this.$originalRemoveEventListener = this.removeEventListener;

    this.addEventListener = function(eventName, callback) {
        if (this.$forwardEvents[eventName]) {
            return this.renderer.addEventListener(eventName, callback);
        } else {
            return this.$originalAddEventListener(eventName, callback);
        }
    };

    this.removeEventListener = function(eventName, callback) {
        if (this.$forwardEvents[eventName]) {
            return this.renderer.removeEventListener(eventName, callback);
        } else {
            return this.$originalRemoveEventListener(eventName, callback);
        }
    };

    this.setKeyboardHandler = function(keyboardHandler) {
        this.keyBinding.setKeyboardHandler(keyboardHandler);
    };

    this.getKeyboardHandler = function() {
        return this.keyBinding.getKeyboardHandler();
    };

    this.setSession = function(session) {
        if (this.session == session) return;

        if (this.session) {
            var oldSession = this.session;
            this.session.removeEventListener("change", this.$onDocumentChange);
            this.session.removeEventListener("changeMode", this.$onChangeMode);
            this.session.removeEventListener("tokenizerUpdate", this.$onTokenizerUpdate);
            this.session.removeEventListener("changeTabSize", this.$onChangeTabSize);
            this.session.removeEventListener("changeWrapLimit", this.$onChangeWrapLimit);
            this.session.removeEventListener("changeWrapMode", this.$onChangeWrapMode);
            this.session.removeEventListener("onChangeFold", this.$onChangeFold);
            this.session.removeEventListener("changeFrontMarker", this.$onChangeFrontMarker);
            this.session.removeEventListener("changeBackMarker", this.$onChangeBackMarker);
            this.session.removeEventListener("changeBreakpoint", this.$onChangeBreakpoint);
            this.session.removeEventListener("changeAnnotation", this.$onChangeAnnotation);
            this.session.removeEventListener("changeOverwrite", this.$onCursorChange);

            var selection = this.session.getSelection();
            selection.removeEventListener("changeCursor", this.$onCursorChange);
            selection.removeEventListener("changeSelection", this.$onSelectionChange);

            this.session.setScrollTopRow(this.renderer.getScrollTopRow());
        }

        this.session = session;

        this.$onDocumentChange = this.onDocumentChange.bind(this);
        session.addEventListener("change", this.$onDocumentChange);
        this.renderer.setSession(session);

        this.$onChangeMode = this.onChangeMode.bind(this);
        session.addEventListener("changeMode", this.$onChangeMode);

        this.$onTokenizerUpdate = this.onTokenizerUpdate.bind(this);
        session.addEventListener("tokenizerUpdate", this.$onTokenizerUpdate);

        this.$onChangeTabSize = this.renderer.updateText.bind(this.renderer);
        session.addEventListener("changeTabSize", this.$onChangeTabSize);

        this.$onChangeWrapLimit = this.onChangeWrapLimit.bind(this);
        session.addEventListener("changeWrapLimit", this.$onChangeWrapLimit);

        this.$onChangeWrapMode = this.onChangeWrapMode.bind(this);
        session.addEventListener("changeWrapMode", this.$onChangeWrapMode);

        this.$onChangeFold = this.onChangeFold.bind(this);
        session.addEventListener("changeFold", this.$onChangeFold);

        this.$onChangeFrontMarker = this.onChangeFrontMarker.bind(this);
        this.session.addEventListener("changeFrontMarker", this.$onChangeFrontMarker);

        this.$onChangeBackMarker = this.onChangeBackMarker.bind(this);
        this.session.addEventListener("changeBackMarker", this.$onChangeBackMarker);

        this.$onChangeBreakpoint = this.onChangeBreakpoint.bind(this);
        this.session.addEventListener("changeBreakpoint", this.$onChangeBreakpoint);

        this.$onChangeAnnotation = this.onChangeAnnotation.bind(this);
        this.session.addEventListener("changeAnnotation", this.$onChangeAnnotation);

        this.$onCursorChange = this.onCursorChange.bind(this);
        this.session.addEventListener("changeOverwrite", this.$onCursorChange);

        this.selection = session.getSelection();
        this.selection.addEventListener("changeCursor", this.$onCursorChange);

        this.$onSelectionChange = this.onSelectionChange.bind(this);
        this.selection.addEventListener("changeSelection", this.$onSelectionChange);

        this.onChangeMode();

        this.onCursorChange();
        this.onSelectionChange();
        this.onChangeFrontMarker();
        this.onChangeBackMarker();
        this.onChangeBreakpoint();
        this.onChangeAnnotation();
        this.renderer.scrollToRow(session.getScrollTopRow());
        this.renderer.updateFull();

        this._dispatchEvent("changeSession", {
            session: session,
            oldSession: oldSession
        });
    };

    this.getSession = function() {
        return this.session;
    };

    this.getSelection = function() {
        return this.selection;
    };

    this.resize = function() {
        this.renderer.onResize();
    };

    this.setTheme = function(theme) {
        this.renderer.setTheme(theme);
    };

    this.getTheme = function() {
        return this.renderer.getTheme();
    }

    this.setStyle = function(style) {
        this.renderer.setStyle(style)
    };

    this.unsetStyle = function(style) {
        this.renderer.unsetStyle(style)
    }

    this.$highlightBrackets = function() {
        if (this.session.$bracketHighlight) {
            this.session.removeMarker(this.session.$bracketHighlight);
            this.session.$bracketHighlight = null;
        }

        if (this.$highlightPending) {
            return;
        }

        // perform highlight async to not block the browser during navigation
        var self = this;
        this.$highlightPending = true;
        setTimeout(function() {
            self.$highlightPending = false;

            var pos = self.session.findMatchingBracket(self.getCursorPosition());
            if (pos) {
                var range = new Range(pos.row, pos.column, pos.row, pos.column+1);
                self.session.$bracketHighlight = self.session.addMarker(range, "ace_bracket");
            }
        }, 10);
    };

    this.focus = function() {
        // Safari needs the timeout
        // iOS and Firefox need it called immediately
        // to be on the save side we do both
        // except for IE
        var _self = this;
        if (!useragent.isIE) {
            setTimeout(function() {
                _self.textInput.focus();
            });
        }
        this.textInput.focus();
    };

    this.blur = function() {
        this.textInput.blur();
    };

    this.onFocus = function() {
        this.renderer.showCursor();
        this.renderer.visualizeFocus();
        this._dispatchEvent("focus");
    };

    this.onBlur = function() {
        this.renderer.hideCursor();
        this.renderer.visualizeBlur();
        this._dispatchEvent("blur");
    };

    this.onDocumentChange = function(e) {
        var delta = e.data;
        var range = delta.range;

        if (range.start.row == range.end.row && delta.action != "insertLines" && delta.action != "removeLines")
            var lastRow = range.end.row;
        else
            lastRow = Infinity;
        this.renderer.updateLines(range.start.row, lastRow);

        // update cursor because tab characters can influence the cursor position
        this.renderer.updateCursor();
    };

    this.onTokenizerUpdate = function(e) {
        var rows = e.data;
        this.renderer.updateLines(rows.first, rows.last);
    };

    this.onCursorChange = function(e) {
        this.renderer.updateCursor();

        if (!this.$blockScrolling) {
            this.renderer.scrollCursorIntoView();
        }

        // move text input over the cursor
        // this is required for iOS and IME
        this.renderer.moveTextAreaToCursor(this.textInput.getElement());

        this.$highlightBrackets();
        this.$updateHighlightActiveLine();
    };

    this.$updateHighlightActiveLine = function() {
        var session = this.getSession();

        if (session.$highlightLineMarker) {
            session.removeMarker(session.$highlightLineMarker);
        }
        session.$highlightLineMarker = null;

        if (this.getHighlightActiveLine() && (this.getSelectionStyle() != "line" || !this.selection.isMultiLine())) {
            var cursor = this.getCursorPosition(),
                foldLine = this.session.getFoldLine(cursor.row);
            var range;
            if (foldLine) {
                range = new Range(foldLine.start.row, 0, foldLine.end.row + 1, 0);
            } else {
                range = new Range(cursor.row, 0, cursor.row+1, 0);
            }
            session.$highlightLineMarker = session.addMarker(range, "ace_active_line", "line");
        }
    };

    this.onSelectionChange = function(e) {
        var session = this.getSession();

        if (session.$selectionMarker) {
            session.removeMarker(session.$selectionMarker);
        }
        session.$selectionMarker = null;

        if (!this.selection.isEmpty()) {
            var range = this.selection.getRange();
            var style = this.getSelectionStyle();
            session.$selectionMarker = session.addMarker(range, "ace_selection", style);
        } else {
            this.$updateHighlightActiveLine();
        }

        if (this.$highlightSelectedWord)
            this.session.getMode().highlightSelection(this);
    };

    this.onChangeFrontMarker = function() {
        this.renderer.updateFrontMarkers();
    };

    this.onChangeBackMarker = function() {
        this.renderer.updateBackMarkers();
    };

    this.onChangeBreakpoint = function() {
        this.renderer.setBreakpoints(this.session.getBreakpoints());
    };

    this.onChangeAnnotation = function() {
        this.renderer.setAnnotations(this.session.getAnnotations());
    };

    this.onChangeMode = function() {
        this.renderer.updateText()
    };

    this.onChangeWrapLimit = function() {
        this.renderer.updateFull();
    };

    this.onChangeWrapMode = function() {
        this.renderer.onResize(true);
    };

    this.onChangeFold = function() {
        // Update the active line marker as due to folding changes the current
        // line range on the screen might have changed.
        this.$updateHighlightActiveLine();
        // TODO: This might be too much updating. Okay for now.
        this.renderer.updateFull();
    };

    this.getCopyText = function() {
        if (!this.selection.isEmpty()) {
            return this.session.getTextRange(this.getSelectionRange());
        }
        else {
            return "";
        }
    };

    this.onCut = function() {
        if (this.$readOnly)
            return;

        if (!this.selection.isEmpty()) {
            this.session.remove(this.getSelectionRange())
            this.clearSelection();
        }
    };

    this.insert = function(text) {
        if (this.$readOnly)
            return;

        var session = this.session;
        var mode = session.getMode();

        var cursor = this.getCursorPosition();
        
        if (this.getBehavioursEnabled()) {
            // Get a transform if the current mode wants one.
            var transform = mode.transformAction(session.getState(cursor.row), 'insertion', this, session, text);
            if (transform)
                text = transform.text;
        }
        
        text = text.replace("\t", this.session.getTabString());

        // remove selected text
        if (!this.selection.isEmpty()) {
            var cursor = this.session.remove(this.getSelectionRange());
            this.clearSelection();
        }
        else if (this.session.getOverwrite()) {
            var range = new Range.fromPoints(cursor, cursor);
            range.end.column += text.length;
            this.session.remove(range);
        }

        this.clearSelection();

        var start         = cursor.column;
        var lineState     = session.getState(cursor.row);
        var shouldOutdent = mode.checkOutdent(lineState, session.getLine(cursor.row), text);
        var line          = session.getLine(cursor.row);
        var lineIndent    = mode.getNextLineIndent(lineState, line.slice(0, cursor.column), session.getTabString());
        var end           = session.insert(cursor, text);
        
        if (transform && transform.selection) {
            if (transform.selection.length == 2) { // Transform relative to the current column
                this.selection.setSelectionRange(
                    new Range(cursor.row, start + transform.selection[0],
                              cursor.row, start + transform.selection[1]));
            } else { // Transform relative to the current row.
                this.selection.setSelectionRange(
                    new Range(cursor.row + transform.selection[0],
                              transform.selection[1],
                              cursor.row + transform.selection[2],
                              transform.selection[3]));
            }
        }
        
        var lineState = session.getState(cursor.row);

        // TODO disabled multiline auto indent
        // possibly doing the indent before inserting the text
        // if (cursor.row !== end.row) {
        if (session.getDocument().isNewLine(text)) {
            this.moveCursorTo(cursor.row+1, 0);

            var size = session.getTabSize();
            var minIndent = Number.MAX_VALUE;

            for (var row = cursor.row + 1; row <= end.row; ++row) {
                var indent = 0;

                line = session.getLine(row);
                for (var i = 0; i < line.length; ++i)
                    if (line.charAt(i) == '\t')
                        indent += size;
                    else if (line.charAt(i) == ' ')
                        indent += 1;
                    else
                        break;
                if (/[^\s]/.test(line))
                    minIndent = Math.min(indent, minIndent);
            }

            for (var row = cursor.row + 1; row <= end.row; ++row) {
                var outdent = minIndent;

                line = session.getLine(row);
                for (var i = 0; i < line.length && outdent > 0; ++i)
                    if (line.charAt(i) == '\t')
                        outdent -= size;
                    else if (line.charAt(i) == ' ')
                        outdent -= 1;
                session.remove(new Range(row, 0, row, i));
            }
            session.indentRows(cursor.row + 1, end.row, lineIndent);
        } else {
            if (shouldOutdent) {
                mode.autoOutdent(lineState, session, cursor.row);
            }
        }
    };

    this.onTextInput = function(text) {
        this.keyBinding.onTextInput(text);
    };

    this.onCommandKey = function(e, hashId, keyCode) {
        this.keyBinding.onCommandKey(e, hashId, keyCode);
    };

    this.setOverwrite = function(overwrite) {
        this.session.setOverwrite(overwrite);
    };

    this.getOverwrite = function() {
        return this.session.getOverwrite();
    };

    this.toggleOverwrite = function() {
        this.session.toggleOverwrite();
    };

    this.setScrollSpeed = function(speed) {
        this.$mouseHandler.setScrollSpeed(speed);
    };

    this.getScrollSpeed = function() {
        return this.$mouseHandler.getScrollSpeed()
    };

    this.$selectionStyle = "line";
    this.setSelectionStyle = function(style) {
        if (this.$selectionStyle == style) return;

        this.$selectionStyle = style;
        this.onSelectionChange();
        this._dispatchEvent("changeSelectionStyle", {data: style});
    };

    this.getSelectionStyle = function() {
        return this.$selectionStyle;
    };

    this.$highlightActiveLine = true;
    this.setHighlightActiveLine = function(shouldHighlight) {
        if (this.$highlightActiveLine == shouldHighlight) return;

        this.$highlightActiveLine = shouldHighlight;
        this.$updateHighlightActiveLine();
    };

    this.getHighlightActiveLine = function() {
        return this.$highlightActiveLine;
    };

    this.$highlightSelectedWord = true;
    this.setHighlightSelectedWord = function(shouldHighlight) {
        if (this.$highlightSelectedWord == shouldHighlight)
            return;

        this.$highlightSelectedWord = shouldHighlight;
        if (shouldHighlight)
            this.session.getMode().highlightSelection(this);
        else
            this.session.getMode().clearSelectionHighlight(this);
    };

    this.getHighlightSelectedWord = function() {
        return this.$highlightSelectedWord;
    };

    this.setShowInvisibles = function(showInvisibles) {
        if (this.getShowInvisibles() == showInvisibles)
            return;

        this.renderer.setShowInvisibles(showInvisibles);
    };

    this.getShowInvisibles = function() {
        return this.renderer.getShowInvisibles();
    };

    this.setShowPrintMargin = function(showPrintMargin) {
        this.renderer.setShowPrintMargin(showPrintMargin);
    };

    this.getShowPrintMargin = function() {
        return this.renderer.getShowPrintMargin();
    };

    this.setPrintMarginColumn = function(showPrintMargin) {
        this.renderer.setPrintMarginColumn(showPrintMargin);
    };

    this.getPrintMarginColumn = function() {
        return this.renderer.getPrintMarginColumn();
    };

    this.$readOnly = false;
    this.setReadOnly = function(readOnly) {
        this.$readOnly = readOnly;
    };

    this.getReadOnly = function() {
        return this.$readOnly;
    };
    
    this.$modeBehaviours = false;
    this.setBehavioursEnabled = function (enabled) {
        this.$modeBehaviours = enabled;
    }
    
    this.getBehavioursEnabled = function () {
        return this.$modeBehaviours;
    }

    this.removeRight = function() {
        if (this.$readOnly)
            return;

        if (this.selection.isEmpty()) {
            this.selection.selectRight();
        }
        this.session.remove(this.getSelectionRange())
        this.clearSelection();
    };

    this.removeLeft = function() {
        if (this.$readOnly)
            return;

        if (this.selection.isEmpty())
            this.selection.selectLeft();
        
        var range = this.getSelectionRange();
        if (this.getBehavioursEnabled()) {
            var session = this.session;
            var state = session.getState(range.start.row);
            var new_range = session.getMode().transformAction(state, 'deletion', this, session, range);
            if (new_range !== false) {
                range = new_range;
            }
        }

        this.session.remove(range);
        this.clearSelection();
    };

    this.removeWordRight = function() {
        if (this.$readOnly)
            return;

        if (this.selection.isEmpty())
            this.selection.selectWordRight();

        this.session.remove(this.getSelectionRange());
        this.clearSelection();
    };

    this.removeWordLeft = function() {
        if (this.$readOnly)
            return;

        if (this.selection.isEmpty())
            this.selection.selectWordLeft();

        this.session.remove(this.getSelectionRange());
        this.clearSelection();
    };

    this.removeToLineStart = function() {
        if (this.$readOnly)
            return;

        if (this.selection.isEmpty())
            this.selection.selectLineStart();

        this.session.remove(this.getSelectionRange());
        this.clearSelection();
    };

    this.removeToLineEnd = function() {
        if (this.$readOnly)
            return;

        if (this.selection.isEmpty())
            this.selection.selectLineEnd();

        var range = this.getSelectionRange();
        if (range.start.column == range.end.column && range.start.row == range.end.row) {
            range.end.column = 0;
            range.end.row++;
        }

        this.session.remove(range);
        this.clearSelection();
    };

    this.splitLine = function() {
        if (this.$readOnly)
            return;

        if (!this.selection.isEmpty()) {
            this.session.remove(this.getSelectionRange());
            this.clearSelection();
        }

        var cursor = this.getCursorPosition();
        this.insert("\n");
        this.moveCursorToPosition(cursor);
    };

    this.transposeLetters = function() {
        if (this.$readOnly)
            return;

        if (!this.selection.isEmpty()) {
            return;
        }

        var cursor = this.getCursorPosition();
        var column = cursor.column;
        if (column == 0)
            return;

        var line = this.session.getLine(cursor.row);
        if (column < line.length) {
            var swap = line.charAt(column) + line.charAt(column-1);
            var range = new Range(cursor.row, column-1, cursor.row, column+1)
        }
        else {
            var swap = line.charAt(column-1) + line.charAt(column-2);
            var range = new Range(cursor.row, column-2, cursor.row, column)
        }
        this.session.replace(range, swap);
    };

    this.indent = function() {
        if (this.$readOnly)
            return;

        var session = this.session;
        var range = this.getSelectionRange();

        if (range.start.row < range.end.row || range.start.column < range.end.column) {
            var rows = this.$getSelectedRows();
            session.indentRows(rows.first, rows.last, "\t");
        } else {
            var indentString;

            if (this.session.getUseSoftTabs()) {
                var size        = session.getTabSize(),
                    position    = this.getCursorPosition(),
                    column      = session.documentToScreenColumn(position.row, position.column),
                    count       = (size - column % size);

                indentString = lang.stringRepeat(" ", count);
            } else
                indentString = "\t";
            return this.onTextInput(indentString);
        }
    };

    this.blockOutdent = function() {
        if (this.$readOnly)
            return;

        var selection = this.session.getSelection();
        this.session.outdentRows(selection.getRange());
    };

    this.toggleCommentLines = function() {
        if (this.$readOnly)
            return;

        var state = this.session.getState(this.getCursorPosition().row);
        var rows = this.$getSelectedRows()
        this.session.getMode().toggleCommentLines(state, this.session, rows.first, rows.last);
    };

    this.removeLines = function() {
        if (this.$readOnly)
            return;

        var rows = this.$getSelectedRows();
        this.session.remove(new Range(rows.first, 0, rows.last+1, 0));
        this.clearSelection();
    };

    this.moveLinesDown = function() {
        if (this.$readOnly)
            return;

        this.$moveLines(function(firstRow, lastRow) {
            return this.session.moveLinesDown(firstRow, lastRow);
        });
    };

    this.moveLinesUp = function() {
        if (this.$readOnly)
            return;

        this.$moveLines(function(firstRow, lastRow) {
            return this.session.moveLinesUp(firstRow, lastRow);
        });
    };

    this.moveText = function(range, toPosition) {
        if (this.$readOnly)
            return null;

        return this.session.moveText(range, toPosition);
    };

    this.copyLinesUp = function() {
        if (this.$readOnly)
            return;

        this.$moveLines(function(firstRow, lastRow) {
            this.session.duplicateLines(firstRow, lastRow);
            return 0;
        });
    };

    this.copyLinesDown = function() {
        if (this.$readOnly)
            return;

        this.$moveLines(function(firstRow, lastRow) {
            return this.session.duplicateLines(firstRow, lastRow);
        });
    };


    this.$moveLines = function(mover) {
        var rows = this.$getSelectedRows();

        var linesMoved = mover.call(this, rows.first, rows.last);

        var selection = this.selection;
        selection.setSelectionAnchor(rows.last+linesMoved+1, 0);
        selection.$moveSelection(function() {
            selection.moveCursorTo(rows.first+linesMoved, 0);
        });
    };

    this.$getSelectedRows = function() {
        var range = this.getSelectionRange().collapseRows();

        return {
            first: range.start.row,
            last: range.end.row
        };
    };

    this.onCompositionStart = function(text) {
        this.renderer.showComposition(this.getCursorPosition());
    };

    this.onCompositionUpdate = function(text) {
        this.renderer.setCompositionText(text);
    };

    this.onCompositionEnd = function() {
        this.renderer.hideComposition();
    };


    this.getFirstVisibleRow = function() {
        return this.renderer.getFirstVisibleRow();
    };

    this.getLastVisibleRow = function() {
        return this.renderer.getLastVisibleRow();
    };

    this.isRowVisible = function(row) {
        return (row >= this.getFirstVisibleRow() && row <= this.getLastVisibleRow());
    };

    this.$getVisibleRowCount = function() {
        return this.renderer.getScrollBottomRow() - this.renderer.getScrollTopRow() + 1;
    };

    this.$getPageDownRow = function() {
        return this.renderer.getScrollBottomRow();
    };

    this.$getPageUpRow = function() {
        var firstRow = this.renderer.getScrollTopRow();
        var lastRow = this.renderer.getScrollBottomRow();

        return firstRow - (lastRow - firstRow);
    };

    this.selectPageDown = function() {
        var row = this.$getPageDownRow() + Math.floor(this.$getVisibleRowCount() / 2);

        this.scrollPageDown();

        var selection = this.getSelection();
        var leadScreenPos = this.session.documentToScreenPosition(selection.getSelectionLead());
        var dest = this.session.screenToDocumentPosition(row, leadScreenPos.column);
        selection.selectTo(dest.row, dest.column);
    };

    this.selectPageUp = function() {
        var visibleRows = this.renderer.getScrollTopRow() - this.renderer.getScrollBottomRow();
        var row = this.$getPageUpRow() + Math.round(visibleRows / 2);

        this.scrollPageUp();

        var selection = this.getSelection();
        var leadScreenPos = this.session.documentToScreenPosition(selection.getSelectionLead());
        var dest = this.session.screenToDocumentPosition(row, leadScreenPos.column);
        selection.selectTo(dest.row, dest.column);
    };

    this.gotoPageDown = function() {
        var row = this.$getPageDownRow();
        var column = this.getCursorPositionScreen().column;

        this.scrollToRow(row);
        this.getSelection().moveCursorToScreen(row, column);
    };

    this.gotoPageUp = function() {
        var row = this.$getPageUpRow();
        var column = this.getCursorPositionScreen().column;

       this.scrollToRow(row);
       this.getSelection().moveCursorToScreen(row, column);
    };

    this.scrollPageDown = function() {
        this.scrollToRow(this.$getPageDownRow());
    };

    this.scrollPageUp = function() {
        this.renderer.scrollToRow(this.$getPageUpRow());
    };

    this.scrollToRow = function(row) {
        this.renderer.scrollToRow(row);
    };

    this.scrollToLine = function(line, center) {
        this.renderer.scrollToLine(line, center);
    };

    this.centerSelection = function() {
        var range = this.getSelectionRange();
        var line = Math.floor(range.start.row + (range.end.row - range.start.row) / 2);
        this.renderer.scrollToLine(line, true);
    };

    this.getCursorPosition = function() {
        return this.selection.getCursor();
    };

    this.getCursorPositionScreen = function() {
        return this.session.documentToScreenPosition(this.getCursorPosition());
    };

    this.getSelectionRange = function() {
        return this.selection.getRange();
    };


    this.selectAll = function() {
        this.$blockScrolling += 1;
        this.selection.selectAll();
        this.$blockScrolling -= 1;
    };

    this.clearSelection = function() {
        this.selection.clearSelection();
    };

    this.moveCursorTo = function(row, column) {
        this.selection.moveCursorTo(row, column);
    };

    this.moveCursorToPosition = function(pos) {
        this.selection.moveCursorToPosition(pos);
    };


    this.gotoLine = function(lineNumber, row) {
        this.selection.clearSelection();

        this.$blockScrolling += 1;
        this.moveCursorTo(lineNumber-1, row || 0);
        this.$blockScrolling -= 1;

        if (!this.isRowVisible(this.getCursorPosition().row)) {
            this.scrollToLine(lineNumber, true);
        }
    },

    this.navigateTo = function(row, column) {
        this.clearSelection();
        this.moveCursorTo(row, column);
    };

    this.navigateUp = function(times) {
        this.selection.clearSelection();
        times = times || 1;
        this.selection.moveCursorBy(-times, 0);
    };

    this.navigateDown = function(times) {
        this.selection.clearSelection();
        times = times || 1;
        this.selection.moveCursorBy(times, 0);
    };

    this.navigateLeft = function(times) {
        if (!this.selection.isEmpty()) {
            var selectionStart = this.getSelectionRange().start;
            this.moveCursorToPosition(selectionStart);
        }
        else {
            times = times || 1;
            while (times--) {
                this.selection.moveCursorLeft();
            }
        }
        this.clearSelection();
    };

    this.navigateRight = function(times) {
        if (!this.selection.isEmpty()) {
            var selectionEnd = this.getSelectionRange().end;
            this.moveCursorToPosition(selectionEnd);
        }
        else {
            times = times || 1;
            while (times--) {
                this.selection.moveCursorRight();
            }
        }
        this.clearSelection();
    };

    this.navigateLineStart = function() {
        this.selection.moveCursorLineStart();
        this.clearSelection();
    };

    this.navigateLineEnd = function() {
        this.selection.moveCursorLineEnd();
        this.clearSelection();
    };

    this.navigateFileEnd = function() {
        this.selection.moveCursorFileEnd();
        this.clearSelection();
    };

    this.navigateFileStart = function() {
        this.selection.moveCursorFileStart();
        this.clearSelection();
    };

    this.navigateWordRight = function() {
        this.selection.moveCursorWordRight();
        this.clearSelection();
    };

    this.navigateWordLeft = function() {
        this.selection.moveCursorWordLeft();
        this.clearSelection();
    };

    this.replace = function(replacement, options) {
        if (options)
            this.$search.set(options);

        var range = this.$search.find(this.session);
        this.$tryReplace(range, replacement);
        if (range !== null)
            this.selection.setSelectionRange(range);
    },

    this.replaceAll = function(replacement, options) {
        if (options) {
            this.$search.set(options);
        }

        var ranges = this.$search.findAll(this.session);
        if (!ranges.length)
            return;

        var selection = this.getSelectionRange();
        this.clearSelection();
        this.selection.moveCursorTo(0, 0);

        this.$blockScrolling += 1;
        for (var i = ranges.length - 1; i >= 0; --i)
            this.$tryReplace(ranges[i], replacement);

        this.selection.setSelectionRange(selection);
        this.$blockScrolling -= 1;
    },

    this.$tryReplace = function(range, replacement) {
        var input = this.session.getTextRange(range);
        var replacement = this.$search.replace(input, replacement);
        if (replacement !== null) {
            range.end = this.session.replace(range, replacement);
            return range;
        } else {
            return null;
        }
    };

    this.getLastSearchOptions = function() {
        return this.$search.getOptions();
    };

    this.find = function(needle, options) {
        this.clearSelection();
        options = options || {};
        options.needle = needle;
        this.$search.set(options);
        this.$find();
    },

    this.findNext = function(options) {
        options = options || {};
        if (typeof options.backwards == "undefined")
            options.backwards = false;
        this.$search.set(options);
        this.$find();
    };

    this.findPrevious = function(options) {
        options = options || {};
        if (typeof options.backwards == "undefined")
            options.backwards = true;
        this.$search.set(options);
        this.$find();
    };

    this.$find = function(backwards) {
        if (!this.selection.isEmpty()) {
            this.$search.set({needle: this.session.getTextRange(this.getSelectionRange())});
        }

        if (typeof backwards != "undefined")
            this.$search.set({backwards: backwards});

        var range = this.$search.find(this.session);
        if (range) {
            this.gotoLine(range.end.row+1, range.end.column);
            this.selection.setSelectionRange(range);
        }
    };

    this.undo = function() {
        this.session.getUndoManager().undo();
    };

    this.redo = function() {
        this.session.getUndoManager().redo();
    };

    this.destroy = function() {
        this.renderer.destroy();
    }

}).call(Editor.prototype);


exports.Editor = Editor;
});
/* vim:ts=4:sts=4:sw=4:
 * ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *      Mihai Sucan <mihai DOT sucan AT gmail DOT com>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('ace/keyboard/textinput', ['require', 'exports', 'module' , 'pilot/event', 'pilot/useragent', 'pilot/dom'], function(require, exports, module) {

var event = require("pilot/event");
var useragent = require("pilot/useragent");
var dom = require("pilot/dom");

var TextInput = function(parentNode, host) {

    var text = dom.createElement("textarea");
    text.style.left = "-10000px";
    parentNode.appendChild(text);

    var PLACEHOLDER = String.fromCharCode(0);
    sendText();

    var inCompostion = false;
    var copied = false;
    var tempStyle = '';

    function sendText(valueToSend) {
        if (!copied) {
            var value = valueToSend || text.value;
            if (value) {
                if (value.charCodeAt(value.length-1) == PLACEHOLDER.charCodeAt(0)) {
                    value = value.slice(0, -1);
                    if (value)
                        host.onTextInput(value);
                } else
                    host.onTextInput(value);
            }
        }
        copied = false;

        // Safari doesn't fire copy events if no text is selected
        text.value = PLACEHOLDER;
        text.select();
    }

    var onTextInput = function(e) {
        if (useragent.isIE && text.value.charCodeAt(0) > 128) return;
        setTimeout(function() {
            if (!inCompostion)
                sendText();
        }, 0);
    };

    var onCompositionStart = function(e) {
        inCompostion = true;
        if (!useragent.isIE) {
            sendText();
            text.value = "";
        };
        host.onCompositionStart();
        if (!useragent.isGecko) setTimeout(onCompositionUpdate, 0);
    };

    var onCompositionUpdate = function() {
        if (!inCompostion) return;
        host.onCompositionUpdate(text.value);
    };

    var onCompositionEnd = function(e) {
        inCompostion = false;
        host.onCompositionEnd();
        if (useragent.isGecko) {
          sendText();
        } else {
          setTimeout(function () {
              if (!inCompostion)
                  sendText();
          }, 0);
        }
    };

    var onCopy = function(e) {
        copied = true;
        var copyText = host.getCopyText();
        if(copyText)
            text.value = copyText;
        else
            e.preventDefault();
        text.select();
        setTimeout(function () {
            sendText();
        }, 0);
    };

    var onCut = function(e) {
        copied = true;
        var copyText = host.getCopyText();
        if(copyText) {
            text.value = copyText;
            host.onCut();
        } else
            e.preventDefault();
        text.select();
        setTimeout(function () {
            sendText();
        }, 0);
    };

    event.addCommandKeyListener(text, host.onCommandKey.bind(host));
    event.addListener(text, "keypress", onTextInput);
    if (useragent.isIE) {
        var keytable = { 13:1, 27:1 };
        event.addListener(text, "keyup", function (e) {
            if (inCompostion && (!text.value || keytable[e.keyCode]))
                setTimeout(onCompositionEnd, 0);
            if ((text.value.charCodeAt(0)|0) < 129) {
                return;
            };
            inCompostion ? onCompositionUpdate() : onCompositionStart();
        });
    };
    event.addListener(text, "textInput", onTextInput);
    event.addListener(text, "paste", function(e) {
        // Some browsers support the event.clipboardData API. Use this to get
        // the pasted content which increases speed if pasting a lot of lines.
        if (e.clipboardData && e.clipboardData.getData) {
            sendText(e.clipboardData.getData("text/plain"));
            e.preventDefault();
        } else
        // If a browser doesn't support any of the things above, use the regular
        // method to detect the pasted input.
        {
            onTextInput();
        }
    });
    if (!useragent.isIE) {
        event.addListener(text, "propertychange", onTextInput);
    };

    if (useragent.isIE) {
        event.addListener(text, "beforecopy", function(e) {        
            var copyText = host.getCopyText();
            if(copyText)
                clipboardData.setData("Text", copyText);
            else
                e.preventDefault();
        });
        event.addListener(parentNode, "keydown", function(e) {
            if (e.ctrlKey && e.keyCode == 88) {
                var copyText = host.getCopyText();
                if (copyText) {
                    clipboardData.setData("Text", copyText);
                    host.onCut();
                }
                event.preventDefault(e)
            }
        });
    }
    else {
        event.addListener(text, "copy", onCopy);
        event.addListener(text, "cut", onCut);
    }

    event.addListener(text, "compositionstart", onCompositionStart);
    if (useragent.isGecko) {
        event.addListener(text, "text", onCompositionUpdate);
    };
    if (useragent.isWebKit) {
        event.addListener(text, "keyup", onCompositionUpdate);
    };
    event.addListener(text, "compositionend", onCompositionEnd);

    event.addListener(text, "blur", function() {
        host.onBlur();
    });

    event.addListener(text, "focus", function() {
        host.onFocus();
        text.select();
    });

    this.focus = function() {
        host.onFocus();
        text.select();
        text.focus();
    };

    this.blur = function() {
        text.blur();
    };

    this.getElement = function() {
        return text;
    };

    this.onContextMenu = function(mousePos, isEmpty){
        if (mousePos) {
            if(!tempStyle)
                tempStyle = text.style.cssText;
            text.style.cssText = 'position:fixed; z-index:1000;' +
                    'left:' + (mousePos.x - 2) + 'px; top:' + (mousePos.y - 2) + 'px;'

        }
        if (isEmpty)
            text.value='';
    }

    this.onContextMenuClose = function(){
        setTimeout(function () {
            if (tempStyle) {
                text.style.cssText = tempStyle;
                tempStyle = '';
            }
            sendText();
        }, 0);
    }
};

exports.TextInput = TextInput;
});
/* vim:ts=4:sts=4:sw=4:
 * ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *      Mihai Sucan <mihai DOT sucan AT gmail DOT com>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('ace/mouse_handler', ['require', 'exports', 'module' , 'pilot/event', 'pilot/dom'], function(require, exports, module) {

var event = require("pilot/event");
var dom = require("pilot/dom");

var STATE_UNKNOWN = 0;
var STATE_SELECT = 1;
var STATE_DRAG = 2;

var DRAG_TIMER = 250; // milliseconds
var DRAG_OFFSET = 5; // pixels

var MouseHandler = function(editor) {
    this.editor = editor;
    event.addListener(editor.container, "mousedown", function(e) {
        editor.focus();
        return event.preventDefault(e);
    });
    event.addListener(editor.container, "selectstart", function(e) {
        return event.preventDefault(e);
    });

    var mouseTarget = editor.renderer.getMouseEventTarget();
    event.addListener(mouseTarget, "mousedown", this.onMouseDown.bind(this));
    event.addMultiMouseDownListener(mouseTarget, 0, 2, 500, this.onMouseDoubleClick.bind(this));
    event.addMultiMouseDownListener(mouseTarget, 0, 3, 600, this.onMouseTripleClick.bind(this));
    event.addMultiMouseDownListener(mouseTarget, 0, 4, 600, this.onMouseQuadClick.bind(this));
    event.addMouseWheelListener(mouseTarget, this.onMouseWheel.bind(this));
};

(function() {

    this.$scrollSpeed = 1;
    this.setScrollSpeed = function(speed) {
        this.$scrollSpeed = speed;
    };

    this.getScrollSpeed = function() {
        return this.$scrollSpeed;
    };

    this.$getEventPosition = function(e) {
        var pageX = event.getDocumentX(e);
        var pageY = event.getDocumentY(e);
        var pos = this.editor.renderer.screenToTextCoordinates(pageX, pageY);
        pos.row = Math.max(0, Math.min(pos.row, this.editor.session.getLength()-1));
        return pos;
    };

    this.$distance = function(ax, ay, bx, by) {
        return Math.sqrt(Math.pow(bx - ax, 2) + Math.pow(by - ay, 2));
    };

    this.onMouseDown = function(e) {
        var pageX = event.getDocumentX(e);
        var pageY = event.getDocumentY(e);
        var pos = this.$getEventPosition(e);
        var editor = this.editor;
        var self = this;
        var selectionRange = editor.getSelectionRange();
        var selectionEmpty = selectionRange.isEmpty();
        var state = STATE_UNKNOWN;
        var inSelection = false;

        var button = event.getButton(e);
        if (button !== 0) {
            if (selectionEmpty) {
                editor.moveCursorToPosition(pos);
            }
            if(button == 2) {
                editor.textInput.onContextMenu({x: pageX, y: pageY}, selectionEmpty);
                event.capture(editor.container, function(){}, editor.textInput.onContextMenuClose);
            }
            return;
        } else {
            // Select the fold as the user clicks it.
            var fold = editor.session.getFoldAt(pos.row, pos.column, 1);
            if (fold) {
                editor.selection.setSelectionRange(fold.range);
                return;
            }

            inSelection = !editor.getReadOnly()
                && !selectionEmpty
                && selectionRange.contains(pos.row, pos.column);
        }

        if (!inSelection) {
            // Directly pick STATE_SELECT, since the user is not clicking inside
            // a selection.
            onStartSelect(pos);
        }

        var mousePageX, mousePageY;
        var overwrite = editor.getOverwrite();
        var mousedownTime = (new Date()).getTime();
        var dragCursor, dragRange;

        var onMouseSelection = function(e) {
            mousePageX = event.getDocumentX(e);
            mousePageY = event.getDocumentY(e);
        };

        var onMouseSelectionEnd = function() {
            clearInterval(timerId);
            if (state == STATE_UNKNOWN)
                onStartSelect(pos);
            else if (state == STATE_DRAG)
                onMouseDragSelectionEnd();

            self.$clickSelection = null;
            state = STATE_UNKNOWN;
        };

        var onMouseDragSelectionEnd = function() {
            dom.removeCssClass(editor.container, "ace_dragging");
            editor.session.removeMarker(dragSelectionMarker);

            if (!self.$clickSelection) {
                if (!dragCursor) {
                    editor.moveCursorToPosition(pos);
                    editor.selection.clearSelection(pos.row, pos.column);
                }
            }

            if (!dragCursor)
                return;

            if (dragRange.contains(dragCursor.row, dragCursor.column)) {
                dragCursor = null;
                return;
            }

            editor.clearSelection();
            var newRange = editor.moveText(dragRange, dragCursor);
            if (!newRange) {
                dragCursor = null;
                return;
            }

            editor.selection.setSelectionRange(newRange);
        };

        var onSelectionInterval = function() {
            if (mousePageX === undefined || mousePageY === undefined)
                return;

            if (state == STATE_UNKNOWN) {
                var distance = self.$distance(pageX, pageY, mousePageX, mousePageY);
                var time = (new Date()).getTime();


                if (distance > DRAG_OFFSET) {
                    state = STATE_SELECT;
                    var cursor = editor.renderer.screenToTextCoordinates(mousePageX, mousePageY);
                    cursor.row = Math.max(0, Math.min(cursor.row, editor.session.getLength()-1));
                    onStartSelect(cursor);
                } else if ((time - mousedownTime) > DRAG_TIMER) {
                    state = STATE_DRAG;
                    dragRange = editor.getSelectionRange();
                    var style = editor.getSelectionStyle();
                    dragSelectionMarker = editor.session.addMarker(dragRange, "ace_selection", style);
                    editor.clearSelection();
                    dom.addCssClass(editor.container, "ace_dragging");
                }

            }

            if (state == STATE_DRAG)
                onDragSelectionInterval();
            else if (state == STATE_SELECT)
                onUpdateSelectionInterval();
        };

        function onStartSelect(pos) {
            if (e.shiftKey)
                editor.selection.selectToPosition(pos)
            else {
                if (!self.$clickSelection) {
                    editor.moveCursorToPosition(pos);
                    editor.selection.clearSelection(pos.row, pos.column);
                }
            }
            state = STATE_SELECT;
        }

        var onUpdateSelectionInterval = function() {
            var cursor = editor.renderer.screenToTextCoordinates(mousePageX, mousePageY);
            cursor.row = Math.max(0, Math.min(cursor.row, editor.session.getLength()-1));

            if (self.$clickSelection) {
                if (self.$clickSelection.contains(cursor.row, cursor.column)) {
                    editor.selection.setSelectionRange(self.$clickSelection);
                } else {
                    if (self.$clickSelection.compare(cursor.row, cursor.column) == -1) {
                        var anchor = self.$clickSelection.end;
                    } else {
                        var anchor = self.$clickSelection.start;
                    }
                    editor.selection.setSelectionAnchor(anchor.row, anchor.column);
                    editor.selection.selectToPosition(cursor);
                }
            }
            else {
                editor.selection.selectToPosition(cursor);
            }

            editor.renderer.scrollCursorIntoView();
        };

        var onDragSelectionInterval = function() {
            dragCursor = editor.renderer.screenToTextCoordinates(mousePageX, mousePageY);
            dragCursor.row = Math.max(0, Math.min(dragCursor.row,
                                                  editor.session.getLength() - 1));

            editor.moveCursorToPosition(dragCursor);
        };

        event.capture(editor.container, onMouseSelection, onMouseSelectionEnd);
        var timerId = setInterval(onSelectionInterval, 20);

        return event.preventDefault(e);
    };

    this.onMouseDoubleClick = function(e) {
        var editor = this.editor;
        var pos = this.$getEventPosition(e);

        // If the user dclicked on a fold, then expand it.
        var fold = editor.session.getFoldAt(pos.row, pos.column, 1);
        if (fold) {
            editor.session.expandFold(fold);
        } else {
            editor.moveCursorToPosition(pos);
            editor.selection.selectWord();
            this.$clickSelection = editor.getSelectionRange();
        }
    };

    this.onMouseTripleClick = function(e) {
        var pos = this.$getEventPosition(e);
        this.editor.moveCursorToPosition(pos);
        this.editor.selection.selectLine();
        this.$clickSelection = this.editor.getSelectionRange();
    };

    this.onMouseQuadClick = function(e) {
        this.editor.selectAll();
        this.$clickSelection = this.editor.getSelectionRange();
    };

    this.onMouseWheel = function(e) {
        var speed = this.$scrollSpeed * 2;

        this.editor.renderer.scrollBy(e.wheelX * speed, e.wheelY * speed);
        return event.preventDefault(e);
    };


}).call(MouseHandler.prototype);

exports.MouseHandler = MouseHandler;
});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *      Julian Viereck <julian.viereck@gmail.com>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('ace/keyboard/keybinding', ['require', 'exports', 'module' , 'pilot/useragent', 'pilot/keys', 'pilot/event', 'pilot/settings', 'pilot/canon', 'ace/commands/default_commands'], function(require, exports, module) {

var useragent = require("pilot/useragent");
var keyUtil  = require("pilot/keys");
var event = require("pilot/event");
var settings  = require("pilot/settings").settings;
var canon = require("pilot/canon");
require("ace/commands/default_commands");

var KeyBinding = function(editor) {
    this.$editor = editor;
    this.$data = { };
    this.$keyboardHandler = null;
};

(function() {
    this.setKeyboardHandler = function(keyboardHandler) {
        if (this.$keyboardHandler != keyboardHandler) {
            this.$data = { };
            this.$keyboardHandler = keyboardHandler;
        }
    };

    this.getKeyboardHandler = function() {
        return this.$keyboardHandler;
    };

    this.$callKeyboardHandler = function (e, hashId, keyOrText, keyCode) {
        var env = {editor: this.$editor},
            toExecute;

        if (this.$keyboardHandler) {
            toExecute =
                this.$keyboardHandler.handleKeyboard(this.$data, hashId, keyOrText, keyCode, e);
        }

        // If there is nothing to execute yet, then use the default keymapping.
        if (!toExecute || !toExecute.command) {
            if (hashId != 0 || keyCode != 0) {
                toExecute = {
                    command: canon.findKeyCommand(env, "editor", hashId, keyOrText)
                }
            } else {
                toExecute = {
                    command: "inserttext",
                    args: {
                        text: keyOrText
                    }
                }
            }
        }

        if (toExecute) {
            var success = canon.exec(toExecute.command,
                                        env, "editor", toExecute.args);
            if (success) {
                return event.stopEvent(e);
            }
        }
    };

    this.onCommandKey = function(e, hashId, keyCode) {
        var keyString = keyUtil.keyCodeToString(keyCode);
        this.$callKeyboardHandler(e, hashId, keyString, keyCode);
    };

    this.onTextInput = function(text) {
        this.$callKeyboardHandler({}, 0, text, 0);
    }

}).call(KeyBinding.prototype);

exports.KeyBinding = KeyBinding;
});
/* vim:ts=4:sts=4:sw=4:
 * ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *      Julian Viereck <julian.viereck@gmail.com>
 *      Mihai Sucan <mihai.sucan@gmail.com>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('ace/commands/default_commands', ['require', 'exports', 'module' , 'pilot/lang', 'pilot/canon'], function(require, exports, module) {

var lang = require("pilot/lang");
var canon = require("pilot/canon");

function bindKey(win, mac) {
    return {
        win: win,
        mac: mac,
        sender: "editor"
    };
}

canon.addCommand({
    name: "null",
    exec: function(env, args, request) {  }
});

canon.addCommand({
    name: "selectall",
    bindKey: bindKey("Ctrl-A", "Command-A"),
    exec: function(env, args, request) { env.editor.selectAll(); }
});
canon.addCommand({
    name: "removeline",
    bindKey: bindKey("Ctrl-D", "Command-D"),
    exec: function(env, args, request) { env.editor.removeLines(); }
});
canon.addCommand({
    name: "gotoline",
    bindKey: bindKey("Ctrl-L", "Command-L"),
    exec: function(env, args, request) {
        var line = parseInt(prompt("Enter line number:"));
        if (!isNaN(line)) {
            env.editor.gotoLine(line);
        }
    }
});
canon.addCommand({
    name: "togglecomment",
    bindKey: bindKey("Ctrl-7", "Command-7"),
    exec: function(env, args, request) { env.editor.toggleCommentLines(); }
});
canon.addCommand({
    name: "findnext",
    bindKey: bindKey("Ctrl-K", "Command-G"),
    exec: function(env, args, request) { env.editor.findNext(); }
});
canon.addCommand({
    name: "findprevious",
    bindKey: bindKey("Ctrl-Shift-K", "Command-Shift-G"),
    exec: function(env, args, request) { env.editor.findPrevious(); }
});
canon.addCommand({
    name: "find",
    bindKey: bindKey("Ctrl-F", "Command-F"),
    exec: function(env, args, request) {
        var needle = prompt("Find:");
        env.editor.find(needle);
    }
});
canon.addCommand({
    name: "replace",
    bindKey: bindKey("Ctrl-R", "Command-Option-F"),
    exec: function(env, args, request) {
        var needle = prompt("Find:");
        if (!needle)
            return;
        var replacement = prompt("Replacement:");
        if (!replacement)
            return;
        env.editor.replace(replacement, {needle: needle});
    }
});
canon.addCommand({
    name: "replaceall",
    bindKey: bindKey("Ctrl-Shift-R", "Command-Shift-Option-F"),
    exec: function(env, args, request) {
        var needle = prompt("Find:");
        if (!needle)
            return;
        var replacement = prompt("Replacement:");
        if (!replacement)
            return;
        env.editor.replaceAll(replacement, {needle: needle});
    }
});
canon.addCommand({
    name: "undo",
    bindKey: bindKey("Ctrl-Z", "Command-Z"),
    exec: function(env, args, request) { env.editor.undo(); }
});
canon.addCommand({
    name: "redo",
    bindKey: bindKey("Ctrl-Shift-Z|Ctrl-Y", "Command-Shift-Z|Command-Y"),
    exec: function(env, args, request) { env.editor.redo(); }
});
canon.addCommand({
    name: "overwrite",
    bindKey: bindKey("Insert", "Insert"),
    exec: function(env, args, request) { env.editor.toggleOverwrite(); }
});
canon.addCommand({
    name: "copylinesup",
    bindKey: bindKey("Ctrl-Alt-Up", "Command-Option-Up"),
    exec: function(env, args, request) { env.editor.copyLinesUp(); }
});
canon.addCommand({
    name: "movelinesup",
    bindKey: bindKey("Alt-Up", "Option-Up"),
    exec: function(env, args, request) { env.editor.moveLinesUp(); }
});
canon.addCommand({
    name: "selecttostart",
    bindKey: bindKey("Ctrl-Shift-Home|Alt-Shift-Up", "Command-Shift-Up"),
    exec: function(env, args, request) { env.editor.getSelection().selectFileStart(); }
});
canon.addCommand({
    name: "gotostart",
    bindKey: bindKey("Ctrl-Home|Ctrl-Up", "Command-Home|Command-Up"),
    exec: function(env, args, request) { env.editor.navigateFileStart(); }
});
canon.addCommand({
    name: "selectup",
    bindKey: bindKey("Shift-Up", "Shift-Up"),
    exec: function(env, args, request) { env.editor.getSelection().selectUp(); }
});
canon.addCommand({
    name: "golineup",
    bindKey: bindKey("Up", "Up|Ctrl-P"),
    exec: function(env, args, request) { env.editor.navigateUp(args.times); }
});
canon.addCommand({
    name: "copylinesdown",
    bindKey: bindKey("Ctrl-Alt-Down", "Command-Option-Down"),
    exec: function(env, args, request) { env.editor.copyLinesDown(); }
});
canon.addCommand({
    name: "movelinesdown",
    bindKey: bindKey("Alt-Down", "Option-Down"),
    exec: function(env, args, request) { env.editor.moveLinesDown(); }
});
canon.addCommand({
    name: "selecttoend",
    bindKey: bindKey("Ctrl-Shift-End|Alt-Shift-Down", "Command-Shift-Down"),
    exec: function(env, args, request) { env.editor.getSelection().selectFileEnd(); }
});
canon.addCommand({
    name: "gotoend",
    bindKey: bindKey("Ctrl-End|Ctrl-Down", "Command-End|Command-Down"),
    exec: function(env, args, request) { env.editor.navigateFileEnd(); }
});
canon.addCommand({
    name: "selectdown",
    bindKey: bindKey("Shift-Down", "Shift-Down"),
    exec: function(env, args, request) { env.editor.getSelection().selectDown(); }
});
canon.addCommand({
    name: "golinedown",
    bindKey: bindKey("Down", "Down|Ctrl-N"),
    exec: function(env, args, request) { env.editor.navigateDown(args.times); }
});
canon.addCommand({
    name: "selectwordleft",
    bindKey: bindKey("Ctrl-Shift-Left", "Option-Shift-Left"),
    exec: function(env, args, request) { env.editor.getSelection().selectWordLeft(); }
});
canon.addCommand({
    name: "gotowordleft",
    bindKey: bindKey("Ctrl-Left", "Option-Left"),
    exec: function(env, args, request) { env.editor.navigateWordLeft(); }
});
canon.addCommand({
    name: "selecttolinestart",
    bindKey: bindKey("Alt-Shift-Left", "Command-Shift-Left"),
    exec: function(env, args, request) { env.editor.getSelection().selectLineStart(); }
});
canon.addCommand({
    name: "gotolinestart",
    bindKey: bindKey("Alt-Left|Home", "Command-Left|Home|Ctrl-A"),
    exec: function(env, args, request) { env.editor.navigateLineStart(); }
});
canon.addCommand({
    name: "selectleft",
    bindKey: bindKey("Shift-Left", "Shift-Left"),
    exec: function(env, args, request) { env.editor.getSelection().selectLeft(); }
});
canon.addCommand({
    name: "gotoleft",
    bindKey: bindKey("Left", "Left|Ctrl-B"),
    exec: function(env, args, request) { env.editor.navigateLeft(args.times); }
});
canon.addCommand({
    name: "selectwordright",
    bindKey: bindKey("Ctrl-Shift-Right", "Option-Shift-Right"),
    exec: function(env, args, request) { env.editor.getSelection().selectWordRight(); }
});
canon.addCommand({
    name: "gotowordright",
    bindKey: bindKey("Ctrl-Right", "Option-Right"),
    exec: function(env, args, request) { env.editor.navigateWordRight(); }
});
canon.addCommand({
    name: "selecttolineend",
    bindKey: bindKey("Alt-Shift-Right", "Command-Shift-Right"),
    exec: function(env, args, request) { env.editor.getSelection().selectLineEnd(); }
});
canon.addCommand({
    name: "gotolineend",
    bindKey: bindKey("Alt-Right|End", "Command-Right|End|Ctrl-E"),
    exec: function(env, args, request) { env.editor.navigateLineEnd(); }
});
canon.addCommand({
    name: "selectright",
    bindKey: bindKey("Shift-Right", "Shift-Right"),
    exec: function(env, args, request) { env.editor.getSelection().selectRight(); }
});
canon.addCommand({
    name: "gotoright",
    bindKey: bindKey("Right", "Right|Ctrl-F"),
    exec: function(env, args, request) { env.editor.navigateRight(args.times); }
});
canon.addCommand({
    name: "selectpagedown",
    bindKey: bindKey("Shift-PageDown", "Shift-PageDown"),
    exec: function(env, args, request) { env.editor.selectPageDown(); }
});
canon.addCommand({
    name: "pagedown",
    bindKey: bindKey(null, "PageDown"),
    exec: function(env, args, request) { env.editor.scrollPageDown(); }
});
canon.addCommand({
    name: "gotopagedown",
    bindKey: bindKey("PageDown", "Option-PageDown|Ctrl-V"),
    exec: function(env, args, request) { env.editor.gotoPageDown(); }
});
canon.addCommand({
    name: "selectpageup",
    bindKey: bindKey("Shift-PageUp", "Shift-PageUp"),
    exec: function(env, args, request) { env.editor.selectPageUp(); }
});
canon.addCommand({
    name: "pageup",
    bindKey: bindKey(null, "PageUp"),
    exec: function(env, args, request) { env.editor.scrollPageUp(); }
});
canon.addCommand({
    name: "gotopageup",
    bindKey: bindKey("PageUp", "Option-PageUp"),
    exec: function(env, args, request) { env.editor.gotoPageUp(); }
});
canon.addCommand({
    name: "selectlinestart",
    bindKey: bindKey("Shift-Home", "Shift-Home"),
    exec: function(env, args, request) { env.editor.getSelection().selectLineStart(); }
});
canon.addCommand({
    name: "selectlineend",
    bindKey: bindKey("Shift-End", "Shift-End"),
    exec: function(env, args, request) { env.editor.getSelection().selectLineEnd(); }
});
canon.addCommand({
    name: "del",
    bindKey: bindKey("Delete", "Delete|Ctrl-D"),
    exec: function(env, args, request) { env.editor.removeRight(); }
});
canon.addCommand({
    name: "backspace",
    bindKey: bindKey(
        "Ctrl-Backspace|Command-Backspace|Option-Backspace|Shift-Backspace|Backspace",
        "Ctrl-Backspace|Command-Backspace|Shift-Backspace|Backspace|Ctrl-H"
    ),
    exec: function(env, args, request) { env.editor.removeLeft(); }
});
canon.addCommand({
    name: "removetolinestart",
    bindKey: bindKey(null, "Option-Backspace"),
    exec: function(env, args, request) { env.editor.removeToLineStart(); }
});
canon.addCommand({
    name: "removetolineend",
    bindKey: bindKey(null, "Ctrl-K"),
    exec: function(env, args, request) { env.editor.removeToLineEnd(); }
});
canon.addCommand({
    name: "removewordleft",
    bindKey: bindKey(null, "Alt-Backspace|Ctrl-Alt-Backspace"),
    exec: function(env, args, request) { env.editor.removeWordLeft(); }
});
canon.addCommand({
    name: "removewordright",
    bindKey: bindKey(null, "Alt-Delete"),
    exec: function(env, args, request) { env.editor.removeWordRight(); }
});
canon.addCommand({
    name: "outdent",
    bindKey: bindKey("Shift-Tab", "Shift-Tab"),
    exec: function(env, args, request) { env.editor.blockOutdent(); }
});
canon.addCommand({
    name: "indent",
    bindKey: bindKey("Tab", "Tab"),
    exec: function(env, args, request) { env.editor.indent(); }
});
canon.addCommand({
    name: "inserttext",
    exec: function(env, args, request) {
        env.editor.insert(lang.stringRepeat(args.text  || "", args.times || 1));
    }
});
canon.addCommand({
    name: "centerselection",
    bindKey: bindKey(null, "Ctrl-L"),
    exec: function(env, args, request) { env.editor.centerSelection(); }
});
canon.addCommand({
    name: "splitline",
    bindKey: bindKey(null, "Ctrl-O"),
    exec: function(env, args, request) { env.editor.splitLine(); }
});
canon.addCommand({
    name: "transposeletters",
    bindKey: bindKey("Ctrl-T", "Ctrl-T"),
    exec: function(env, args, request) { env.editor.transposeLetters(); }
});

});/* vim:ts=4:sts=4:sw=4:
 * ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *      Mihai Sucan <mihai DOT sucan AT gmail DOT com>
 *      Julian Viereck <julian DOT viereck AT gmail DOT com>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('ace/edit_session', ['require', 'exports', 'module' , 'pilot/oop', 'pilot/lang', 'pilot/event_emitter', 'ace/selection', 'ace/mode/text', 'ace/range', 'ace/document', 'ace/background_tokenizer', 'ace/edit_session/folding'], function(require, exports, module) {

var oop = require("pilot/oop");
var lang = require("pilot/lang");
var EventEmitter = require("pilot/event_emitter").EventEmitter;
var Selection = require("ace/selection").Selection;
var TextMode = require("ace/mode/text").Mode;
var Range = require("ace/range").Range;
var Document = require("ace/document").Document;
var BackgroundTokenizer = require("ace/background_tokenizer").BackgroundTokenizer;

var EditSession = function(text, mode) {
    this.$modified = true;
    this.$breakpoints = [];
    this.$frontMarkers = {};
    this.$backMarkers = {};
    this.$markerId = 1;
    this.$rowCache = [];
    this.$rowCacheSize = 1000;
    this.$wrapData = [];
    this.$foldData = [];
    this.$foldData.toString = function() {
        var str = "";
        this.forEach(function(foldLine) {
            str += "\n" + foldLine.toString();
        });
        return str;
    }
    this.$docChangeCounter = 0;

    if (text instanceof Document) {
        this.setDocument(text);
    } else {
        this.setDocument(new Document(text));
    }

    this.selection = new Selection(this);
    if (mode)
        this.setMode(mode);
    else
        this.setMode(new TextMode());
};


(function() {

    oop.implement(this, EventEmitter);

    this.setDocument = function(doc) {
        if (this.doc)
            throw new Error("Document is already set");

        this.doc = doc;
        doc.on("change", this.onChange.bind(this));
        doc.on("changeStart", this.onChangeStart.bind(this));
        doc.on("changeEnd",   this.onChangeEnd.bind(this));
        this.on("changeFold", this.onChangeFold.bind(this));
    };

    this.getDocument = function() {
        return this.doc;
    };

    this.onChangeStart = function() {
        this.$docChangeCounter ++;
    };

    this.$resetRowCache = function(row) {
        if (row == 0) {
            this.$rowCache = [];
            return;
        }
        var rowCache = this.$rowCache;
        for (var i = 0; i < rowCache.length; i++) {
            if (rowCache[i].docRow >= row) {
                rowCache.splice(i, rowCache.length);
                return;
            }
        }
    }

    this.onChangeEnd = function() {
        this.$docChangeCounter --;
        if (this.$docChangeCounter == 0
            && !this.$fromUndo && this.$undoManager)
        {
            if (this.$deltasFold.length) {
                this.$deltas.push({
                    group: "fold",
                    deltas: this.$deltasFold
                });
                this.$deltasFold = [];
            }
            if (this.$deltasDoc) {
                this.$deltas.push({
                    group: "doc",
                    deltas: this.$deltasDoc
                });
                this.$deltasDoc = [];
            }
            this.$informUndoManager.schedule();
        }
    };

    this.onChangeFold = function(e) {
        var fold = e.data;
        this.$resetRowCache(fold.start.row);
    };

    this.onChange = function(e) {
        var delta = e.data;
        this.$modified = true;

        this.$resetRowCache(delta.range.start.row);

        var removedFolds = this.$updateInternalDataOnChange(e);
        if (!this.$fromUndo && this.$undoManager && !delta.ignore) {
            this.$deltasDoc.push(delta);
            if (removedFolds && removedFolds.length != 0) {
                this.$deltasFold.push({
                    action: "removeFolds",
                    folds:  removedFolds
                });
            }
        }

        this.bgTokenizer.start(delta.range.start.row);
        this._dispatchEvent("change", e);
    };

    this.setValue = function(text) {
        this.doc.setValue(text);
        this.$resetRowCache(0);
        this.$deltas = [];
        this.$deltasDoc = [];
        this.$deltasFold = [];
        this.getUndoManager().reset();
    };

    this.getValue =
    this.toString = function() {
        return this.doc.getValue();
    };

    this.getSelection = function() {
        return this.selection;
    };

    this.getState = function(row) {
        return this.bgTokenizer.getState(row);
    };

    this.getTokens = function(firstRow, lastRow) {
        return this.bgTokenizer.getTokens(firstRow, lastRow);
    };

    this.setUndoManager = function(undoManager) {
        this.$undoManager = undoManager;
        this.$resetRowCache(0);
        this.$deltas = [];
        this.$deltasDoc = [];
        this.$deltasFold = [];

        if (this.$informUndoManager) {
            this.$informUndoManager.cancel();
        }

        if (undoManager) {
            var self = this;
            this.$syncInformUndoManager = function() {
                self.$informUndoManager.cancel();
                if (self.$deltas.length > 0)
                    undoManager.execute({
                        action : "aceupdate",
                        args   : [self.$deltas, self]
                    });
                self.$deltas = [];
            }
            this.$informUndoManager =
                lang.deferredCall(this.$syncInformUndoManager);
        }
    };

    this.$defaultUndoManager = {
        undo: function() {},
        redo: function() {},
        reset: function() {}
    };

    this.getUndoManager = function() {
        return this.$undoManager || this.$defaultUndoManager;
    },

    this.getTabString = function() {
        if (this.getUseSoftTabs()) {
            return lang.stringRepeat(" ", this.getTabSize());
        } else {
            return "\t";
        }
    };

    this.$useSoftTabs = true;
    this.setUseSoftTabs = function(useSoftTabs) {
        if (this.$useSoftTabs === useSoftTabs) return;

        this.$useSoftTabs = useSoftTabs;
    };

    this.getUseSoftTabs = function() {
        return this.$useSoftTabs;
    };

    this.$tabSize = 4;
    this.setTabSize = function(tabSize) {
        if (isNaN(tabSize) || this.$tabSize === tabSize) return;

        this.$modified = true;
        this.$tabSize = tabSize;
        this._dispatchEvent("changeTabSize");
    };

    this.getTabSize = function() {
        return this.$tabSize;
    };

    this.isTabStop = function(position) {
        return this.$useSoftTabs && (position.column % this.$tabSize == 0);
    };

    this.$overwrite = false;
    this.setOverwrite = function(overwrite) {
        if (this.$overwrite == overwrite) return;

        this.$overwrite = overwrite;
        this._dispatchEvent("changeOverwrite");
    };

    this.getOverwrite = function() {
        return this.$overwrite;
    };

    this.toggleOverwrite = function() {
        this.setOverwrite(!this.$overwrite);
    };

    this.getBreakpoints = function() {
        return this.$breakpoints;
    };

    this.setBreakpoints = function(rows) {
        this.$breakpoints = [];
        for (var i=0; i<rows.length; i++) {
            this.$breakpoints[rows[i]] = true;
        }
        this._dispatchEvent("changeBreakpoint", {});
    };

    this.clearBreakpoints = function() {
        this.$breakpoints = [];
        this._dispatchEvent("changeBreakpoint", {});
    };

    this.setBreakpoint = function(row) {
        this.$breakpoints[row] = true;
        this._dispatchEvent("changeBreakpoint", {});
    };

    this.clearBreakpoint = function(row) {
        delete this.$breakpoints[row];
        this._dispatchEvent("changeBreakpoint", {});
    };

    this.getBreakpoints = function() {
        return this.$breakpoints;
    };

    this.addMarker = function(range, clazz, type, inFront) {
        var id = this.$markerId++;

        var marker = {
            range : range,
            type : type || "line",
            renderer: typeof type == "function" ? type : null,
            clazz : clazz,
            inFront: !!inFront
        }

        if (inFront) {
            this.$frontMarkers[id] = marker;
            this._dispatchEvent("changeFrontMarker")
        } else {
            this.$backMarkers[id] = marker;
            this._dispatchEvent("changeBackMarker")
        }

        return id;
    };

    this.removeMarker = function(markerId) {
        var marker = this.$frontMarkers[markerId] || this.$backMarkers[markerId];
        if (!marker)
            return;

        var markers = marker.inFront ? this.$frontMarkers : this.$backMarkers;
        if (marker) {
            delete (markers[markerId]);
            this._dispatchEvent(marker.inFront ? "changeFrontMarker" : "changeBackMarker");
        }
    };

    this.getMarkers = function(inFront) {
        return inFront ? this.$frontMarkers : this.$backMarkers;
    };

    /**
     * Error:
     *  {
     *    row: 12,
     *    column: 2, //can be undefined
     *    text: "Missing argument",
     *    type: "error" // or "warning" or "info"
     *  }
     */
    this.setAnnotations = function(annotations) {
        this.$annotations = {};
        for (var i=0; i<annotations.length; i++) {
            var annotation = annotations[i];
            var row = annotation.row;
            if (this.$annotations[row])
                this.$annotations[row].push(annotation);
            else
                this.$annotations[row] = [annotation];
        }
        this._dispatchEvent("changeAnnotation", {});
    };

    this.getAnnotations = function() {
        return this.$annotations;
    };

    this.clearAnnotations = function() {
        this.$annotations = {};
        this._dispatchEvent("changeAnnotation", {});
    };

    this.$detectNewLine = function(text) {
        var match = text.match(/^.*?(\r?\n)/m);
        if (match) {
            this.$autoNewLine = match[1];
        } else {
            this.$autoNewLine = "\n";
        }
    };

    this.tokenRe = /^[\w\d]+/g;
    this.nonTokenRe = /^(?:[^\w\d]|[\u3040-\u309F]|[\u30A0-\u30FF]|[\u4E00-\u9FFF\uF900-\uFAFF\u3400-\u4DBF])+/g;

    this.getWordRange = function(row, column) {
        var line = this.getLine(row);

        var inToken = false;
        if (column > 0) {
            inToken = !!line.charAt(column - 1).match(this.tokenRe);
        }

        if (!inToken) {
            inToken = !!line.charAt(column).match(this.tokenRe);
        }

        var re = inToken ? this.tokenRe : this.nonTokenRe;

        var start = column;
        if (start > 0) {
            do {
                start--;
            }
            while (start >= 0 && line.charAt(start).match(re));
            start++;
        }

        var end = column;
        while (end < line.length && line.charAt(end).match(re)) {
            end++;
        }

        return new Range(row, start, row, end);
    };

    this.setNewLineMode = function(newLineMode) {
        this.doc.setNewLineMode(newLineMode);
    };

    this.getNewLineMode = function() {
        return this.doc.getNewLineMode();
    };

    this.$useWorker = true;
    this.setUseWorker = function(useWorker) {
        if (this.$useWorker == useWorker)
            return;

        this.$useWorker = useWorker;

        this.$stopWorker();
        if (useWorker)
            this.$startWorker();
    };

    this.getUseWorker = function() {
        return this.$useWorker;
    };

    this.onReloadTokenizer = function(e) {
        var rows = e.data;
        this.bgTokenizer.start(rows.first);
        this._dispatchEvent("tokenizerUpdate", e);
    };

    this.$mode = null;
    this.setMode = function(mode) {
        if (this.$mode === mode) return;
        this.$mode = mode;

        this.$stopWorker();

        if (this.$useWorker)
            this.$startWorker();

        var tokenizer = mode.getTokenizer();

        if(tokenizer.addEventListener !== undefined) {
            var onReloadTokenizer = this.onReloadTokenizer.bind(this);
            tokenizer.addEventListener("update", onReloadTokenizer);
        }

        if (!this.bgTokenizer) {
            this.bgTokenizer = new BackgroundTokenizer(tokenizer);
            var _self = this;
            this.bgTokenizer.addEventListener("update", function(e) {
                _self._dispatchEvent("tokenizerUpdate", e);
            });
        } else {
            this.bgTokenizer.setTokenizer(tokenizer);
        }

        this.bgTokenizer.setDocument(this.getDocument());
        this.bgTokenizer.start(0);

        this._dispatchEvent("changeMode");
    };

    this.$stopWorker = function() {
        if (this.$worker)
            this.$worker.terminate();

        this.$worker = null;
    };

    this.$startWorker = function() {
        if (typeof Worker !== "undefined" && !require.noWorker) {
            try {
                this.$worker = this.$mode.createWorker(this);
            } catch (e) {
                console.log("Could not load worker");
                console.log(e);
                this.$worker = null;
            }
        }
        else
            this.$worker = null;
    };

    this.getMode = function() {
        return this.$mode;
    };

    this.$scrollTop = 0;
    this.setScrollTopRow = function(scrollTopRow) {
        if (this.$scrollTop === scrollTopRow) return;

        this.$scrollTop = scrollTopRow;
        this._dispatchEvent("changeScrollTop");
    };

    this.getScrollTopRow = function() {
        return this.$scrollTop;
    };

    this.getWidth = function() {
        this.$computeWidth();
        return this.width;
    };

    this.getScreenWidth = function() {
        this.$computeWidth();
        return this.screenWidth;
    };

    this.$computeWidth = function(force) {
        if (this.$modified || force) {
            this.$modified = false;

            var lines = this.doc.getAllLines();
            var longestLine = 0;
            var longestScreenLine = 0;

            for ( var i = 0; i < lines.length; i++) {
                var foldLine = this.getFoldLine(i),
                    line, len;

                line = lines[i];
                if (foldLine) {
                    var end = foldLine.range.end;
                    line = this.getFoldDisplayLine(foldLine);
                    // Continue after the foldLine.end.row. All the lines in
                    // between are folded.
                    i = end.row;
                }
                len = line.length;
                longestLine = Math.max(longestLine, len);
                if (!this.$useWrapMode) {
                    longestScreenLine = Math.max(
                        longestScreenLine,
                        this.$getStringScreenWidth(line)[0]
                    );
                }
            }
            this.width = longestLine;

            if (this.$useWrapMode) {
                this.screenWidth = this.$wrapLimit;
            } else {
                this.screenWidth = longestScreenLine;
            }
        }
    };

    /**
     * Get a verbatim copy of the given line as it is in the document
     */
    this.getLine = function(row) {
        return this.doc.getLine(row);
    };

    this.getLines = function(firstRow, lastRow) {
        return this.doc.getLines(firstRow, lastRow);
    };

    this.getLength = function() {
        return this.doc.getLength();
    };

    this.getTextRange = function(range) {
        return this.doc.getTextRange(range);
    };

    this.findMatchingBracket = function(position) {
        if (position.column == 0) return null;

        var charBeforeCursor = this.getLine(position.row).charAt(position.column-1);
        if (charBeforeCursor == "") return null;

        var match = charBeforeCursor.match(/([\(\[\{])|([\)\]\}])/);
        if (!match) {
            return null;
        }

        if (match[1]) {
            return this.$findClosingBracket(match[1], position);
        } else {
            return this.$findOpeningBracket(match[2], position);
        }
    };

    this.$brackets = {
        ")": "(",
        "(": ")",
        "]": "[",
        "[": "]",
        "{": "}",
        "}": "{"
    };

    this.$findOpeningBracket = function(bracket, position) {
        var openBracket = this.$brackets[bracket];

        var column = position.column - 2;
        var row = position.row;
        var depth = 1;

        var line = this.getLine(row);

        while (true) {
            while(column >= 0) {
                var ch = line.charAt(column);
                if (ch == openBracket) {
                    depth -= 1;
                    if (depth == 0) {
                        return {row: row, column: column};
                    }
                }
                else if (ch == bracket) {
                    depth +=1;
                }
                column -= 1;
            }
            row -=1;
            if (row < 0) break;

            var line = this.getLine(row);
            var column = line.length-1;
        }
        return null;
    };

    this.$findClosingBracket = function(bracket, position) {
        var closingBracket = this.$brackets[bracket];

        var column = position.column;
        var row = position.row;
        var depth = 1;

        var line = this.getLine(row);
        var lineCount = this.getLength();

        while (true) {
            while(column < line.length) {
                var ch = line.charAt(column);
                if (ch == closingBracket) {
                    depth -= 1;
                    if (depth == 0) {
                        return {row: row, column: column};
                    }
                }
                else if (ch == bracket) {
                    depth +=1;
                }
                column += 1;
            }
            row +=1;
            if (row >= lineCount) break;

            var line = this.getLine(row);
            var column = 0;
        }
        return null;
    };

    this.insert = function(position, text) {
        return this.doc.insert(position, text);
    };

    this.remove = function(range) {
        return this.doc.remove(range);
    };

    this.undoChanges = function(deltas, dontSelect) {
        if (!deltas.length)
            return;

        this.$fromUndo = true;
        var lastUndoRange = null;
        for (var i = deltas.length - 1; i != -1; i--) {
            delta = deltas[i];
            if (delta.group == "doc") {
                this.doc.revertDeltas(delta.deltas);
                lastUndoRange =
                    this.$getUndoSelection(delta.deltas, true, lastUndoRange);
            } else {
                delta.deltas.forEach(function(foldDelta) {
                    this.addFolds(foldDelta.folds);
                }, this);
            }
        }
        this.$fromUndo = false;
        lastUndoRange &&
            !dontSelect &&
            this.selection.setSelectionRange(lastUndoRange);
        return lastUndoRange;
    },

    this.redoChanges = function(deltas, dontSelect) {
        if (!deltas.length)
            return;

        this.$fromUndo = true;
        var lastUndoRange = null;
        for (var i = 0; i < deltas.length; i++) {
            delta = deltas[i];
            if (delta.group == "doc") {
                this.doc.applyDeltas(delta.deltas);
                lastUndoRange =
                    this.$getUndoSelection(delta.deltas, false, lastUndoRange);
            }
        }
        this.$fromUndo = false;
        lastUndoRange &&
            !dontSelect &&
            this.selection.setSelectionRange(lastUndoRange);
        return lastUndoRange;
    },

    this.$getUndoSelection = function(deltas, isUndo, lastUndoRange) {
        function isInsert(delta) {
            var insert =
                delta.action == "insertText" || delta.action == "insertLines";
            return isUndo ? !insert : insert;
        }

        var delta = deltas[0];
        var range, point;
        var lastDeltaIsInsert = false;
        if (isInsert(delta)) {
            range = delta.range.clone();
            lastDeltaIsInsert = true;
        } else {
            range = Range.fromPoints(delta.range.start, delta.range.start);
            lastDeltaIsInsert = false;
        }

        for (var i = 1; i < deltas.length; i++) {
            delta = deltas[i];
            if (isInsert(delta)) {
                point = delta.range.start;
                if (range.compare(point.row, point.column) == -1) {
                    range.setStart(delta.range.start);
                }
                point = delta.range.end;
                if (range.compare(point.row, point.column) == 1) {
                    range.setEnd(delta.range.end);
                }
                lastDeltaIsInsert = true;
            } else {
                point = delta.range.start;
                if (range.compare(point.row, point.column) == -1) {
                    range =
                        Range.fromPoints(delta.range.start, delta.range.start);
                }
                lastDeltaIsInsert = false;
            }
        }

        // Check if this range and the last undo range has something in common.
        // If true, merge the ranges.
        if (lastUndoRange != null) {
            var cmp = lastUndoRange.compareRange(range);
            if (cmp == 1) {
                range.setStart(lastUndoRange.start);
            } else if (cmp == -1) {
                range.setEnd(lastUndoRange.end);
            }
        }

        return range;
    },

    this.replace = function(range, text) {
        return this.doc.replace(range, text);
    };

    /**
     * Move a range of text from the given range to the given position.
     *
     * @param fromRange {Range} The range of text you want moved within the
     * document.
     * @param toPosition {Object} The location (row and column) where you want
     * to move the text to.
     * @return {Range} The new range where the text was moved to.
     */
    this.moveText = function(fromRange, toPosition) {
        var text = this.getTextRange(fromRange);
        this.remove(fromRange);

        var toRow = toPosition.row;
        var toColumn = toPosition.column;

        // Make sure to update the insert location, when text is removed in
        // front of the chosen point of insertion.
        if (!fromRange.isMultiLine() && fromRange.start.row == toRow &&
            fromRange.end.column < toColumn)
            toColumn -= text.length;

        if (fromRange.isMultiLine() && fromRange.end.row < toRow) {
            var lines = this.doc.$split(text);
            toRow -= lines.length - 1;
        }

        var endRow = toRow + fromRange.end.row - fromRange.start.row;
        var endColumn = fromRange.isMultiLine() ?
                        fromRange.end.column :
                        toColumn + fromRange.end.column - fromRange.start.column;

        var toRange = new Range(toRow, toColumn, endRow, endColumn);

        this.insert(toRange.start, text);

        return toRange;
    };

    this.indentRows = function(startRow, endRow, indentString) {
        indentString = indentString.replace(/\t/g, this.getTabString());
        for (var row=startRow; row<=endRow; row++) {
            this.insert({row: row, column:0}, indentString);
        }
    };

    this.outdentRows = function (range) {
        var rowRange = range.collapseRows();
        var deleteRange = new Range(0, 0, 0, 0);
        var size = this.getTabSize();

        for (var i = rowRange.start.row; i <= rowRange.end.row; ++i) {
            var line = this.getLine(i);

            deleteRange.start.row = i;
            deleteRange.end.row = i;
            for (var j = 0; j < size; ++j)
                if (line.charAt(j) != ' ')
                    break;
            if (j < size && line.charAt(j) == '\t') {
                deleteRange.start.column = j;
                deleteRange.end.column = j + 1;
            } else {
                deleteRange.start.column = 0;
                deleteRange.end.column = j;
            }
            this.remove(deleteRange);
        }
    };

    this.moveLinesUp = function(firstRow, lastRow) {
        if (firstRow <= 0) return 0;

        var removed = this.doc.removeLines(firstRow, lastRow);
        this.doc.insertLines(firstRow - 1, removed);
        return -1;
    };

    this.moveLinesDown = function(firstRow, lastRow) {
        if (lastRow >= this.doc.getLength()-1) return 0;

        var removed = this.doc.removeLines(firstRow, lastRow);
        this.doc.insertLines(firstRow+1, removed);
        return 1;
    };

    this.duplicateLines = function(firstRow, lastRow) {
        var firstRow = this.$clipRowToDocument(firstRow);
        var lastRow = this.$clipRowToDocument(lastRow);

        var lines = this.getLines(firstRow, lastRow);
        this.doc.insertLines(firstRow, lines);

        var addedRows = lastRow - firstRow + 1;
        return addedRows;
    };

    this.$clipRowToDocument = function(row) {
        return Math.max(0, Math.min(row, this.doc.getLength()-1));
    };

    // WRAPMODE
    this.$wrapLimit = 80;
    this.$useWrapMode = false;
    this.$wrapLimitRange = {
        min : null,
        max : null
    };

    this.setUseWrapMode = function(useWrapMode) {
        if (useWrapMode != this.$useWrapMode) {
            this.$useWrapMode = useWrapMode;
            this.$modified = true;
            this.$resetRowCache(0);

            // If wrapMode is activaed, the wrapData array has to be initialized.
            if (useWrapMode) {
                var len = this.getLength();
                this.$wrapData = [];
                for (i = 0; i < len; i++) {
                    this.$wrapData.push([]);
                }
                this.$updateWrapData(0, len - 1);
            }

            this._dispatchEvent("changeWrapMode");
        }
    };

    this.getUseWrapMode = function() {
        return this.$useWrapMode;
    };

    // Allow the wrap limit to move freely between min and max. Either
    // parameter can be null to allow the wrap limit to be unconstrained
    // in that direction. Or set both parameters to the same number to pin
    // the limit to that value.
    this.setWrapLimitRange = function(min, max) {
        if (this.$wrapLimitRange.min !== min || this.$wrapLimitRange.max !== max) {
            this.$wrapLimitRange.min = min;
            this.$wrapLimitRange.max = max;
            this.$modified = true;
            // This will force a recalculation of the wrap limit
            this._dispatchEvent("changeWrapMode");
        }
    };

    // This should generally only be called by the renderer when a resize
    // is detected.
    this.adjustWrapLimit = function(desiredLimit) {
        var wrapLimit = this.$constrainWrapLimit(desiredLimit);
        if (wrapLimit != this.$wrapLimit && wrapLimit > 0) {
            this.$wrapLimit = wrapLimit;
            this.$modified = true;
            if (this.$useWrapMode) {
                this.$updateWrapData(0, this.getLength() - 1);
                this.$resetRowCache(0)
                this._dispatchEvent("changeWrapLimit");
            }
            return true;
        }
        return false;
    };

    this.$constrainWrapLimit = function(wrapLimit) {
        var min = this.$wrapLimitRange.min;
        if (min)
            wrapLimit = Math.max(min, wrapLimit);

        var max = this.$wrapLimitRange.max;
        if (max)
            wrapLimit = Math.min(max, wrapLimit);

        // What would a limit of 0 even mean?
        return Math.max(1, wrapLimit);
    };

    this.getWrapLimit = function() {
        return this.$wrapLimit;
    };

    this.getWrapLimitRange = function() {
        // Avoid unexpected mutation by returning a copy
        return {
            min : this.$wrapLimitRange.min,
            max : this.$wrapLimitRange.max
        };
    };

    this.$updateInternalDataOnChange = function(e) {
        var useWrapMode = this.$useWrapMode;
        var len;
        var action = e.data.action;
        var firstRow = e.data.range.start.row,
            lastRow = e.data.range.end.row,
            start = e.data.range.start,
            end = e.data.range.end;
        var removedFolds = null;

        if (action.indexOf("Lines") != -1) {
            if (action == "insertLines") {
                lastRow = firstRow + (e.data.lines.length);
            } else {
                lastRow = firstRow;
            }
            len = e.data.lines.length;
        } else {
            len = lastRow - firstRow;
        }

        if (len != 0) {
            if (action.indexOf("remove") != -1) {
                useWrapMode && this.$wrapData.splice(firstRow, len);

                var foldLines = this.$foldData;
                removedFolds = this.getFoldsInRange(e.data.range);
                this.removeFolds(removedFolds);

                var foldLine = this.getFoldLine(end.row);
                var idx = 0;
                if (foldLine) {
                    foldLine.addRemoveChars(end.row, end.column, start.column - end.column);
                    foldLine.shiftRow(-len);

                    var foldLineBefore = this.getFoldLine(firstRow);
                    if (foldLineBefore && foldLineBefore !== foldLine) {
                        foldLineBefore.merge(foldLine);
                        foldLine = foldLineBefore;
                    }
                    idx = foldLines.indexOf(foldLine) + 1;
                }

                for (idx; idx < foldLines.length; idx++) {
                    var foldLine = foldLines[idx];
                    if (foldLine.start.row >= end.row) {
                        foldLine.shiftRow(-len);
                    }
                }

                lastRow = firstRow;
            } else {
                var args;
                if (useWrapMode) {
                    args = [firstRow, 0];
                    for (var i = 0; i < len; i++) args.push([]);
                    this.$wrapData.splice.apply(this.$wrapData, args);
                }

                // If some new line is added inside of a foldLine, then split
                // the fold line up.
                var foldLines = this.$foldData;
                var foldLine = this.getFoldLine(firstRow);
                var idx = 0;
                if (foldLine) {
                    var cmp = foldLine.range.compareInside(start.row, start.column)
                    // Inside of the foldLine range. Need to split stuff up.
                    if (cmp == 0) {
                        foldLine = foldLine.split(start.row, start.column);
                        foldLine.shiftRow(len);
                        foldLine.addRemoveChars(
                            lastRow, 0, end.column - start.column);
                    } else
                    // Infront of the foldLine but same row. Need to shift column.
                    if (cmp == -1) {
                        foldLine.addRemoveChars(firstRow, 0, end.column - start.column);
                        foldLine.shiftRow(len);
                    }
                    // Nothing to do if the insert is after the foldLine.
                    idx = foldLines.indexOf(foldLine) + 1;
                }

                for (idx; idx < foldLines.length; idx++) {
                    var foldLine = foldLines[idx];
                    if (foldLine.start.row >= firstRow) {
                        foldLine.shiftRow(len);
                    }
                }
            }
        } else {
            // Realign folds. E.g. if you add some new chars before a fold, the
            // fold should "move" to the right.
            var column;
            len = Math.abs(e.data.range.start.column - e.data.range.end.column);
            if (action.indexOf("remove") != -1) {
                // Get all the folds in the change range and remove them.
                removedFolds = this.getFoldsInRange(e.data.range);
                this.removeFolds(removedFolds);

                len = -len;
            }
            var foldLine = this.getFoldLine(firstRow);
            if (foldLine) {
                foldLine.addRemoveChars(firstRow, start.column, len);
            }
        }

        if (useWrapMode && this.$wrapData.length != this.doc.getLength()) {
            console.error("doc.getLength() and $wrapData.length have to be the same!");
        }

        useWrapMode && this.$updateWrapData(firstRow, lastRow);

        return removedFolds;
    };

    this.$updateWrapData = function(firstRow, lastRow) {
        var lines = this.doc.getAllLines();
        var tabSize = this.getTabSize();
        var wrapData = this.$wrapData;
        var wrapLimit = this.$wrapLimit;
        var tokens;
        var foldLine;

        var row = firstRow;
        lastRow = Math.min(lastRow, lines.length - 1);
        while (row <= lastRow) {
            foldLine = this.getFoldLine(row);
            if (!foldLine) {
                tokens = this.$getDisplayTokens(lang.stringTrimRight(lines[row]));
            } else {
                tokens = [];
                foldLine.walk(
                    function(placeholder, row, column, lastColumn) {
                        var walkTokens;
                        if (placeholder) {
                            walkTokens = this.$getDisplayTokens(
                                            placeholder, tokens.length);
                            walkTokens[0] = PLACEHOLDER_START;
                            for (var i = 1; i < walkTokens.length; i++) {
                                walkTokens[i] = PLACEHOLDER_BODY;
                            }
                        } else {
                            walkTokens = this.$getDisplayTokens(
                                lines[row].substring(lastColumn, column),
                                tokens.length);
                        }
                        tokens = tokens.concat(walkTokens);
                    }.bind(this),
                    foldLine.end.row,
                    lines[foldLine.end.row].length + 1
                );
                // Remove spaces/tabs from the back of the token array.
                while (tokens.length != 0
                    && tokens[tokens.length - 1] >= SPACE)
                {
                    tokens.pop();
                }
            }
            wrapData[row] =
                this.$computeWrapSplits(tokens, wrapLimit, tabSize);

            row = this.getRowFoldEnd(row) + 1;
        }
    };

    // "Tokens"
    var CHAR = 1,
        CHAR_EXT = 2,
        PLACEHOLDER_START = 3,
        PLACEHOLDER_BODY =  4,
        SPACE = 10,
        TAB = 11,
        TAB_SPACE = 12;

    this.$computeWrapSplits = function(tokens, wrapLimit, tabSize) {
        if (tokens.length == 0) {
            return [];
        }

        var tabSize = this.getTabSize();
        var splits = [];
        var displayLength = tokens.length;
        var lastSplit = 0, lastDocSplit = 0;

        function addSplit(screenPos) {
            var displayed = tokens.slice(lastSplit, screenPos);

            // The document size is the current size - the extra width for tabs
            // and multipleWidth characters.
            var len = displayed.length;
            displayed.join("").
                // Get all the TAB_SPACEs.
                replace(/12/g, function(m) {
                    len -= 1;
                }).
                // Get all the CHAR_EXT/multipleWidth characters.
                replace(/2/g, function(m) {
                    len -= 1;
                });

            lastDocSplit += len;
            splits.push(lastDocSplit);
            lastSplit = screenPos;
        }

        while (displayLength - lastSplit > wrapLimit) {
            // This is, where the split should be.
            var split = lastSplit + wrapLimit;

            // If there is a space or tab at this split position, then making
            // a split is simple.
            if (tokens[split] >= SPACE) {
                // Include all following spaces + tabs in this split as well.
                while (tokens[split] >= SPACE)  {
                    split ++;
                }
                addSplit(split);
                continue;
            }

            // === ELSE ===
            // Check if split is inside of a placeholder. Placeholder are
            // not splitable. Therefore, seek the beginning of the placeholder
            // and try to place the split beofre the placeholder's start.
            if (tokens[split] == PLACEHOLDER_START
                || tokens[split] == PLACEHOLDER_BODY)
            {
                // Seek the start of the placeholder and do the split
                // before the placeholder. By definition there always
                // a PLACEHOLDER_START between split and lastSplit.
                for (split; split != lastSplit - 1; split--) {
                    if (tokens[split] == PLACEHOLDER_START) {
                        // split++; << No incremental here as we want to
                        //  have the position before the Placeholder.
                        break;
                    }
                }

                // If the PLACEHOLDER_START is not the index of the
                // last split, then we can do the split
                if (split > lastSplit) {
                    addSplit(split);
                    continue;
                }

                // If the PLACEHOLDER_START IS the index of the last
                // split, then we have to place the split after the
                // placeholder. So, let's seek for the end of the placeholder.
                split = lastSplit + wrapLimit;
                for (split; split < tokens.length; split++) {
                    if (tokens[split] != PLACEHOLDER_BODY)
                    {
                        break;
                    }
                }

                // If spilt == tokens.length, then the placeholder is the last
                // thing in the line and adding a new split doesn't make sense.
                if (split == tokens.length) {
                    break;  // Breaks the while-loop.
                }

                // Finally, add the split...
                addSplit(split);
                continue;
            }

            // === ELSE ===
            // Search for the first non space/tab/placeholder token backwards.
            for (split; split != lastSplit - 1; split--) {
                if (tokens[split] >= PLACEHOLDER_START) {
                    split++;
                    break;
                }
            }
            // If we found one, then add the split.
            if (split > lastSplit) {
                addSplit(split);
                continue;
            }

            // === ELSE ===
            split = lastSplit + wrapLimit;
            // The split is inside of a CHAR or CHAR_EXT token and no space
            // around -> force a split.
            addSplit(lastSplit + wrapLimit);
        }
        return splits;
    }

    /**
     * @param
     *   offset: The offset in screenColumn at which position str starts.
     *           Important for calculating the realTabSize.
     */
    this.$getDisplayTokens = function(str, offset) {
        var arr = [];
        var tabSize;
        offset = offset || 0;

        for (var i = 0; i < str.length; i++) {
            var c = str.charCodeAt(i);
            // Tab
            if (c == 9) {
                tabSize = this.getScreenTabSize(arr.length + offset);
                arr.push(TAB);
                for (var n = 1; n < tabSize; n++) {
                    arr.push(TAB_SPACE);
                }
            }
            // Space
            else if(c == 32) {
                arr.push(SPACE);
            }
            // full width characters
            else if (isFullWidth(c)) {
                arr.push(CHAR, CHAR_EXT);
            } else {
                arr.push(CHAR);
            }
        }
        return arr;
    }

    /**
     * Calculates the width of the a string on the screen while assuming that
     * the string starts at the first column on the screen.
     *
     * @param string str String to calculate the screen width of
     * @return array
     *      [0]: number of columns for str on screen.
     *      [1]: docColumn position that was read until (useful with screenColumn)
     */
    this.$getStringScreenWidth = function(str, maxScreenColumn, screenColumn) {
        if (maxScreenColumn == 0) {
            return [0, 0];
        }
        if (maxScreenColumn == null) {
            maxScreenColumn = screenColumn +
                str.length * Math.max(this.getTabSize(), 2);
        }
        screenColumn = screenColumn || 0;

        var c, column;
        for (column = 0; column < str.length; column++) {
            c = str.charCodeAt(column);
            // tab
            if (c == 9) {
                screenColumn += this.getScreenTabSize(screenColumn);
            }
            // full width characters
            else if (isFullWidth(c)) {
                screenColumn += 2;
            } else {
                screenColumn += 1;
            }
            if (screenColumn > maxScreenColumn) {
                break
            }
        }

        return [screenColumn, column];
    }

    this.getRowLength = function(row) {
        if (!this.$useWrapMode || !this.$wrapData[row]) {
            return 1;
        } else {
            return this.$wrapData[row].length + 1;
        }
    }

    this.getRowHeight = function(config, row) {
        return this.getRowLength(row) * config.lineHeight;
    }

    this.getScreenLastRowColumn = function(screenRow) {
        // Note: This won't work if someone has more then
        // 1.7976931348623158e+307 characters in one row. But I think we can
        // live with this limitation ;)
        return this.screenToDocumentColumn(screenRow, Number.MAX_VALUE / 10)
    };

    this.getDocumentLastRowColumn = function(docRow, docColumn) {
        var screenRow = this.documentToScreenRow(docRow, docColumn);
        return this.getScreenLastRowColumn(screenRow);
    };

    this.getDocumentLastRowColumnPosition = function(docRow, docColumn) {
        var screenRow = this.documentToScreenRow(docRow, docColumn);
        return this.screenToDocumentPosition(screenRow, Number.MAX_VALUE / 10);
    };

    this.getRowSplitData = function(row) {
        if (!this.$useWrapMode) {
            return undefined;
        } else {
            return this.$wrapData[row];
        }
    };

    /**
     * Returns the width of a tab character at screenColumn.
     */
    this.getScreenTabSize = function(screenColumn) {
        return this.$tabSize - screenColumn % this.$tabSize;
    };

    this.screenToDocumentRow = function(screenRow, screenColumn) {
        return this.screenToDocumentPosition(screenRow, screenColumn).row;
    };

    this.screenToDocumentColumn = function(screenRow, screenColumn) {
        return this.screenToDocumentPosition(screenRow, screenColumn).column;
    };

    this.screenToDocumentPosition = function(screenRow, screenColumn) {
        var line;
        var docRow = 0;
        var docColumn = 0;
        var column;
        var foldLineRowLength;
        var row = 0;
        var rowLength = 0;
        var splits = null;

        var rowCache = this.$rowCache;
        var doCache = !rowCache.length;
        for (var i = 0; i < rowCache.length; i++) {
            if (rowCache[i].screenRow < screenRow) {
                row = rowCache[i].screenRow;
                docRow = rowCache[i].docRow;
                doCache = i == rowCache.length - 1;
            }
        }
        var docRowCacheLast = docRow;
        // clamp row before clamping column, for selection on last line
        var maxRow = this.getLength() - 1;

        var foldLine = this.getNextFold(docRow);
        var foldStart = foldLine ?foldLine.start.row :Infinity;

        while (row <= screenRow) {
            if (doCache
                && docRow - docRowCacheLast > this.$rowCacheSize) {
                rowCache.push({
                    docRow: docRow,
                    screenRow: row
                });
                docRowCacheLast = docRow;
            }
            rowLength = this.getRowLength(docRow);
            if (row + rowLength - 1 >= screenRow || docRow >= maxRow) {
                break;
            } else {
                row += rowLength;
                docRow++;
                if(docRow > foldStart) {
                    docRow = foldLine.end.row+1;
                    foldLine = this.getNextFold(docRow);
                    foldStart = foldLine ?foldLine.start.row :Infinity;
                }
            }
        }

        if (foldLine && foldLine.start.row <= docRow)
            line = this.getFoldDisplayLine(foldLine);
        else {
            line = this.getLine(docRow);
            foldLine = null;
        }

        if (this.$useWrapMode) {
            splits = this.$wrapData[docRow];
            if (splits) {
                column = splits[screenRow - row]
                if(screenRow > row && splits.length) {
                    docColumn = splits[screenRow - row - 1] || splits[splits.length - 1];
                    line = line.substring(docColumn);
                }
            }
        }

        docColumn += this.$getStringScreenWidth(line, screenColumn)[1];

        // Need to do some clamping action here.
        if (this.$useWrapMode) {
            if (docColumn >= column) {
                // We remove one character at the end such that the docColumn
                // position returned is not associated to the next row on the
                // screen.
                docColumn = column - 1;
            }
        } else {
            docColumn = Math.min(docColumn, line.length);
        }

        if (foldLine) {
            return foldLine.idxToPosition(docColumn);
        }

        return {
            row: docRow,
            column: docColumn
        }
    };

    this.documentToScreenPosition = function(docRow, docColumn) {
        // Normalize the passed in arguments.
        if (docColumn == null) {
            docColumn = docRow.column;
            docRow = docRow.row;
        }

        var wrapData;
        // Special case in wrapMode if the doc is at the end of the document.
        if (this.$useWrapMode) {
            wrapData = this.$wrapData;
            if (docRow > wrapData.length - 1) {
                return {
                    row: this.getScreenLength(),
                    column: wrapData.length == 0
                        ? 0
                        : (wrapData[wrapData.length - 1].length - 1)
                };
            }
        }

        var screenRow = 0;
        var screenColumn = 0;
        var foldStartRow = null;
        var fold = null;

        // Clamp the docRow position in case it's inside of a folded block.
        fold = this.getFoldAt(docRow, docColumn, 1);
        if (fold) {
            docRow = fold.start.row;
            docColumn = fold.start.column;
        }

        var rowEnd, row = 0;
        var rowCache = this.$rowCache;
        //
        var doCache = !rowCache.length;
        for (var i = 0; i < rowCache.length; i++) {
            if (rowCache[i].docRow < docRow) {
                screenRow = rowCache[i].screenRow;
                row = rowCache[i].docRow;
                doCache = i == rowCache.length - 1;
            }
        }
        var docRowCacheLast = row;

        var foldLine = this.getNextFold(row);
        var foldStart = foldLine ?foldLine.start.row :Infinity;

        while (row < docRow) {
            if (row >= foldStart) {
                rowEnd = foldLine.end.row + 1;
                if (rowEnd > docRow)
                    break;
                foldLine = this.getNextFold(rowEnd);
                foldStart = foldLine ?foldLine.start.row :Infinity;
            } else {
                rowEnd = row + 1;
            }
            if (doCache
                && row - docRowCacheLast > this.$rowCacheSize) {
                rowCache.push({
                    docRow: row,
                    screenRow: screenRow
                });
                docRowCacheLast = row;
            }

            screenRow += this.getRowLength(row);
            row = rowEnd;
        }

        // Calculate the text line that is displayed in docRow on the screen.
        var textLine = "";
        // Check if the final row we want to reach is inside of a fold.
        if (foldLine && row >= foldStart) {
            textLine = this.getFoldDisplayLine(foldLine, docRow, docColumn);
            foldStartRow = foldLine.start.row;
        } else {
            textLine = this.getLine(docRow).substring(0, docColumn);
            foldStartRow = docRow;
        }
        // Clamp textLine if in wrapMode.
        if (this.$useWrapMode) {
            var wrapRow = wrapData[foldStartRow];
            var screenRowOffset = 0;
            while (textLine.length >= wrapRow[screenRowOffset]) {
                screenRow ++;
                screenRowOffset++;
            }
            textLine = textLine.substring(
                wrapRow[screenRowOffset - 1] || 0,  textLine.length);
        }

        return {
            row: screenRow,
            column: this.$getStringScreenWidth(textLine)[0]
        };
    };

    this.documentToScreenColumn = function(row, docColumn) {
        return this.documentToScreenPosition(row, docColumn).column;
    };

    this.documentToScreenRow = function(docRow, docColumn) {
        return this.documentToScreenPosition(docRow, docColumn).row;
    };

    this.getScreenLength = function() {
        var screenRows = 0;
        var lastFoldLine = null;
        var foldLine = null;
        if (!this.$useWrapMode) {
            screenRows = this.getLength();

            // Remove the folded lines again.
            var foldData = this.$foldData;
            for (var i = 0; i < foldData.length; i++) {
                foldLine = foldData[i];
                screenRows -= foldLine.end.row - foldLine.start.row;
            }
        } else {
            for (var row = 0; row < this.$wrapData.length; row++) {
                if (foldLine = this.getFoldLine(row, lastFoldLine)) {
                    row = foldLine.end.row;
                    screenRows += 1;
                } else {
                    screenRows += this.$wrapData[row].length + 1;
                }
            }
        }

        return screenRows;
    }

    // For every keystroke this gets called once per char in the whole doc!!
    // Wouldn't hurt to make it a bit faster for c >= 0x1100
    function isFullWidth(c) {
        if (c < 0x1100)
            return false;
        return c >= 0x1100 && c <= 0x115F ||
               c >= 0x11A3 && c <= 0x11A7 ||
               c >= 0x11FA && c <= 0x11FF ||
               c >= 0x2329 && c <= 0x232A ||
               c >= 0x2E80 && c <= 0x2E99 ||
               c >= 0x2E9B && c <= 0x2EF3 ||
               c >= 0x2F00 && c <= 0x2FD5 ||
               c >= 0x2FF0 && c <= 0x2FFB ||
               c >= 0x3000 && c <= 0x303E ||
               c >= 0x3041 && c <= 0x3096 ||
               c >= 0x3099 && c <= 0x30FF ||
               c >= 0x3105 && c <= 0x312D ||
               c >= 0x3131 && c <= 0x318E ||
               c >= 0x3190 && c <= 0x31BA ||
               c >= 0x31C0 && c <= 0x31E3 ||
               c >= 0x31F0 && c <= 0x321E ||
               c >= 0x3220 && c <= 0x3247 ||
               c >= 0x3250 && c <= 0x32FE ||
               c >= 0x3300 && c <= 0x4DBF ||
               c >= 0x4E00 && c <= 0xA48C ||
               c >= 0xA490 && c <= 0xA4C6 ||
               c >= 0xA960 && c <= 0xA97C ||
               c >= 0xAC00 && c <= 0xD7A3 ||
               c >= 0xD7B0 && c <= 0xD7C6 ||
               c >= 0xD7CB && c <= 0xD7FB ||
               c >= 0xF900 && c <= 0xFAFF ||
               c >= 0xFE10 && c <= 0xFE19 ||
               c >= 0xFE30 && c <= 0xFE52 ||
               c >= 0xFE54 && c <= 0xFE66 ||
               c >= 0xFE68 && c <= 0xFE6B ||
               c >= 0xFF01 && c <= 0xFF60 ||
               c >= 0xFFE0 && c <= 0xFFE6;
    };

}).call(EditSession.prototype);

require("ace/edit_session/folding").Folding.call(EditSession.prototype);

exports.EditSession = EditSession;
});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *      Julian Viereck <julian.viereck@gmail.com>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('ace/selection', ['require', 'exports', 'module' , 'pilot/oop', 'pilot/lang', 'pilot/event_emitter', 'ace/range'], function(require, exports, module) {

var oop = require("pilot/oop");
var lang = require("pilot/lang");
var EventEmitter = require("pilot/event_emitter").EventEmitter;
var Range = require("ace/range").Range;

var Selection = function(session) {
    this.session = session;
    this.doc = session.getDocument();

    this.clearSelection();
    this.selectionLead = this.doc.createAnchor(0, 0);
    this.selectionAnchor = this.doc.createAnchor(0, 0);

    var _self = this;
    this.selectionLead.on("change", function(e) {
        _self._dispatchEvent("changeCursor");
        if (!_self.$isEmpty)
            _self._dispatchEvent("changeSelection");
        if (e.old.row == e.value.row)
            _self.$updateDesiredColumn();
    });

    this.selectionAnchor.on("change", function() {
        if (!_self.$isEmpty)
            _self._dispatchEvent("changeSelection");
    });
};

(function() {

    oop.implement(this, EventEmitter);

    this.isEmpty = function() {
        return (this.$isEmpty || (
            this.selectionAnchor.row == this.selectionLead.row &&
            this.selectionAnchor.column == this.selectionLead.column
        ));
    };

    this.isMultiLine = function() {
        if (this.isEmpty()) {
            return false;
        }

        return this.getRange().isMultiLine();
    };

    this.getCursor = function() {
        return this.selectionLead.getPosition();
    };

    this.setSelectionAnchor = function(row, column) {
        this.selectionAnchor.setPosition(row, column);

        if (this.$isEmpty) {
            this.$isEmpty = false;
            this._dispatchEvent("changeSelection");
        }
    };

    this.getSelectionAnchor = function() {
        if (this.$isEmpty)
            return this.getSelectionLead()
        else
            return this.selectionAnchor.getPosition();
    };

    this.getSelectionLead = function() {
        return this.selectionLead.getPosition();
    };

    this.shiftSelection = function(columns) {
        if (this.$isEmpty) {
            this.moveCursorTo(this.selectionLead.row, this.selectionLead.column + columns);
            return;
        };

        var anchor = this.getSelectionAnchor();
        var lead = this.getSelectionLead();

        var isBackwards = this.isBackwards();

        if (!isBackwards || anchor.column !== 0)
            this.setSelectionAnchor(anchor.row, anchor.column + columns);

        if (isBackwards || lead.column !== 0) {
            this.$moveSelection(function() {
                this.moveCursorTo(lead.row, lead.column + columns);
            });
        }
    };

    this.isBackwards = function() {
        var anchor = this.selectionAnchor;
        var lead = this.selectionLead;
        return (anchor.row > lead.row || (anchor.row == lead.row && anchor.column > lead.column));
    };

    this.getRange = function() {
        var anchor = this.selectionAnchor;
        var lead = this.selectionLead;

        if (this.isEmpty())
            return Range.fromPoints(lead, lead);

        if (this.isBackwards()) {
            return Range.fromPoints(lead, anchor);
        }
        else {
            return Range.fromPoints(anchor, lead);
        }
    };

    this.clearSelection = function() {
        if (!this.$isEmpty) {
            this.$isEmpty = true;
            this._dispatchEvent("changeSelection");
        }
    };

    this.selectAll = function() {
        var lastRow = this.doc.getLength() - 1;
        this.setSelectionAnchor(lastRow, this.doc.getLine(lastRow).length);
        this.moveCursorTo(0, 0);
    };

    this.setSelectionRange = function(range, reverse) {
        if (reverse) {
            this.setSelectionAnchor(range.end.row, range.end.column);
            this.selectTo(range.start.row, range.start.column);
        } else {
            this.setSelectionAnchor(range.start.row, range.start.column);
            this.selectTo(range.end.row, range.end.column);
        }
        this.$updateDesiredColumn();
    };

    this.$updateDesiredColumn = function() {
        var cursor = this.getCursor();
        this.$desiredColumn = this.session.documentToScreenColumn(cursor.row, cursor.column);
    };

    this.$moveSelection = function(mover) {
        var lead = this.selectionLead;
        if (this.$isEmpty)
            this.setSelectionAnchor(lead.row, lead.column);

        mover.call(this);
    };

    this.selectTo = function(row, column) {
        this.$moveSelection(function() {
            this.moveCursorTo(row, column);
        });
    };

    this.selectToPosition = function(pos) {
        this.$moveSelection(function() {
            this.moveCursorToPosition(pos);
        });
    };

    this.selectUp = function() {
        this.$moveSelection(this.moveCursorUp);
    };

    this.selectDown = function() {
        this.$moveSelection(this.moveCursorDown);
    };

    this.selectRight = function() {
        this.$moveSelection(this.moveCursorRight);
    };

    this.selectLeft = function() {
        this.$moveSelection(this.moveCursorLeft);
    };

    this.selectLineStart = function() {
        this.$moveSelection(this.moveCursorLineStart);
    };

    this.selectLineEnd = function() {
        this.$moveSelection(this.moveCursorLineEnd);
    };

    this.selectFileEnd = function() {
        this.$moveSelection(this.moveCursorFileEnd);
    };

    this.selectFileStart = function() {
        this.$moveSelection(this.moveCursorFileStart);
    };

    this.selectWordRight = function() {
        this.$moveSelection(this.moveCursorWordRight);
    };

    this.selectWordLeft = function() {
        this.$moveSelection(this.moveCursorWordLeft);
    };

    this.selectWord = function() {
        var cursor = this.getCursor();
        var range  = this.session.getWordRange(cursor.row, cursor.column);
        this.setSelectionRange(range);
    };

    this.selectLine = function() {
        var rowStart = this.selectionLead.row;
        var rowEnd;

        var foldLine = this.session.getFoldLine(rowStart);
        if (foldLine) {
            rowStart = foldLine.start.row;
            rowEnd = foldLine.end.row;
        } else {
            rowEnd = rowStart;
        }
        this.setSelectionAnchor(rowStart, 0);
        this.$moveSelection(function() {
            this.moveCursorTo(rowEnd + 1, 0);
        });
    };

    this.moveCursorUp = function() {
        this.moveCursorBy(-1, 0);
    };

    this.moveCursorDown = function() {
        this.moveCursorBy(1, 0);
    };

    this.moveCursorLeft = function() {
        var cursor = this.selectionLead.getPosition(),
            fold;

        if (fold = this.session.getFoldAt(cursor.row, cursor.column, -1)) {
            this.moveCursorTo(fold.start.row, fold.start.column);
        } else if (cursor.column == 0) {
            // cursor is a line (start
            if (cursor.row > 0) {
                this.moveCursorTo(cursor.row - 1, this.doc.getLine(cursor.row - 1).length);
            }
        }
        else {
            var tabSize = this.session.getTabSize();
            if (this.session.isTabStop(cursor) && this.doc.getLine(cursor.row).slice(cursor.column-tabSize, cursor.column).split(" ").length-1 == tabSize)
                this.moveCursorBy(0, -tabSize);
            else
                this.moveCursorBy(0, -1);
        }
    };

    this.moveCursorRight = function() {
        var cursor = this.selectionLead.getPosition(),
            fold;
        if (fold = this.session.getFoldAt(cursor.row, cursor.column, 1)) {
            this.moveCursorTo(fold.end.row, fold.end.column);
        } else if (this.selectionLead.column == this.doc.getLine(this.selectionLead.row).length) {
            if (this.selectionLead.row < this.doc.getLength() - 1) {
                this.moveCursorTo(this.selectionLead.row + 1, 0);
            }
        }
        else {
            var tabSize = this.session.getTabSize();
            var cursor = this.selectionLead;
            if (this.session.isTabStop(cursor) && this.doc.getLine(cursor.row).slice(cursor.column, cursor.column+tabSize).split(" ").length-1 == tabSize)
                this.moveCursorBy(0, tabSize);
            else
                this.moveCursorBy(0, 1);
        }
    };

    this.moveCursorLineStart = function() {
        var row = this.selectionLead.row;
        var column = this.selectionLead.column;
        var screenRow = this.session.documentToScreenRow(row, column);

        // Determ the doc-position of the first character at the screen line.
        var firstColumnPosition =
            this.session.screenToDocumentPosition(screenRow, 0);

        // Determ the string "before" the cursor.
        var beforeCursor = this.session.getDisplayLine(
                row, column,
                firstColumnPosition.row, firstColumnPosition.column);

        //
        var leadingSpace = beforeCursor.match(/^\s*/);
        if (leadingSpace[0].length == 0
            || leadingSpace[0].length >= column - firstColumnPosition.column)
        {
            this.moveCursorTo(
                firstColumnPosition.row, firstColumnPosition.column);
        } else {
            this.moveCursorTo(
                firstColumnPosition.row,
                firstColumnPosition.column + leadingSpace[0].length);
        }
    };

    this.moveCursorLineEnd = function() {
        var lead = this.selectionLead;
        var lastRowColumnPosition =
            this.session.getDocumentLastRowColumnPosition(lead.row, lead.column);
        this.moveCursorTo(
            lastRowColumnPosition.row,
            lastRowColumnPosition.column
        );
    };

    this.moveCursorFileEnd = function() {
        var row = this.doc.getLength() - 1;
        var column = this.doc.getLine(row).length;
        this.moveCursorTo(row, column);
    };

    this.moveCursorFileStart = function() {
        this.moveCursorTo(0, 0);
    };

    this.moveCursorWordRight = function() {
        var row = this.selectionLead.row;
        var column = this.selectionLead.column;
        var line = this.doc.getLine(row);
        var rightOfCursor = line.substring(column);

        var match;
        this.session.nonTokenRe.lastIndex = 0;
        this.session.tokenRe.lastIndex = 0;

        var fold;
        if (fold = this.session.getFoldAt(row, column, 1)) {
            this.moveCursorTo(fold.end.row, fold.end.column);
            return;
        } else if (column == line.length) {
            this.moveCursorRight();
            return;
        }
        else if (match = this.session.nonTokenRe.exec(rightOfCursor)) {
            column += this.session.nonTokenRe.lastIndex;
            this.session.nonTokenRe.lastIndex = 0;
        }
        else if (match = this.session.tokenRe.exec(rightOfCursor)) {
            column += this.session.tokenRe.lastIndex;
            this.session.tokenRe.lastIndex = 0;
        }

        this.moveCursorTo(row, column);
    };

    this.moveCursorWordLeft = function() {
        var row = this.selectionLead.row;
        var column = this.selectionLead.column;

        var fold;
        if (fold = this.session.getFoldAt(row, column, -1)) {
            this.moveCursorTo(fold.start.row, fold.start.column);
            return;
        }

        if (column == 0) {
            this.moveCursorLeft();
            return;
        }

        var str = this.session.getFoldStringAt(row, column, -1);
        if (str == null) {
            str = this.doc.getLine(row).substring(0, column)
        }
        var leftOfCursor = lang.stringReverse(str);

        var match;
        this.session.nonTokenRe.lastIndex = 0;
        this.session.tokenRe.lastIndex = 0;

        if (match = this.session.nonTokenRe.exec(leftOfCursor)) {
            column -= this.session.nonTokenRe.lastIndex;
            this.session.nonTokenRe.lastIndex = 0;
        }
        else if (match = this.session.tokenRe.exec(leftOfCursor)) {
            column -= this.session.tokenRe.lastIndex;
            this.session.tokenRe.lastIndex = 0;
        }

        this.moveCursorTo(row, column);
    };

    this.moveCursorBy = function(rows, chars) {
        var screenPos = this.session.documentToScreenPosition(
            this.selectionLead.row,
            this.selectionLead.column
        );
        var screenCol = (chars == 0 && this.$desiredColumn) || screenPos.column;
        var docPos = this.session.screenToDocumentPosition(screenPos.row + rows, screenCol);

        this.moveCursorTo(docPos.row, docPos.column + chars, chars == 0);
    };

    this.moveCursorToPosition = function(position) {
        this.moveCursorTo(position.row, position.column);
    };

    this.moveCursorTo = function(row, column, preventUpdateDesiredColumn) {
        // Ensure the row/column is not inside of a fold.
        var fold = this.session.getFoldAt(row, column, 1);
        if (fold) {
            row = fold.start.row;
            column = fold.start.column;
        }
        this.selectionLead.setPosition(row, column);
        if (!preventUpdateDesiredColumn)
            this.$updateDesiredColumn(this.selectionLead.column);
    };

    this.moveCursorToScreen = function(row, column, preventUpdateDesiredColumn) {
        var pos = this.session.screenToDocumentPosition(row, column);
        row = pos.row;
        column = pos.column;
        this.moveCursorTo(row, column, preventUpdateDesiredColumn);
    };

}).call(Selection.prototype);

exports.Selection = Selection;
});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('ace/range', ['require', 'exports', 'module' ], function(require, exports, module) {

var Range = function(startRow, startColumn, endRow, endColumn) {
    this.start = {
        row: startRow,
        column: startColumn
    };

    this.end = {
        row: endRow,
        column: endColumn
    };
};

(function() {

    this.toString = function() {
        return ("Range: [" + this.start.row + "/" + this.start.column +
            "] -> [" + this.end.row + "/" + this.end.column + "]");
    };

    this.contains = function(row, column) {
        return this.compare(row, column) == 0;
    };

    /**
     * Compares this range (A) with another range (B), where B is the passed in
     * range.
     *
     * Return values:
     *  -2: (B) is infront of (A) and doesn't intersect with (A)
     *  -1: (B) begins before (A) but ends inside of (A)
     *   0: (B) is completly inside of (A) OR (A) is complety inside of (B)
     *  +1: (B) begins inside of (A) but ends outside of (A)
     *  +2: (B) is after (A) and doesn't intersect with (A)
     *
     *  42: FTW state: (B) ends in (A) but starts outside of (A)
     */
    this.compareRange = function(range) {
        var cmp,
            end = range.end,
            start = range.start;

        cmp = this.compare(end.row, end.column);
        if (cmp == 1) {
            cmp = this.compare(start.row, start.column);
            if (cmp == 1) {
                return 2;
            } else if (cmp == 0) {
                return 1;
            } else {
                return 0;
            }
        } else if (cmp == -1) {
            return -2;
        } else {
            cmp = this.compare(start.row, start.column);
            if (cmp == -1) {
                return -1;
            } else if (cmp == 1) {
                return 42;
            } else {
                return 0;
            }
        }
    }

    this.containsRange = function(range) {
        var cmp = this.compareRange(range);
        return (cmp == -1 || cmp == 0 || cmp == 1);
    }

    this.isEnd = function(row, column) {
        return this.end.row == row && this.end.column == column;
    }

    this.isStart = function(row, column) {
        return this.start.row == row && this.start.column == column;
    }

    this.setStart = function(row, column) {
        if (typeof row == "object") {
            this.start.column = row.column;
            this.start.row = row.row;
        } else {
            this.start.row = row;
            this.start.column = column;
        }
    }

    this.setEnd = function(row, column) {
        if (typeof row == "object") {
            this.end.column = row.column;
            this.end.row = row.row;
        } else {
            this.end.row = row;
            this.end.column = column;
        }
    }

    this.inside = function(row, column) {
        if (this.compare(row, column) == 0) {
            if (this.isEnd(row, column) || this.isStart(row, column)) {
                return false;
            } else {
                return true;
            }
        }
        return false;
    }

    this.insideStart = function(row, column) {
        if (this.compare(row, column) == 0) {
            if (this.isEnd(row, column)) {
                return false;
            } else {
                return true;
            }
        }
        return false;
    }

    this.insideEnd = function(row, column) {
        if (this.compare(row, column) == 0) {
            if (this.isStart(row, column)) {
                return false;
            } else {
                return true;
            }
        }
        return false;
    }

    this.compare = function(row, column) {
        if (!this.isMultiLine()) {
            if (row === this.start.row) {
                return column < this.start.column ? -1 : (column > this.end.column ? 1 : 0);
            };
        }

        if (row < this.start.row)
            return -1;

        if (row > this.end.row)
            return 1;

        if (this.start.row === row)
            return column >= this.start.column ? 0 : -1;

        if (this.end.row === row)
            return column <= this.end.column ? 0 : 1;

        return 0;
    };

    /**
     * Like .compare(), but if isStart is true, return -1;
     */
    this.compareStart = function(row, column) {
        if (this.start.row == row && this.start.column == column) {
            return -1;
        } else {
            return this.compare(row, column);
        }
    }

    /**
     * Like .compare(), but if isEnd is true, return 1;
     */
    this.compareEnd = function(row, column) {
        if (this.end.row == row && this.end.column == column) {
            return 1;
        } else {
            return this.compare(row, column);
        }
    }

    this.compareInside = function(row, column) {
        if (this.end.row == row && this.end.column == column) {
            return 1;
        } else if (this.start.row == row && this.start.column == column) {
            return -1;
        } else {
            return this.compare(row, column);
        }
    }

    this.clipRows = function(firstRow, lastRow) {
        if (this.end.row > lastRow) {
            var end = {
                row: lastRow+1,
                column: 0
            };
        }

        if (this.start.row > lastRow) {
            var start = {
                row: lastRow+1,
                column: 0
            };
        }

        if (this.start.row < firstRow) {
            var start = {
                row: firstRow,
                column: 0
            };
        }

        if (this.end.row < firstRow) {
            var end = {
                row: firstRow,
                column: 0
            };
        }
        return Range.fromPoints(start || this.start, end || this.end);
    };

    this.extend = function(row, column) {
        var cmp = this.compare(row, column);

        if (cmp == 0)
            return this;
        else if (cmp == -1)
            var start = {row: row, column: column};
        else
            var end = {row: row, column: column};

        return Range.fromPoints(start || this.start, end || this.end);
    };

    this.isEmpty = function() {
        return (this.start.row == this.end.row && this.start.column == this.end.column);
    };

    this.isMultiLine = function() {
        return (this.start.row !== this.end.row);
    };

    this.clone = function() {
        return Range.fromPoints(this.start, this.end);
    };

    this.collapseRows = function() {
        if (this.end.column == 0)
            return new Range(this.start.row, 0, Math.max(this.start.row, this.end.row-1), 0)
        else
            return new Range(this.start.row, 0, this.end.row, 0)
    };

    this.toScreenRange = function(session) {
        var screenPosStart =
            session.documentToScreenPosition(this.start);
        var screenPosEnd =
            session.documentToScreenPosition(this.end);
        return new Range(
            screenPosStart.row, screenPosStart.column,
            screenPosEnd.row, screenPosEnd.column
        );
    };

}).call(Range.prototype);


Range.fromPoints = function(start, end) {
    return new Range(start.row, start.column, end.row, end.column);
};

exports.Range = Range;
});
/* vim:ts=4:sts=4:sw=4:
 * ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *      Mihai Sucan <mihai DOT sucan AT gmail DOT com>
 *      Chris Spencer <chris.ag.spencer AT googlemail DOT com>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('ace/mode/text', ['require', 'exports', 'module' , 'ace/tokenizer', 'ace/mode/text_highlight_rules', 'ace/mode/behaviour'], function(require, exports, module) {

var Tokenizer = require("ace/tokenizer").Tokenizer;
var TextHighlightRules = require("ace/mode/text_highlight_rules").TextHighlightRules;
var Behaviour = require("ace/mode/behaviour").Behaviour;

var Mode = function() {
    this.$tokenizer = new Tokenizer(new TextHighlightRules().getRules());
    this.$behaviour = new Behaviour();
};

(function() {

    this.getTokenizer = function() {
        return this.$tokenizer;
    };

    this.toggleCommentLines = function(state, doc, startRow, endRow) {
    };

    this.getNextLineIndent = function(state, line, tab) {
        return "";
    };

    this.checkOutdent = function(state, line, input) {
        return false;
    };

    this.autoOutdent = function(state, doc, row) {
    };

    this.$getIndent = function(line) {
        var match = line.match(/^(\s+)/);
        if (match) {
            return match[1];
        }

        return "";
    };
    
    this.createWorker = function(session) {
        return null;
    };

    this.highlightSelection = function(editor) {
        var session = editor.session;
        if (!session.$selectionOccurrences)
            session.$selectionOccurrences = [];

        if (session.$selectionOccurrences.length)
            this.clearSelectionHighlight(editor);

        var selection = editor.getSelectionRange();
        if (selection.isEmpty() || selection.isMultiLine())
            return;

        var startOuter = selection.start.column - 1;
        var endOuter = selection.end.column + 1;
        var line = session.getLine(selection.start.row);
        var lineCols = line.length;
        var needle = line.substring(Math.max(startOuter, 0),
                                    Math.min(endOuter, lineCols));

        // Make sure the outer characters are not part of the word.
        if ((startOuter >= 0 && /^[\w\d]/.test(needle)) ||
            (endOuter <= lineCols && /[\w\d]$/.test(needle)))
            return;

        needle = line.substring(selection.start.column, selection.end.column);
        if (!/^[\w\d]+$/.test(needle))
            return;

        var cursor = editor.getCursorPosition();

        var newOptions = {
            wrap: true,
            wholeWord: true,
            caseSensitive: true,
            needle: needle
        };

        var currentOptions = editor.$search.getOptions();
        editor.$search.set(newOptions);

        var ranges = editor.$search.findAll(session);
        ranges.forEach(function(range) {
            if (!range.contains(cursor.row, cursor.column)) {
                var marker = session.addMarker(range, "ace_selected_word");
                session.$selectionOccurrences.push(marker);
            }
        });

        editor.$search.set(currentOptions);
    };

    this.clearSelectionHighlight = function(editor) {
        if (!editor.session.$selectionOccurrences)
            return;

        editor.session.$selectionOccurrences.forEach(function(marker) {
            editor.session.removeMarker(marker);
        });

        editor.session.$selectionOccurrences = [];
    };
    
    this.createModeDelegates = function (mapping) {
        if (!this.$embeds) {
            return;
        }
        this.$modes = {};
        for (var i = 0; i < this.$embeds.length; i++) {
            if (mapping[this.$embeds[i]]) {
                this.$modes[this.$embeds[i]] = new mapping[this.$embeds[i]]();
            }
        }
        
        var delegations = ['toggleCommentLines', 'getNextLineIndent', 'checkOutdent', 'autoOutdent', 'transformAction'];

        for (var i = 0; i < delegations.length; i++) {
            (function(scope) {
              var functionName = delegations[i];
              var defaultHandler = scope[functionName];
              scope[delegations[i]] = function() {
                  return this.$delegator(functionName, arguments, defaultHandler);
              }
            } (this));
        }
    }
    
    this.$delegator = function(method, args, defaultHandler) {
        var state = args[0];
        
        for (var i = 0; i < this.$embeds.length; i++) {
            if (!this.$modes[this.$embeds[i]]) continue;
            
            var split = state.split(this.$embeds[i]);
            if (!split[0] && split[1]) {
                args[0] = split[1];
                var mode = this.$modes[this.$embeds[i]];
                return mode[method].apply(mode, args);
            }
        }
        var ret = defaultHandler.apply(this, args);
        return defaultHandler ? ret : undefined;
    };
    
    this.transformAction = function(state, action, editor, session, param) {
        if (this.$behaviour) {
            var behaviours = this.$behaviour.getBehaviours();
            for (var key in behaviours) {
                if (behaviours[key][action]) {
                    var ret = behaviours[key][action].apply(this, arguments);
                    if (ret !== false) {
                        return ret;
                    }
                }
            }
        }
        return false;
    }
    
}).call(Mode.prototype);

exports.Mode = Mode;
});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('ace/tokenizer', ['require', 'exports', 'module' ], function(require, exports, module) {

var Tokenizer = function(rules) {
    this.rules = rules;

    this.regExps = {};
    this.matchMappings = {};
    for ( var key in this.rules) {
        var rule = this.rules[key];
        var state = rule;
        var ruleRegExps = [];
        var matchTotal = 0;
        var mapping = this.matchMappings[key] = {};
        
        for ( var i = 0; i < state.length; i++) {
            // Count number of matching groups. 2 extra groups from the full match
            // And the catch-all on the end (used to force a match);
            var matchcount = new RegExp("(?:(" + state[i].regex + ")|(.))").exec("a").length - 2;
        
            // Replace any backreferences and offset appropriately.
            var adjustedregex = state[i].regex.replace(/\\([0-9]+)/g, function (match, digit) {
                return "\\" + (parseInt(digit, 10) + matchTotal + 1);
            });
            
            mapping[matchTotal] = {
                rule: i,
                len: matchcount
            };
            matchTotal += matchcount;
            
            ruleRegExps.push(adjustedregex);
        }

        this.regExps[key] = new RegExp("(?:(" + ruleRegExps.join(")|(") + ")|(.))", "g");
        
    }
};

(function() {

    this.getLineTokens = function(line, startState) {
        var currentState = startState;
        var state = this.rules[currentState];
        var mapping = this.matchMappings[currentState];
        var re = this.regExps[currentState];
        re.lastIndex = 0;
        
        var match, tokens = [];
        
        var lastIndex = 0;
        
        var token = {
            type: null,
            value: ""
        };
        
        while (match = re.exec(line)) {
            var type = "text";
            var value = [match[0]];

            for ( var i = 0; i < match.length-2; i++) {
                if (match[i + 1] !== undefined) {
                    var rule = state[mapping[i].rule];
                    
                    if (mapping[i].len > 1) {
                        value = match.slice(i+2, i+1+mapping[i].len);
                    }
                    
                    if (typeof rule.token == "function")
                        type = rule.token.apply(this, value);
                    else
                        type = rule.token;

                    if (rule.next && rule.next !== currentState) {
                        currentState = rule.next;
                        state = this.rules[currentState];
                        mapping = this.matchMappings[currentState];
                        lastIndex = re.lastIndex;

                        re = this.regExps[currentState];
                        re.lastIndex = lastIndex;
                    }
                    break;
                }
            };
            
            if (typeof type == "string") {
                if (typeof value != "string") {
                    value = [value.join("")];
                }
                type = [type];
            }
            
            for ( var i = 0; i < value.length; i++) {
                if (token.type !== type[i]) {
                    if (token.type) {
                        tokens.push(token);
                    }
                    
                    token = {
                        type: type[i],
                        value: value[i]
                    }
                } else {
                    token.value += value[i];
                }
            }
            
            if (lastIndex == line.length)
                break;
            
            lastIndex = re.lastIndex;
        };

        if (token.type)
            tokens.push(token);

        return {
            tokens : tokens,
            state : currentState
        };
    };

}).call(Tokenizer.prototype);

exports.Tokenizer = Tokenizer;
});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('ace/mode/text_highlight_rules', ['require', 'exports', 'module' , 'pilot/lang'], function(require, exports, module) {

var lang = require("pilot/lang");

var TextHighlightRules = function() {

    // regexp must not have capturing parentheses
    // regexps are ordered -> the first match is used

    this.$rules = {
        "start" : [ {
            token : "empty_line",
            regex : '^$'
        }, {
            token : "text",
            regex : ".+"
        } ]
    };
};

(function() {

    this.addRules = function(rules, prefix) {
        for (var key in rules) {
            var state = rules[key];
            for (var i=0; i<state.length; i++) {
                var rule = state[i];
                if (rule.next) {
                    rule.next = prefix + rule.next;
                } else {
                    rule.next = prefix + key;
                }
            }
            this.$rules[prefix + key] = state;
        }
    };

    this.getRules = function() {
        return this.$rules;
    };
    
    this.embedRules = function (HighlightRules, prefix, escapeRules, states) {
        var embedRules = new HighlightRules().getRules();
        if (states) {
            for (var i = 0; i < states.length; i++) {
                states[i] = prefix + states[i];
            }
        } else {
            states = [];
            for (var key in embedRules) {
                states.push(prefix + key);
            }
        }
        this.addRules(embedRules, prefix);
        
        for (var i = 0; i < states.length; i++) {
            Array.prototype.unshift.apply(this.$rules[states[i]], lang.deepCopy(escapeRules));
        }
        
        if (!this.$embeds) {
            this.$embeds = [];
        }
        this.$embeds.push(prefix);
    }
    
    this.getEmbeds = function() {
        return this.$embeds;
    }

}).call(TextHighlightRules.prototype);

exports.TextHighlightRules = TextHighlightRules;
});
/* vim:ts=4:sts=4:sw=4:
 * ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Chris Spencer <chris.ag.spencer AT googlemail DOT com>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('ace/mode/behaviour', ['require', 'exports', 'module' ], function(require, exports, module) {

var Behaviour = function() {
   this.$behaviours = {};
};

(function () {

    this.add = function (name, action, callback) {
        switch (undefined) {
          case this.$behaviours:
              this.$behaviours = {};
          case this.$behaviours[name]:
              this.$behaviours[name] = {};
        }
        this.$behaviours[name][action] = callback;
    }
    
    this.addBehaviours = function (behaviours) {
        for (var key in behaviours) {
            for (var action in behaviours[key]) {
                this.add(key, action, behaviours[key][action]);
            }
        }
    }
    
    this.remove = function (name) {
        if (this.$behaviours && this.$behaviours[name]) {
            delete this.$behaviours[name];
        }
    }
    
    this.inherit = function (mode, filter) {
        if (typeof mode === "function") {
            var behaviours = new mode().getBehaviours(filter);
        } else {
            var behaviours = mode.getBehaviours(filter);
        }
        this.addBehaviours(behaviours);
    }
    
    this.getBehaviours = function (filter) {
        if (!filter) {
            return this.$behaviours;
        } else {
            var ret = {}
            for (var i = 0; i < filter.length; i++) {
                if (this.$behaviours[filter[i]]) {
                    ret[filter[i]] = this.$behaviours[filter[i]];
                }
            }
            return ret;
        }
    }

}).call(Behaviour.prototype);

exports.Behaviour = Behaviour;
});/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('ace/document', ['require', 'exports', 'module' , 'pilot/oop', 'pilot/event_emitter', 'ace/range', 'ace/anchor'], function(require, exports, module) {

var oop = require("pilot/oop");
var EventEmitter = require("pilot/event_emitter").EventEmitter;
var Range = require("ace/range").Range;
var Anchor = require("ace/anchor").Anchor;

var Document = function(text) {
    this.$lines = [];

    if (Array.isArray(text)) {
        this.insertLines(0, text);
    }
    // There has to be one line at least in the document. If you pass an empty
    // string to the insert function, nothing will happen. Workaround.
    else if (text.length == 0) {
        this.$lines = [""];
    } else {
        this.insert({row: 0, column:0}, text);
    }
};

(function() {

    oop.implement(this, EventEmitter);

    this.setValue = function(text) {
        var len = this.getLength();
        this.remove(new Range(0, 0, len, this.getLine(len-1).length));
        this.insert({row: 0, column:0}, text);
    };

    this.getValue = function() {
        return this.getAllLines().join(this.getNewLineCharacter());
    };

    this.createAnchor = function(row, column) {
        return new Anchor(this, row, column);
    };

    // check for IE split bug
    if ("aaa".split(/a/).length == 0)
        this.$split = function(text) {
            return text.replace(/\r\n|\r/g, "\n").split("\n");
        }
    else
        this.$split = function(text) {
            return text.split(/\r\n|\r|\n/);
        };


    this.$detectNewLine = function(text) {
        var match = text.match(/^.*?(\r?\n)/m);
        if (match) {
            this.$autoNewLine = match[1];
        } else {
            this.$autoNewLine = "\n";
        }
    };

    this.getNewLineCharacter = function() {
      switch (this.$newLineMode) {
          case "windows":
              return "\r\n";

          case "unix":
              return "\n";

          case "auto":
              return this.$autoNewLine;
      }
    },

    this.$autoNewLine = "\n";
    this.$newLineMode = "auto";
    this.setNewLineMode = function(newLineMode) {
        if (this.$newLineMode === newLineMode) return;

        this.$newLineMode = newLineMode;
    };

    this.getNewLineMode = function() {
        return this.$newLineMode;
    };

    this.isNewLine = function(text) {
        return (text == "\r\n" || text == "\r" || text == "\n");
    };

    /**
     * Get a verbatim copy of the given line as it is in the document
     */
    this.getLine = function(row) {
        return this.$lines[row] || "";
    };

    this.getLines = function(firstRow, lastRow) {
        return this.$lines.slice(firstRow, lastRow + 1);
    };

    /**
     * Returns all lines in the document as string array. Warning: The caller
     * should not modify this array!
     */
    this.getAllLines = function() {
        return this.getLines(0, this.getLength());
    };

    this.getLength = function() {
        return this.$lines.length;
    };

    this.getTextRange = function(range) {
        if (range.start.row == range.end.row) {
            return this.$lines[range.start.row].substring(range.start.column,
                                                         range.end.column);
        }
        else {
            var lines = [];
            lines.push(this.$lines[range.start.row].substring(range.start.column));
            lines.push.apply(lines, this.getLines(range.start.row+1, range.end.row-1));
            lines.push(this.$lines[range.end.row].substring(0, range.end.column));
            return lines.join(this.getNewLineCharacter());
        }
    };

    this.$clipPosition = function(position) {
        var length = this.getLength();
        if (position.row >= length) {
            position.row = Math.max(0, length - 1);
            position.column = this.getLine(length-1).length;
        }
        return position;
    }

    this.insert = function(position, text) {
        if (text.length == 0)
            return position;

        position = this.$clipPosition(position);

        if (this.getLength() <= 1)
            this.$detectNewLine(text);

        var lines = this.$split(text);
        var firstLine = lines.splice(0, 1)[0];
        var lastLine = lines.length == 0 ? null : lines.splice(lines.length - 1, 1)[0];

        this._dispatchEvent("changeStart");
        position = this.insertInLine(position, firstLine);
        if (lastLine !== null) {
            position = this.insertNewLine(position); // terminate first line
            position = this.insertLines(position.row, lines);
            position = this.insertInLine(position, lastLine || "");
        }
        this._dispatchEvent("changeEnd");
        return position;
    };

    this.insertLines = function(row, lines) {
        if (lines.length == 0)
            return {row: row, column: 0};

        var args = [row, 0];
        args.push.apply(args, lines);
        this.$lines.splice.apply(this.$lines, args);

        this._dispatchEvent("changeStart");
        var range = new Range(row, 0, row + lines.length, 0);
        var delta = {
            action: "insertLines",
            range: range,
            lines: lines
        };
        this._dispatchEvent("change", { data: delta });
        this._dispatchEvent("changeEnd");
        return range.end;
    },

    this.insertNewLine = function(position) {
        position = this.$clipPosition(position);
        var line = this.$lines[position.row] || "";

        this._dispatchEvent("changeStart");
        this.$lines[position.row] = line.substring(0, position.column);
        this.$lines.splice(position.row + 1, 0, line.substring(position.column, line.length));

        var end = {
            row : position.row + 1,
            column : 0
        };

        var delta = {
            action: "insertText",
            range: Range.fromPoints(position, end),
            text: this.getNewLineCharacter()
        };
        this._dispatchEvent("change", { data: delta });
        this._dispatchEvent("changeEnd");

        return end;
    };

    this.insertInLine = function(position, text) {
        if (text.length == 0)
            return position;

        var line = this.$lines[position.row] || "";

        this._dispatchEvent("changeStart");
        this.$lines[position.row] = line.substring(0, position.column) + text
                + line.substring(position.column);

        var end = {
            row : position.row,
            column : position.column + text.length
        };

        var delta = {
            action: "insertText",
            range: Range.fromPoints(position, end),
            text: text
        };
        this._dispatchEvent("change", { data: delta });
        this._dispatchEvent("changeEnd");

        return end;
    };

    this.remove = function(range) {
        // clip to document
        range.start = this.$clipPosition(range.start);
        range.end = this.$clipPosition(range.end);

        if (range.isEmpty())
            return range.start;

        var firstRow = range.start.row;
        var lastRow = range.end.row;

        this._dispatchEvent("changeStart");
        if (range.isMultiLine()) {
            var firstFullRow = range.start.column == 0 ? firstRow : firstRow + 1;
            var lastFullRow = lastRow - 1;

            if (range.end.column > 0)
                this.removeInLine(lastRow, 0, range.end.column);

            if (lastFullRow >= firstFullRow)
                this.removeLines(firstFullRow, lastFullRow);

            if (firstFullRow != firstRow) {
                this.removeInLine(firstRow, range.start.column, this.getLine(firstRow).length);
                this.removeNewLine(range.start.row);
            }
        }
        else {
            this.removeInLine(firstRow, range.start.column, range.end.column);
        }
        this._dispatchEvent("changeEnd");
        return range.start;
    };

    this.removeInLine = function(row, startColumn, endColumn) {
        if (startColumn == endColumn)
            return;

        var range = new Range(row, startColumn, row, endColumn);
        var line = this.getLine(row);
        var removed = line.substring(startColumn, endColumn);
        var newLine = line.substring(0, startColumn) + line.substring(endColumn, line.length);
        this._dispatchEvent("changeStart");
        this.$lines.splice(row, 1, newLine);

        var delta = {
            action: "removeText",
            range: range,
            text: removed
        };
        this._dispatchEvent("change", { data: delta });
        this._dispatchEvent("changeEnd");
        return range.start;
    };

    /**
     * Removes a range of full lines
     *
     * @param firstRow {Integer} The first row to be removed
     * @param lastRow {Integer} The last row to be removed
     * @return {String[]} The removed lines
     */
    this.removeLines = function(firstRow, lastRow) {
        this._dispatchEvent("changeStart");
        var range = new Range(firstRow, 0, lastRow + 1, 0);
        var removed = this.$lines.splice(firstRow, lastRow - firstRow + 1);

        var delta = {
            action: "removeLines",
            range: range,
            nl: this.getNewLineCharacter(),
            lines: removed
        };
        this._dispatchEvent("change", { data: delta });
        this._dispatchEvent("changeEnd");
        return removed;
    };

    this.removeNewLine = function(row) {
        var firstLine = this.getLine(row);
        var secondLine = this.getLine(row+1);

        var range = new Range(row, firstLine.length, row+1, 0);
        var line = firstLine + secondLine;

        this._dispatchEvent("changeStart");
        this.$lines.splice(row, 2, line);

        var delta = {
            action: "removeText",
            range: range,
            text: this.getNewLineCharacter()
        };
        this._dispatchEvent("change", { data: delta });
        this._dispatchEvent("changeEnd");
    };

    this.replace = function(range, text) {
        if (text.length == 0 && range.isEmpty())
            return range.start;

        // Shortcut: If the text we want to insert is the same as it is already
        // in the document, we don't have to replace anything.
        if (text == this.getTextRange(range))
            return range.end;

        this._dispatchEvent("changeStart");
        this.remove(range);
        if (text) {
            var end = this.insert(range.start, text);
        }
        else {
            end = range.start;
        }
        this._dispatchEvent("changeEnd");

        return end;
    };

    this.applyDeltas = function(deltas) {
        for (var i=0; i<deltas.length; i++) {
            var delta = deltas[i];
            var range = Range.fromPoints(delta.range.start, delta.range.end);

            if (delta.action == "insertLines")
                this.insertLines(range.start.row, delta.lines)
            else if (delta.action == "insertText")
                this.insert(range.start, delta.text)
            else if (delta.action == "removeLines")
                this.removeLines(range.start.row, range.end.row - 1)
            else if (delta.action == "removeText")
                this.remove(range)
        }
    };

    this.revertDeltas = function(deltas) {
        for (var i=deltas.length-1; i>=0; i--) {
            var delta = deltas[i];

            var range = Range.fromPoints(delta.range.start, delta.range.end);

            if (delta.action == "insertLines")
                this.removeLines(range.start.row, range.end.row - 1)
            else if (delta.action == "insertText")
                this.remove(range)
            else if (delta.action == "removeLines")
                this.insertLines(range.start.row, delta.lines)
            else if (delta.action == "removeText")
                this.insert(range.start, delta.text)
        }
    };

}).call(Document.prototype);

exports.Document = Document;
});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('ace/anchor', ['require', 'exports', 'module' , 'pilot/oop', 'pilot/event_emitter'], function(require, exports, module) {

var oop = require("pilot/oop");
var EventEmitter = require("pilot/event_emitter").EventEmitter;

/**
 * An Anchor is a floating pointer in the document. Whenever text is inserted or
 * deleted before the cursor, the position of the cursor is updated
 */
var Anchor = exports.Anchor = function(doc, row, column) {
    this.document = doc;
    
    if (typeof column == "undefined")
        this.setPosition(row.row, row.column);
    else
        this.setPosition(row, column);

    this.$onChange = this.onChange.bind(this);
    doc.on("change", this.$onChange);
};

(function() {

    oop.implement(this, EventEmitter);
    
    this.getPosition = function() {
        return this.$clipPositionToDocument(this.row, this.column);
    };
    
    this.getDocument = function() {
        return this.document;
    };
    
    this.onChange = function(e) {
        var delta = e.data;
        var range = delta.range;
            
        if (range.start.row == range.end.row && range.start.row != this.row)
            return;
            
        if (range.start.row > this.row)
            return;
            
        if (range.start.row == this.row && range.start.column > this.column)
            return;
    
        var row = this.row;
        var column = this.column;
        
        if (delta.action === "insertText") {
            if (range.start.row === row && range.start.column <= column) {
                if (range.start.row === range.end.row) {
                    column += range.end.column - range.start.column;
                }
                else {
                    column -= range.start.column;
                    row += range.end.row - range.start.row;
                }
            }
            else if (range.start.row !== range.end.row && range.start.row < row) {
                row += range.end.row - range.start.row;
            }
        } else if (delta.action === "insertLines") {
            if (range.start.row <= row) {
                row += range.end.row - range.start.row;
            }
        }
        else if (delta.action == "removeText") {
            if (range.start.row == row && range.start.column < column) {
                if (range.end.column >= column)
                    column = range.start.column;
                else
                    column = Math.max(0, column - (range.end.column - range.start.column));
                
            } else if (range.start.row !== range.end.row && range.start.row < row) {
                if (range.end.row == row) {
                    column = Math.max(0, column - range.end.column) + range.start.column;
                }
                row -= (range.end.row - range.start.row);
            }
            else if (range.end.row == row) {
                row -= range.end.row - range.start.row;
                column = Math.max(0, column - range.end.column) + range.start.column;
            }
        } else if (delta.action == "removeLines") {
            if (range.start.row <= row) {
                if (range.end.row <= row)
                    row -= range.end.row - range.start.row;
                else {
                    row = range.start.row;
                    column = 0;
                }
            }
        }

        this.setPosition(row, column, true);
    };

    this.setPosition = function(row, column, noClip) {
        if (noClip) {
            pos = {
                row: row,
                column: column
            };
        }
        else {
            pos = this.$clipPositionToDocument(row, column);
        }
        
        if (this.row == pos.row && this.column == pos.column)
            return;
            
        var old = {
            row: this.row,
            column: this.column
        };
        
        this.row = pos.row;
        this.column = pos.column;
        this._dispatchEvent("change", {
            old: old,
            value: pos
        });
    };
    
    this.detach = function() {
        this.document.removeEventListener("change", this.$onChange);
    };
    
    this.$clipPositionToDocument = function(row, column) {
        var pos = {};
    
        if (row >= this.document.getLength()) {
            pos.row = Math.max(0, this.document.getLength() - 1);
            pos.column = this.document.getLine(pos.row).length;
        }
        else if (row < 0) {
            pos.row = 0;
            pos.column = 0;
        }
        else {
            pos.row = row;
            pos.column = Math.min(this.document.getLine(pos.row).length, Math.max(0, column));
        }
        
        if (column < 0)
            pos.column = 0;
            
        return pos;
    };
    
}).call(Anchor.prototype);

});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('ace/background_tokenizer', ['require', 'exports', 'module' , 'pilot/oop', 'pilot/event_emitter'], function(require, exports, module) {

var oop = require("pilot/oop");
var EventEmitter = require("pilot/event_emitter").EventEmitter;

var BackgroundTokenizer = function(tokenizer, editor) {
    this.running = false;    
    this.lines = [];
    this.currentLine = 0;
    this.tokenizer = tokenizer;

    var self = this;

    this.$worker = function() {
        if (!self.running) { return; }

        var workerStart = new Date();
        var startLine = self.currentLine;
        var doc = self.doc;

        var processedLines = 0;

        var len = doc.getLength();
        while (self.currentLine < len) {
            self.lines[self.currentLine] = self.$tokenizeRows(self.currentLine, self.currentLine)[0];
            self.currentLine++;

            // only check every 5 lines
            processedLines += 1;
            if ((processedLines % 5 == 0) && (new Date() - workerStart) > 20) {
                self.fireUpdateEvent(startLine, self.currentLine-1);
                self.running = setTimeout(self.$worker, 20);
                return;
            }
        }

        self.running = false;

        self.fireUpdateEvent(startLine, len - 1);
    };
};

(function(){

    oop.implement(this, EventEmitter);

    this.setTokenizer = function(tokenizer) {
        this.tokenizer = tokenizer;
        this.lines = [];

        this.start(0);
    };

    this.setDocument = function(doc) {
        this.doc = doc;
        this.lines = [];

        this.stop();
    };

    this.fireUpdateEvent = function(firstRow, lastRow) {
        var data = {
            first: firstRow,
            last: lastRow
        };
        this._dispatchEvent("update", {data: data});
    };

    this.start = function(startRow) {
        this.currentLine = Math.min(startRow || 0, this.currentLine,
                                    this.doc.getLength());

        // remove all cached items below this line
        this.lines.splice(this.currentLine, this.lines.length);

        this.stop();
        // pretty long delay to prevent the tokenizer from interfering with the user
        this.running = setTimeout(this.$worker, 700);
    };

    this.stop = function() {
        if (this.running)
            clearTimeout(this.running);
        this.running = false;
    };

    this.getTokens = function(firstRow, lastRow) {
        return this.$tokenizeRows(firstRow, lastRow);
    };

    this.getState = function(row) {
        return this.$tokenizeRows(row, row)[0].state;
    };

    this.$tokenizeRows = function(firstRow, lastRow) {
        if (!this.doc)
            return [];
            
        var rows = [];

        // determine start state
        var state = "start";
        var doCache = false;
        if (firstRow > 0 && this.lines[firstRow - 1]) {
            state = this.lines[firstRow - 1].state;
            doCache = true;
        } else if (firstRow == 0) {
            state = "start";
            doCache = true;
        } else if (this.lines.length > 0) {
            // Guess that we haven't changed state.
            state = this.lines[this.lines.length-1].state;
        }

        var lines = this.doc.getLines(firstRow, lastRow);
        for (var row=firstRow; row<=lastRow; row++) {
            if (!this.lines[row]) {
                var tokens = this.tokenizer.getLineTokens(lines[row-firstRow] || "", state);
                var state = tokens.state;
                rows.push(tokens);

                if (doCache) {
                    this.lines[row] = tokens;
                }
            }
            else {
                var tokens = this.lines[row];
                state = tokens.state;
                rows.push(tokens);
            }
        }
        return rows;
    };

}).call(BackgroundTokenizer.prototype);

exports.BackgroundTokenizer = BackgroundTokenizer;
});
/* vim:ts=4:sts=4:sw=4:
 * ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Julian Viereck <julian DOT viereck AT gmail DOT com>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('ace/edit_session/folding', ['require', 'exports', 'module' , 'ace/range', 'ace/edit_session/fold_line'], function(require, exports, module) {

var Range = require("ace/range").Range;
var FoldLine = require("ace/edit_session/fold_line").FoldLine;

/**
 * Simple fold-data struct.
 **/
function Fold(range, placeholder) {
    this.foldLine = null;
    this.placeholder = placeholder;
    this.range = range;
    this.start = range.start;
    this.end = range.end;

    this.sameRow = range.start.row == range.end.row;
    this.subFolds = [];
}

Fold.prototype.toString = function() {
    return '"' + this.placeholder + '" ' + this.range.toString();
}

Fold.prototype.setFoldLine = function(foldLine) {
    this.foldLine = foldLine;
    this.subFolds.forEach(function(fold) {
        fold.setFoldLine(foldLine);
    });
}

Fold.prototype.clone = function() {
    var range = this.range.clone();
    var fold = new Fold(range, this.placeholder);
    this.subFolds.forEach(function(subFold) {
        fold.subFolds.push(subFold.clone());
    });
    return fold;
}

function Folding() {
    /**
     * Looks up a fold at a given row/column. Possible values for side:
     *   -1: ignore a fold if fold.start = row/column
     *   +1: ignore a fold if fold.end = row/column
     */
    this.getFoldAt = function(row, column, side) {
        var foldLine = this.getFoldLine(row);
        if (foldLine) {
            var folds = foldLine.folds,
                fold;

            for (var i = 0; i < folds.length; i++) {
                fold = folds[i];
                if (fold.range.contains(row, column)) {
                    if (side == 1 && fold.range.isEnd(row, column)) {
                        continue;
                    } else if (side == -1 && fold.range.isStart(row, column)) {
                        continue;
                    }
                    return fold;
                }
            }
        } else {
            return null;
        }
    }

    /**
     * Returns all folds in the given range. Note, that this will return folds
     *
     */
    this.getFoldsInRange = function(range) {
        range = range.clone();
        var start = range.start,
            end = range.end;
        var foldLines = this.$foldData,
            folds,
            fold;
        var cmp,
            foundFolds = [];

        start.column += 1;
        end.column -= 1;

        for (var i = 0; i < foldLines.length; i++) {
            cmp = foldLines[i].range.compareRange(range);
            // Range is before foldLine. No intersection. This means,
            // there might be other foldLines that intersect.
            if (cmp == 2) {
                continue;
            } else
            // Range is after foldLine. There can't be any other foldLines then,
            // so let's give up.
            if (cmp == -2) {
                break;
            }

            folds = foldLines[i].folds;
            for (var j = 0; j < folds.length; j++) {
                fold = folds[j];
                cmp = fold.range.compareRange(range);
                if (cmp == -2) {
                    break;
                } else if (cmp == 2) {
                    continue;
                } else
                // WTF-state: Can happen due to -1/+1 to start/end column.
                if (cmp == 42) {
                    break;
                }
                foundFolds.push(fold);
            }
        }
        return foundFolds;
    }

    /**
     * Returns the string between folds at the given position.
     * E.g.
     *  foo<fold>b|ar<fold>wolrd -> "bar"
     *  foo<fold>bar<fold>wol|rd -> "world"
     *  foo<fold>bar<fo|ld>wolrd -> <null>
     *
     * where | means the position of row/column
     *
     * The trim option determs if the return string should be trimed according
     * to the "side" passed with the trim value:
     *
     * E.g.
     *  foo<fold>b|ar<fold>wolrd -trim=-1> "b"
     *  foo<fold>bar<fold>wol|rd -trim=+1> "rld"
     *  fo|o<fold>bar<fold>wolrd -trim=00> "foo"
     */
    this.getFoldStringAt = function(row, column, trim, foldLine) {
        var foldLine = foldLine || this.getFoldLine(row);
        if (!foldLine) {
            return null;
        } else {
            var fold, lastFold, cmp, str;
            lastFold = {
                end: { column: 0 }
            };
            // TODO: Refactor to use getNextFoldTo function.
            for (var i = 0; i < foldLine.folds.length; i++) {
                fold = foldLine.folds[i];
                cmp = fold.range.compareEnd(row, column);
                if (cmp == -1) {
                    str = this.getLine(fold.start.row).
                                substring(lastFold.end.column, fold.start.column);
                    break;
                } else if (cmp == 0) {
                    return null;
                }
                lastFold = fold;
            }
            if (!str) {
                str = this.getLine(fold.start.row).
                                substring(lastFold.end.column);
            }
            if (trim == -1) {
                return str.substring(0, column - lastFold.end.column);
            } else if (trim == 1) {
                return str.substring(column - lastFold.end.column)
            } else {
                return str;
            }
        }
    }

    this.getFoldLine = function(docRow, startFoldLine) {
        var foldData = this.$foldData;
        var i = 0;
        if(startFoldLine)
            i = foldData.indexOf(startFoldLine);
        if(i == -1)
            i = 0;
        for (i; i < foldData.length; i++) {
            var foldLine = foldData[i];
            if (foldLine.start.row <= docRow && foldLine.end.row >= docRow) {
                return foldLine;
            } else if (foldLine.end.row > docRow) {
                return null;
            }
        }
        return null;
    }

    // returns the fold which starts after or contains docRow
    this.getNextFold = function(docRow, startFoldLine) {
        var foldData = this.$foldData, ans;
        var i = 0;
        if(startFoldLine)
            i = foldData.indexOf(startFoldLine);
        if(i == -1)
            i = 0;
        for (i; i < foldData.length; i++) {
            var foldLine = foldData[i];
            if (foldLine.end.row >= docRow) {
                return foldLine;
            }
        }
        return null;
    }

    this.getFoldedRowCount = function(first, last) {
        var foldData = this.$foldData, rowCount = last-first+1;
        for (var i = 0; i < foldData.length; i++) {
            var foldLine = foldData[i],
                end = foldLine.end.row,
                start = foldLine.start.row;
            if(end >= last) {
                if(start < last) {
                    if(start >= first)
                        rowCount -= last-start;
                    else
                        rowCount = 0;//in one fold
                }
                break;
            } else if(end >= first){
                if (start >= first) //fold inside range
                    rowCount -=  end-start;
                else
                    rowCount -=  end-first+1;
            }
        }
        return rowCount;
    }

    this.$addFoldLine = function(foldLine) {
        this.$foldData.push(foldLine);
        this.$foldData.sort(function(a, b) {
            return a.start.row - b.start.row;
        });
        return foldLine;
    }

    /**
     * Adds a new fold.
     *
     * @returns
     *      The new created Fold object or an existing fold object in case the
     *      passed in range fits an existing fold exactly.
     */
    this.addFold = function(placeholder, startRow, startColumn, endRow, endColumn) {
        var range;
        var foldData = this.$foldData;
        var foldRow  = null;
        var foldLine;
        var fold;
        var argsFold;
        var folds;
        var added = false;

        if (placeholder instanceof Fold) {
            argsFold = placeholder;
            startRow = argsFold.range;
            placeholder = argsFold.placeholder;
        }

        // Normalize parameters.
        if (!(startRow instanceof Range)) {
            range = new Range(startRow, startColumn, endRow, endColumn);
        } else {
            range = startRow;
            startRow = range.start.row;
            startColumn = range.start.column;
            endRow = range.end.row;
            endColumn = range.end.column;
        }

        // --- Some checking ---
        if (placeholder.length < 2) {
            throw "Placeholder has to be at least 2 characters";
        }

        if (startRow == endRow && endColumn - startColumn < 2) {
            throw "The range has to be at least 2 characters width";
        }

        fold = this.getFoldAt(startRow, startColumn, 1);
        if (fold
            && fold.range.isEnd(endRow, endColumn)
            && fold.range.isStart(startRow, startColumn))
        {
            return fold;
        }

        fold = this.getFoldAt(startRow, startColumn, 1);
        if (fold && !fold.range.isStart(startRow, startColumn)) {
            throw "A fold can't start inside of an already existing fold";
        }

        fold = this.getFoldAt(endRow, endColumn, -1);
        if (fold && !fold.range.isEnd(endRow, endColumn)) {
            throw "A fold can't end inside of an already existing fold";
        }

        if (endRow >= this.doc.getLength()) {
            throw "End of fold is outside of the document.";
        }

        if (endColumn > this.getLine(endRow).length
            || startColumn > this.getLine(startRow).length)
        {
            throw "End of fold is outside of the document.";
        }

        // --- Start adding the fold ---
        // Use the passed in fold or create a new one.
        fold = argsFold || new Fold(range, placeholder);

        // Check if there are folds in the range we create the new fold for.
        folds = this.getFoldsInRange(range);
        if (folds.length > 0) {
            // Remove the folds from fold data.
            this.removeFolds(folds);
            // Add the removed folds as subfolds on the new fold.
            fold.subFolds = folds;
        }

        for (var i = 0; i < foldData.length; i++) {
            foldLine = foldData[i];
            if (endRow == foldLine.start.row) {
                foldLine.addFold(fold);
                added = true;
                break;
            } else if (startRow == foldLine.end.row) {
                foldLine.addFold(fold);
                added = true;
                if (!fold.sameRow) {
                    // Check if we might have to merge two FoldLines.
                    foldLineNext = foldData[i + 1];
                    if (foldLineNext && foldLineNext.start.row == endRow) {
                        // We need to merge!
                        foldLine.merge(foldLineNext);
                        break;
                    }
                }
                break;
            } else if (endRow <= foldLine.start.row) {
                break;
            }
        }

        if (!added) {
            foldLine = this.$addFoldLine(new FoldLine(this.$foldData, fold));
        }

        if (this.$useWrapMode) {
            this.$updateWrapData(foldLine.start.row, foldLine.start.row);
        }

        // Notify that fold data has changed.
        this.$modified = true;
        this._dispatchEvent("changeFold", { data: fold });

        return fold;
    };

    this.addFolds = function(folds) {
        folds.forEach(function(fold) {
            this.addFold(fold);
        }, this);
    };

    this.removeFold = function(fold) {
        var foldLine = fold.foldLine;
        var startRow = foldLine.start.row;
        var endRow = foldLine.end.row;

        var foldLines = this.$foldData,
            folds = foldLine.folds;
        // Simple case where there is only one fold in the FoldLine such that
        // the entire fold line can get removed directly.
        if (folds.length == 1) {
            foldLines.splice(foldLines.indexOf(foldLine), 1);
        } else
        // If the fold is the last fold of the foldLine, just remove it.
        if (foldLine.range.isEnd(fold.end.row, fold.end.column)) {
            folds.pop();
            foldLine.end.row = folds[folds.length - 1].end.row;
            foldLine.end.column = folds[folds.length - 1].end.column;
        } else
        // If the fold is the first fold of the foldLine, just remove it.
        if (foldLine.range.isStart(fold.start.row, fold.start.column)) {
            folds.shift();
            foldLine.start.row = folds[0].start.row;
            foldLine.start.column = folds[0].start.column;
        } else
        // We know there are more then 2 folds and the fold is not at the edge.
        // This means, the fold is somewhere in between.
        //
        // If the fold is in one row, we just can remove it.
        if (fold.sameRow) {
            folds.splice(folds.indexOf(fold), 1);
        } else
        // The fold goes over more then one row. This means remvoing this fold
        // will cause the fold line to get splitted up.
        {
            var newFoldLine = foldLine.split(fold.start.row, fold.start.column);
            newFoldLine.folds.shift();
            foldLine.start.row = folds[0].start.row;
            foldLine.start.column = folds[0].start.column;
            this.$addFoldLine(newFoldLine);
        }

        if (this.$useWrapMode) {
            this.$updateWrapData(startRow, endRow);
        }

        // Notify that fold data has changed.
        this.$modified = true;
        this._dispatchEvent("changeFold", { data: fold });
    }

    this.removeFolds = function(folds) {
        // We need to clone the folds array passed in as it might be the folds
        // array of a fold line and as we call this.removeFold(fold), folds
        // are removed from folds and changes the current index.
        var cloneFolds = [];
        for (var i = 0; i < folds.length; i++) {
            cloneFolds.push(folds[i]);
        }

        cloneFolds.forEach(function(fold) {
            this.removeFold(fold);
        }, this);
        this.$modified = true;
    }

    this.expandFold = function(fold) {
        this.removeFold(fold);
        fold.subFolds.forEach(function(fold) {
            this.addFold(fold);
        }, this);
        fold.subFolds = [];
    }

    this.expandFolds = function(folds) {
        folds.forEach(function(fold) {
            this.expandFold(fold);
        }, this);
    }

    /**
     * Checks if a given documentRow is folded. This is true if there are some
     * folded parts such that some parts of the line is still visible.
     **/
    this.isRowFolded = function(docRow, startFoldRow) {
        return !!this.getFoldLine(docRow, startFoldRow);
    };

    this.getRowFoldEnd = function(docRow, startFoldRow) {
        var foldLine = this.getFoldLine(docRow, startFoldRow);
        return (foldLine
                    ? foldLine.end.row
                    : docRow)
    };

    this.getFoldDisplayLine = function(foldLine, endRow, endColumn, startRow, startColumn) {
        if (startRow == null) {
            startRow = foldLine.start.row;
            startColumn = 0;
        }

        if (endRow == null) {
            endRow = foldLine.end.row;
            endColumn = this.getLine(endRow).length;
        }

        // Build the textline using the FoldLine walker.
        var line = "";
        var doc = this.doc;
        var textLine = "";

        foldLine.walk(function(placeholder, row, column, lastColumn, isNewRow) {
            if (row < startRow) {
                return;
            } else if (row == startRow) {
                if (column < startColumn) {
                    return;
                }
                lastColumn = Math.max(startColumn, lastColumn);
            }
            if (placeholder) {
                textLine += placeholder;
            } else {
                textLine += doc.getLine(row).substring(lastColumn, column);
            }
        }.bind(this), endRow, endColumn);
        return textLine;
    };

    this.getDisplayLine = function(row, endColumn, startRow, startColumn) {
        var foldLine = this.getFoldLine(row);

        if (!foldLine) {
            var line;
            line = this.doc.getLine(row);
            return line.substring(startColumn || 0, endColumn || line.length);
        } else {
            return this.getFoldDisplayLine(
                foldLine, row, endColumn, startRow, startColumn);
        }
    };

    this.$cloneFoldData = function() {
        var foldData = this.$foldData;
        var fd = [];
        fd = this.$foldData.map(function(foldLine) {
            var folds = foldLine.folds.map(function(fold) {
                return fold.clone();
            });
            return new FoldLine(fd, folds);
        });

        return fd;
    };
}

exports.Folding = Folding;

});/* vim:ts=4:sts=4:sw=4:
 * ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Julian Viereck <julian DOT viereck AT gmail DOT com>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('ace/edit_session/fold_line', ['require', 'exports', 'module' , 'ace/range'], function(require, exports, module) {

var Range = require("ace/range").Range;

/**
 * If the an array is passed in, the folds are expected to be sorted already.
 */
function FoldLine(foldData, folds) {
    this.foldData = foldData;
    if (Array.isArray(folds)) {
        this.folds = folds;
    } else {
        folds = this.folds = [ folds ];
    }

    var last = folds[folds.length - 1]
    this.range = new Range(folds[0].start.row, folds[0].start.column,
                           last.end.row, last.end.column);
    this.start = this.range.start;
    this.end   = this.range.end;

    this.folds.forEach(function(fold) {
        fold.setFoldLine(this);
    }, this);
}

(function() {
    /**
     * Note: This doesn't update wrapData!
     */
    this.shiftRow = function(shift) {
        this.start.row += shift;
        this.end.row += shift;
        this.folds.forEach(function(fold) {
            fold.start.row += shift;
            fold.end.row += shift;
        });
    }

    this.addFold = function(fold) {
        if (fold.sameRow) {
            if (fold.start.row < this.startRow || fold.endRow > this.endRow) {
                throw "Can't add a fold to this FoldLine as it has no connection";
            }
            this.folds.push(fold);
            this.folds.sort(function(a, b) {
                return -a.range.compareEnd(b.start.row, b.start.column);
            });
            if (this.range.compareEnd(fold.start.row, fold.start.column) > 0) {
                this.end.row = fold.end.row;
                this.end.column =  fold.end.column;
            } else if (this.range.compareStart(fold.end.row, fold.end.column) < 0) {
                this.start.row = fold.start.row;
                this.start.column = fold.start.column;
            }
        } else if (fold.start.row == this.end.row) {
            this.folds.push(fold);
            this.end.row = fold.end.row;
            this.end.column = fold.end.column;
        } else if (fold.end.row == this.start.row) {
            this.folds.unshift(fold);
            this.start.row = fold.start.row;
            this.start.column = fold.start.column;
        } else {
            throw "Trying to add fold to FoldRow that doesn't have a matching row";
        }
        fold.foldLine = this;
    }

    this.containsRow = function(row) {
        return row >= this.start.row && row <= this.end.row;
    }

    this.walk = function(callback, endRow, endColumn) {
        var lastEnd = 0,
            folds = this.folds,
            fold,
            comp, stop, isNewRow = true;

        if (endRow == null) {
            endRow = this.end.row;
            endColumn = this.end.column;
        }

        for (var i = 0; i < folds.length; i++) {
            fold = folds[i];

            comp = fold.range.compareStart(endRow, endColumn);
            // This fold is after the endRow/Column.
            if (comp == -1) {
                callback(null, endRow, endColumn, lastEnd, isNewRow);
                return;
            }

            stop = callback(null, fold.start.row, fold.start.column, lastEnd, isNewRow);
            stop = !stop && callback(fold.placeholder, fold.start.row, fold.start.column, lastEnd);

            // If the user requested to stop the walk or endRow/endColumn is
            // inside of this fold (comp == 0), then end here.
            if (stop || comp == 0) {
                return;
            }

            // Note the new lastEnd might not be on the same line. However,
            // it's the callback's job to recognize this.
            isNewRow = !fold.sameRow;
            lastEnd = fold.end.column;
        }
        callback(null, endRow, endColumn, lastEnd, isNewRow);
    }

    this.getNextFoldTo = function(row, column) {
        var fold, cmp;
        for (var i = 0; i < this.folds.length; i++) {
            fold = this.folds[i];
            cmp = fold.range.compareEnd(row, column);
            if (cmp == -1) {
                return {
                    fold: fold,
                    kind: "after"
                };
            } else if (cmp == 0) {
                return {
                    fold: fold,
                    kind: "inside"
                }
            }
        }
        return null;
    }

    this.addRemoveChars = function(row, column, len) {
        var ret = this.getNextFoldTo(row, column),
            fold, folds;
        if (ret) {
            fold = ret.fold;
            if (ret.kind == "inside"
                && fold.start.column != column
                && fold.start.row != row)
            {
                throw "Moving characters inside of a fold should never be reached";
            } else if (fold.start.row == row) {
                folds = this.folds;
                var i = folds.indexOf(fold);
                if (i == 0) {
                    this.start.column += len;
                }
                for (i; i < folds.length; i++) {
                    fold = folds[i];
                    fold.start.column += len;
                    if (!fold.sameRow) {
                        return;
                    }
                    fold.end.column += len;
                }
                this.end.column += len;
            }
        }
    }

    this.split = function(row, column) {
        var fold = this.getNextFoldTo(row, column).fold,
            folds = this.folds;
        var foldData = this.foldData;

        if (!fold) {
            return null;
        }
        var i = folds.indexOf(fold);
        var foldBefore = folds[i - 1];
        this.end.row = foldBefore.end.row;
        this.end.column = foldBefore.end.column;

        // Remove the folds after row/column and create a new FoldLine
        // containing these removed folds.
        folds = folds.splice(i, folds.length - i);

        var newFoldLine = new FoldLine(foldData, folds);
        foldData.splice(foldData.indexOf(this) + 1, 0, newFoldLine);
        return newFoldLine;
    }

    this.merge = function(foldLineNext) {
        var folds = foldLineNext.folds;
        for (var i = 0; i < folds.length; i++) {
            this.addFold(folds[i]);
        }
        // Remove the foldLineNext - no longer needed, as
        // it's merged now with foldLineNext.
        var foldData = this.foldData;
        foldData.splice(foldData.indexOf(foldLineNext), 1);
    }

    this.toString = function() {
        var ret = [this.range.toString() + ": [" ];

        this.folds.forEach(function(fold) {
            ret.push("  " + fold.toString());
        });
        ret.push("]")
        return ret.join("\n");
    }

    this.idxToPosition = function(idx) {
        var lastFoldEndColumn = 0;
        var fold;

        for (var i = 0; i < this.folds.length; i++) {
            var fold = this.folds[i];

            idx -= fold.start.column - lastFoldEndColumn;
            if (idx < 0) {
                return {
                    row: fold.start.row,
                    column: fold.start.column + idx
                };
            }

            idx -= fold.placeholder.length;
            if (idx < 0) {
                return fold.start;
            }

            lastFoldEndColumn = fold.end.column;
        }

        return {
            row: this.end.row,
            column: this.end.column + idx
        };
    }
}).call(FoldLine.prototype);

exports.FoldLine = FoldLine;
});/* vim:ts=4:sts=4:sw=4:
 * ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *      Mihai Sucan <mihai DOT sucan AT gmail DOT com>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('ace/search', ['require', 'exports', 'module' , 'pilot/lang', 'pilot/oop', 'ace/range'], function(require, exports, module) {

var lang = require("pilot/lang");
var oop = require("pilot/oop");
var Range = require("ace/range").Range;

var Search = function() {
    this.$options = {
        needle: "",
        backwards: false,
        wrap: false,
        caseSensitive: false,
        wholeWord: false,
        scope: Search.ALL,
        regExp: false
    };
};

Search.ALL = 1;
Search.SELECTION = 2;

(function() {

    this.set = function(options) {
        oop.mixin(this.$options, options);
        return this;
    };
    
    this.getOptions = function() {
        return lang.copyObject(this.$options);
    };

    this.find = function(session) {
        if (!this.$options.needle)
            return null;

        if (this.$options.backwards) {
            var iterator = this.$backwardMatchIterator(session);
        } else {
            iterator = this.$forwardMatchIterator(session);
        }

        var firstRange = null;
        iterator.forEach(function(range) {
            firstRange = range;
            return true;
        });

        return firstRange;
    };

    this.findAll = function(session) {
        if (!this.$options.needle)
            return [];

        if (this.$options.backwards) {
            var iterator = this.$backwardMatchIterator(session);
        } else {
            iterator = this.$forwardMatchIterator(session);
        }

        var ranges = [];
        iterator.forEach(function(range) {
            ranges.push(range);
        });

        return ranges;
    };

    this.replace = function(input, replacement) {
        var re = this.$assembleRegExp();
        var match = re.exec(input);
        if (match && match[0].length == input.length) {
            if (this.$options.regExp) {
                return input.replace(re, replacement);
            } else {
                return replacement;
            }
        } else {
            return null;
        }
    };

    this.$forwardMatchIterator = function(session) {
        var re = this.$assembleRegExp();
        var self = this;

        return {
            forEach: function(callback) {
                self.$forwardLineIterator(session).forEach(function(line, startIndex, row) {
                    if (startIndex) {
                        line = line.substring(startIndex);
                    }

                    var matches = [];

                    line.replace(re, function(str) {
                        var offset = arguments[arguments.length-2];
                        matches.push({
                            str: str,
                            offset: startIndex + offset
                        });
                        return str;
                    });

                    for (var i=0; i<matches.length; i++) {
                        var match = matches[i];
                        var range = self.$rangeFromMatch(row, match.offset, match.str.length);
                        if (callback(range))
                            return true;
                    }

                });
            }
        };
    };

    this.$backwardMatchIterator = function(session) {
        var re = this.$assembleRegExp();
        var self = this;

        return {
            forEach: function(callback) {
                self.$backwardLineIterator(session).forEach(function(line, startIndex, row) {
                    if (startIndex) {
                        line = line.substring(startIndex);
                    }

                    var matches = [];

                    line.replace(re, function(str, offset) {
                        matches.push({
                            str: str,
                            offset: startIndex + offset
                        });
                        return str;
                    });

                    for (var i=matches.length-1; i>= 0; i--) {
                        var match = matches[i];
                        var range = self.$rangeFromMatch(row, match.offset, match.str.length);
                        if (callback(range))
                            return true;
                    }
                });
            }
        };
    };

    this.$rangeFromMatch = function(row, column, length) {
        return new Range(row, column, row, column+length);
    };

    this.$assembleRegExp = function() {
        if (this.$options.regExp) {
            var needle = this.$options.needle;
        } else {
            needle = lang.escapeRegExp(this.$options.needle);
        }

        if (this.$options.wholeWord) {
            needle = "\\b" + needle + "\\b";
        }

        var modifier = "g";
        if (!this.$options.caseSensitive) {
            modifier += "i";
        }

        var re = new RegExp(needle, modifier);
        return re;
    };

    this.$forwardLineIterator = function(session) {
        var searchSelection = this.$options.scope == Search.SELECTION;

        var range = session.getSelection().getRange();
        var start = session.getSelection().getCursor();

        var firstRow = searchSelection ? range.start.row : 0;
        var firstColumn = searchSelection ? range.start.column : 0;
        var lastRow = searchSelection ? range.end.row : session.getLength() - 1;

        var wrap = this.$options.wrap;
        var inWrap = false;

        function getLine(row) {
            var line = session.getLine(row);
            if (searchSelection && row == range.end.row) {
                line = line.substring(0, range.end.column);
            }
            if (inWrap && row == start.row) {
                line = line.substring(0, start.column);
            }
            return line;
        }

        return {
            forEach: function(callback) {
                var row = start.row;

                var line = getLine(row);
                var startIndex = start.column;

                var stop = false;
                inWrap = false;

                while (!callback(line, startIndex, row)) {

                    if (stop) {
                        return;
                    }

                    row++;
                    startIndex = 0;

                    if (row > lastRow) {
                        if (wrap) {
                            row = firstRow;
                            startIndex = firstColumn;
                            inWrap = true;
                        } else {
                            return;
                        }
                    }

                    if (row == start.row)
                        stop = true;

                    line = getLine(row);
                }
            }
        };
    };

    this.$backwardLineIterator = function(session) {
        var searchSelection = this.$options.scope == Search.SELECTION;

        var range = session.getSelection().getRange();
        var start = searchSelection ? range.end : range.start;

        var firstRow = searchSelection ? range.start.row : 0;
        var firstColumn = searchSelection ? range.start.column : 0;
        var lastRow = searchSelection ? range.end.row : session.getLength() - 1;

        var wrap = this.$options.wrap;

        return {
            forEach : function(callback) {
                var row = start.row;

                var line = session.getLine(row).substring(0, start.column);
                var startIndex = 0;
                var stop = false;
                var inWrap = false;

                while (!callback(line, startIndex, row)) {

                    if (stop)
                        return;

                    row--;
                    startIndex = 0;

                    if (row < firstRow) {
                        if (wrap) {
                            row = lastRow;
                            inWrap = true;
                        } else {
                            return;
                        }
                    }

                    if (row == start.row)
                        stop = true;

                    line = session.getLine(row);
                    if (searchSelection) {
                        if (row == firstRow)
                            startIndex = firstColumn;
                        else if (row == lastRow)
                            line = line.substring(0, range.end.column);
                    }

                    if (inWrap && row == start.row)
                        startIndex = start.column;
                }
            }
        };
    };

}).call(Search.prototype);

exports.Search = Search;
});
/* vim:ts=4:sts=4:sw=4:
 * ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *      Mihai Sucan <mihai DOT sucan AT gmail DOT com>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('ace/undomanager', ['require', 'exports', 'module' ], function(require, exports, module) {

var UndoManager = function() {
    this.reset();
};

(function() {

    this.execute = function(options) {
        var deltas = options.args[0];
        this.$doc  = options.args[1];
        this.$undoStack.push(deltas);
        this.$redoStack = [];
    };

    this.undo = function(dontSelect) {
        var deltas = this.$undoStack.pop();
        var undoSelectionRange = null;
        if (deltas) {
            undoSelectionRange =
                this.$doc.undoChanges(deltas, dontSelect);
            this.$redoStack.push(deltas);
        }
        return undoSelectionRange;
    };

    this.redo = function(dontSelect) {
        var deltas = this.$redoStack.pop();
        var redoSelectionRange = null;
        if (deltas) {
            redoSelectionRange =
                this.$doc.redoChanges(deltas, dontSelect);
            this.$undoStack.push(deltas);
        }
        return redoSelectionRange;
    };

    this.reset = function() {
        this.$undoStack = [];
        this.$redoStack = [];
    };

    this.hasUndo = function() {
        return this.$undoStack.length > 0;
    };

    this.hasRedo = function() {
        return this.$redoStack.length > 0;
    };

}).call(UndoManager.prototype);

exports.UndoManager = UndoManager;
});
/* vim:ts=4:sts=4:sw=4:
 * ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian@ajax.org>
 *      Irakli Gozalishvili <rfobic@gmail.com> (http://jeditoolkit.com)
 *      Julian Viereck <julian.viereck@gmail.com>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('ace/virtual_renderer', ['require', 'exports', 'module' , 'pilot/oop', 'pilot/dom', 'pilot/event', 'pilot/useragent', 'ace/layer/gutter', 'ace/layer/marker', 'ace/layer/text', 'ace/layer/cursor', 'ace/scrollbar', 'ace/renderloop', 'pilot/event_emitter', 'text/ace/css/editor.css'], function(require, exports, module) {

var oop = require("pilot/oop");
var dom = require("pilot/dom");
var event = require("pilot/event");
var useragent = require("pilot/useragent");
var GutterLayer = require("ace/layer/gutter").Gutter;
var MarkerLayer = require("ace/layer/marker").Marker;
var TextLayer = require("ace/layer/text").Text;
var CursorLayer = require("ace/layer/cursor").Cursor;
var ScrollBar = require("ace/scrollbar").ScrollBar;
var RenderLoop = require("ace/renderloop").RenderLoop;
var EventEmitter = require("pilot/event_emitter").EventEmitter;
var editorCss = require("text/ace/css/editor.css");

// import CSS once
dom.importCssString(editorCss);

var VirtualRenderer = function(container, theme) {
    this.container = container;
    dom.addCssClass(this.container, "ace_editor");

    this.setTheme(theme);

    this.$gutter = dom.createElement("div");
    this.$gutter.className = "ace_gutter";
    this.container.appendChild(this.$gutter);

    this.scroller = dom.createElement("div");
    this.scroller.className = "ace_scroller";
    this.container.appendChild(this.scroller);

    this.content = dom.createElement("div");
    this.content.className = "ace_content";
    this.scroller.appendChild(this.content);

    this.$gutterLayer = new GutterLayer(this.$gutter);
    this.$markerBack = new MarkerLayer(this.content);

    var textLayer = this.$textLayer = new TextLayer(this.content);
    this.canvas = textLayer.element;

    this.$markerFront = new MarkerLayer(this.content);

    this.characterWidth = textLayer.getCharacterWidth();
    this.lineHeight = textLayer.getLineHeight();

    this.$cursorLayer = new CursorLayer(this.content);
    this.$cursorPadding = 8;

    // Indicates whether the horizontal scrollbar is visible
    this.$horizScroll = true;
    this.$horizScrollAlwaysVisible = true;

    this.scrollBar = new ScrollBar(container);
    this.scrollBar.addEventListener("scroll", this.onScroll.bind(this));

    this.scrollTop = 0;

    this.cursorPos = {
        row : 0,
        column : 0
    };

    var _self = this;
    this.$textLayer.addEventListener("changeCharaterSize", function() {
        _self.characterWidth = textLayer.getCharacterWidth();
        _self.lineHeight = textLayer.getLineHeight();
        _self.$updatePrintMargin();
        _self.onResize(true);

        _self.$loop.schedule(_self.CHANGE_FULL);
    });
    event.addListener(this.$gutter, "click", this.$onGutterClick.bind(this));
    event.addListener(this.$gutter, "dblclick", this.$onGutterClick.bind(this));

    this.$size = {
        width: 0,
        height: 0,
        scrollerHeight: 0,
        scrollerWidth: 0
    };

    this.$loop = new RenderLoop(this.$renderChanges.bind(this));
    this.$loop.schedule(this.CHANGE_FULL);

    this.setPadding(4);
    this.$updatePrintMargin();
};

(function() {
    this.showGutter = true;

    this.CHANGE_CURSOR = 1;
    this.CHANGE_MARKER = 2;
    this.CHANGE_GUTTER = 4;
    this.CHANGE_SCROLL = 8;
    this.CHANGE_LINES = 16;
    this.CHANGE_TEXT = 32;
    this.CHANGE_SIZE = 64;
    this.CHANGE_MARKER_BACK = 128;
    this.CHANGE_MARKER_FRONT = 256;
    this.CHANGE_FULL = 512;

    oop.implement(this, EventEmitter);

    this.setSession = function(session) {
        this.session = session;
        this.$cursorLayer.setSession(session);
        this.$markerBack.setSession(session);
        this.$markerFront.setSession(session);
        this.$gutterLayer.setSession(session);
        this.$textLayer.setSession(session);
        this.$loop.schedule(this.CHANGE_FULL);
    };

    /**
     * Triggers partial update of the text layer
     */
    this.updateLines = function(firstRow, lastRow) {
        if (lastRow === undefined)
            lastRow = Infinity;

        if (!this.$changedLines) {
            this.$changedLines = {
                firstRow: firstRow,
                lastRow: lastRow
            };
        }
        else {
            if (this.$changedLines.firstRow > firstRow)
                this.$changedLines.firstRow = firstRow;

            if (this.$changedLines.lastRow < lastRow)
                this.$changedLines.lastRow = lastRow;
        }

        this.$loop.schedule(this.CHANGE_LINES);
    };

    /**
     * Triggers full update of the text layer
     */
    this.updateText = function() {
        this.$loop.schedule(this.CHANGE_TEXT);
    };

    /**
     * Triggers a full update of all layers
     */
    this.updateFull = function() {
        this.$loop.schedule(this.CHANGE_FULL);
    };

    this.updateFontSize = function() {
        this.$textLayer.checkForSizeChanges();
    };

    /**
     * Triggers resize of the editor
     */
    this.onResize = function(force) {
        var changes = this.CHANGE_SIZE;

        var height = dom.getInnerHeight(this.container);
        if (force || this.$size.height != height) {
            this.$size.height = height;

            this.scroller.style.height = height + "px";
            this.scrollBar.setHeight(this.scroller.clientHeight);

            if (this.session) {
                this.scrollToY(this.getScrollTop());
                changes = changes | this.CHANGE_FULL;
            }
        }

        var width = dom.getInnerWidth(this.container);
        if (force || this.$size.width != width) {
            this.$size.width = width;

            var gutterWidth = this.showGutter ? this.$gutter.offsetWidth : 0;
            this.scroller.style.left = gutterWidth + "px";
            this.scroller.style.width = Math.max(0, width - gutterWidth - this.scrollBar.getWidth()) + "px";

            if (this.session.getUseWrapMode()) {
                var availableWidth = this.scroller.clientWidth - this.$padding * 2;
                var limit = Math.floor(availableWidth / this.characterWidth) - 1;
                if (this.session.adjustWrapLimit(limit) || force) {
                    changes = changes | this.CHANGE_FULL;
                }
            }
        }

        this.$size.scrollerWidth = this.scroller.clientWidth;
        this.$size.scrollerHeight = this.scroller.clientHeight;
        this.$loop.schedule(changes);
    };

    this.$onGutterClick = function(e) {
        var pageX = event.getDocumentX(e);
        var pageY = event.getDocumentY(e);

        this._dispatchEvent("gutter" + e.type, {
            row: this.screenToTextCoordinates(pageX, pageY).row,
            htmlEvent: e
        });
    };

    this.setShowInvisibles = function(showInvisibles) {
        if (this.$textLayer.setShowInvisibles(showInvisibles))
            this.$loop.schedule(this.CHANGE_TEXT);
    };

    this.getShowInvisibles = function() {
        return this.$textLayer.showInvisibles;
    };

    this.$showPrintMargin = true;
    this.setShowPrintMargin = function(showPrintMargin) {
        this.$showPrintMargin = showPrintMargin;
        this.$updatePrintMargin();
    };

    this.getShowPrintMargin = function() {
        return this.$showPrintMargin;
    };

    this.$printMarginColumn = 80;
    this.setPrintMarginColumn = function(showPrintMargin) {
        this.$printMarginColumn = showPrintMargin;
        this.$updatePrintMargin();
    };

    this.getPrintMarginColumn = function() {
        return this.$printMarginColumn;
    };

    this.getShowGutter = function(){
        return this.showGutter;
    };

    this.setShowGutter = function(show){
        if(this.showGutter === show)
            return;
        this.$gutter.style.display = show ? "block" : "none";
        this.showGutter = show;
        this.onResize(true);
    };

    this.$updatePrintMargin = function() {
        var containerEl;

        if (!this.$showPrintMargin && !this.$printMarginEl)
            return;

        if (!this.$printMarginEl) {
            containerEl = dom.createElement("div");
            containerEl.className = "ace_print_margin_layer";
            this.$printMarginEl = dom.createElement("div");
            this.$printMarginEl.className = "ace_print_margin";
            containerEl.appendChild(this.$printMarginEl);
            this.content.insertBefore(containerEl, this.$textLayer.element);
        }

        var style = this.$printMarginEl.style;
        style.left = ((this.characterWidth * this.$printMarginColumn) + this.$padding * 2) + "px";
        style.visibility = this.$showPrintMargin ? "visible" : "hidden";
    };

    this.getContainerElement = function() {
        return this.container;
    };

    this.getMouseEventTarget = function() {
        return this.content;
    };

    this.getTextAreaContainer = function() {
        return this.container;
    };

    this.moveTextAreaToCursor = function(textarea) {
        // in IE the native cursor always shines through
        if (useragent.isIE)
            return;

        var pos = this.$cursorLayer.getPixelPosition();
        if (!pos)
            return;

        var bounds = this.content.getBoundingClientRect();
        var offset = (this.layerConfig && this.layerConfig.offset) || 0;

        textarea.style.left = (bounds.left + pos.left + this.$padding) + "px";
        textarea.style.top = (bounds.top + pos.top - this.scrollTop + offset) + "px";
    };

    this.getFirstVisibleRow = function() {
        return (this.layerConfig || {}).firstRow || 0;
    };

    this.getFirstFullyVisibleRow = function(){
        if (!this.layerConfig)
            return 0;

        return this.layerConfig.firstRow + (this.layerConfig.offset === 0 ? 0 : 1);
    };

    this.getLastFullyVisibleRow = function() {
        if (!this.layerConfig)
            return 0;

        var flint = Math.floor((this.layerConfig.height + this.layerConfig.offset) / this.layerConfig.lineHeight);
        return this.layerConfig.firstRow - 1 + flint;
    };

    this.getLastVisibleRow = function() {
        return (this.layerConfig || {}).lastRow || 0;
    };

    this.$padding = null;
    this.setPadding = function(padding) {
        this.$padding = padding;
        this.content.style.padding = "0 " + padding + "px";
        this.$loop.schedule(this.CHANGE_FULL);
        this.$updatePrintMargin();
    };

    this.getHScrollBarAlwaysVisible = function() {
        return this.$horizScrollAlwaysVisible;
    };

    this.setHScrollBarAlwaysVisible = function(alwaysVisible) {
        if (this.$horizScrollAlwaysVisible != alwaysVisible) {
            this.$horizScrollAlwaysVisible = alwaysVisible;
            if (!this.$horizScrollAlwaysVisible || !this.$horizScroll)
                this.$loop.schedule(this.CHANGE_SCROLL);
        }
    };

    this.onScroll = function(e) {
        this.scrollToY(e.data);
    };

    this.$updateScrollBar = function() {
        this.scrollBar.setInnerHeight(this.layerConfig.maxHeight);
        this.scrollBar.setScrollTop(this.scrollTop);
    };

    this.$renderChanges = function(changes) {
        if (!changes || !this.session)
            return;

        // text, scrolling and resize changes can cause the view port size to change
        if (!this.layerConfig ||
            changes & this.CHANGE_FULL ||
            changes & this.CHANGE_SIZE ||
            changes & this.CHANGE_TEXT ||
            changes & this.CHANGE_LINES ||
            changes & this.CHANGE_SCROLL
        )
            this.$computeLayerConfig();

        // full
        if (changes & this.CHANGE_FULL) {
            this.$textLayer.update(this.layerConfig);
            if (this.showGutter)
                this.$gutterLayer.update(this.layerConfig);
            this.$markerBack.update(this.layerConfig);
            this.$markerFront.update(this.layerConfig);
            this.$cursorLayer.update(this.layerConfig);
            this.$updateScrollBar();
            return;
        }

        // scrolling
        if (changes & this.CHANGE_SCROLL) {
            if (changes & this.CHANGE_TEXT || changes & this.CHANGE_LINES)
                this.$textLayer.update(this.layerConfig);
            else
                this.$textLayer.scrollLines(this.layerConfig);
                
            if (this.showGutter)
                this.$gutterLayer.update(this.layerConfig);
            this.$markerBack.update(this.layerConfig);
            this.$markerFront.update(this.layerConfig);
            this.$cursorLayer.update(this.layerConfig);
            this.$updateScrollBar();
            return;
        }

        if (changes & this.CHANGE_TEXT) {
            this.$textLayer.update(this.layerConfig);
            if (this.showGutter)
                this.$gutterLayer.update(this.layerConfig);
        }
        else if (changes & this.CHANGE_LINES) {
            this.$updateLines();
            this.$updateScrollBar();
            if (this.showGutter)
                this.$gutterLayer.update(this.layerConfig);
        } else if (changes & this.CHANGE_GUTTER) {
            if (this.showGutter)
                this.$gutterLayer.update(this.layerConfig);
        }

        if (changes & this.CHANGE_CURSOR)
            this.$cursorLayer.update(this.layerConfig);

        if (changes & (this.CHANGE_MARKER | this.CHANGE_MARKER_FRONT)) {
            this.$markerFront.update(this.layerConfig);
        }

        if (changes & (this.CHANGE_MARKER | this.CHANGE_MARKER_BACK)) {
            this.$markerBack.update(this.layerConfig);
        }

        if (changes & this.CHANGE_SIZE)
            this.$updateScrollBar();
    };

    this.$computeLayerConfig = function() {
        var session = this.session;

        var offset = this.scrollTop % this.lineHeight;
        var minHeight = this.$size.scrollerHeight + this.lineHeight;

        var longestLine = this.$getLongestLine();
        var widthChanged = !this.layerConfig ? true : (this.layerConfig.width != longestLine);

        var horizScroll = this.$horizScrollAlwaysVisible || this.$size.scrollerWidth - longestLine < 0;
        var horizScrollChanged = this.$horizScroll !== horizScroll;
        this.$horizScroll = horizScroll;
        if (horizScrollChanged)
            this.scroller.style.overflowX = horizScroll ? "scroll" : "hidden";

        var maxHeight = this.session.getScreenLength() * this.lineHeight;
        this.scrollTop = Math.max(0, Math.min(this.scrollTop, maxHeight - this.$size.scrollerHeight));

        var lineCount = Math.ceil(minHeight / this.lineHeight) - 1;
        var firstRow = Math.max(0, Math.round((this.scrollTop - offset) / this.lineHeight));
        var lastRow = firstRow + lineCount;

        // Map lines on the screen to lines in the document.
        var firstRowScreen, firstRowHeight;
        var lineHeight = { lineHeight: this.lineHeight };
        firstRow = session.screenToDocumentRow(firstRow, 0);

        // Check if firstRow is inside of a foldLine. If true, then use the first
        // row of the foldLine.
        var foldLine = session.getFoldLine(firstRow);
        if (foldLine) {
            firstRow = foldLine.start.row;
        }

        firstRowScreen = session.documentToScreenRow(firstRow, 0);
        firstRowHeight = session.getRowHeight(lineHeight, firstRow);

        lastRow = Math.min(session.screenToDocumentRow(lastRow, 0), session.getLength() - 1);
        minHeight = this.$size.scrollerHeight + session.getRowHeight(lineHeight, lastRow)+
                                                firstRowHeight;

        offset = this.scrollTop - firstRowScreen * this.lineHeight;

        this.layerConfig = {
            width : longestLine,
            padding : this.$padding,
            firstRow : firstRow,
            firstRowScreen: firstRowScreen,
            lastRow : lastRow,
            lineHeight : this.lineHeight,
            characterWidth : this.characterWidth,
            minHeight : minHeight,
            maxHeight : maxHeight,
            offset : offset,
            height : this.$size.scrollerHeight
        };

        // For debugging.
        // console.log(JSON.stringify(this.layerConfig));

        this.$gutterLayer.element.style.marginTop = (-offset) + "px";
        this.content.style.marginTop = (-offset) + "px";
        this.content.style.width = longestLine + "px";
        this.content.style.height = minHeight + "px";

        // scroller.scrollWidth was smaller than scrollLeft we needed
        if (this.$desiredScrollLeft) {
            this.scrollToX(this.$desiredScrollLeft);
            this.$desiredScrollLeft = 0;
        }

        // Horizontal scrollbar visibility may have changed, which changes
        // the client height of the scroller
        if (horizScrollChanged)
            this.onResize(true);
    };

    this.$updateLines = function() {
        var firstRow = this.$changedLines.firstRow;
        var lastRow = this.$changedLines.lastRow;
        this.$changedLines = null;

        var layerConfig = this.layerConfig;

        // if the update changes the width of the document do a full redraw
        if (layerConfig.width != this.$getLongestLine())
            return this.$textLayer.update(layerConfig);

        if (firstRow > layerConfig.lastRow + 1) { return; }
        if (lastRow < layerConfig.firstRow) { return; }

        // if the last row is unknown -> redraw everything
        if (lastRow === Infinity) {
            if (this.showGutter)
                this.$gutterLayer.update(layerConfig);
            this.$textLayer.update(layerConfig);
            return;
        }

        // else update only the changed rows
        this.$textLayer.updateLines(layerConfig, firstRow, lastRow);
    };

    this.$getLongestLine = function() {
        var charCount = this.session.getScreenWidth() + 1;
        if (this.$textLayer.showInvisibles)
            charCount += 1;

        return Math.max(this.$size.scrollerWidth - this.$padding * 2, Math.round(charCount * this.characterWidth));
    };

    this.updateFrontMarkers = function() {
        this.$markerFront.setMarkers(this.session.getMarkers(true));
        this.$loop.schedule(this.CHANGE_MARKER_FRONT);
    };

    this.updateBackMarkers = function() {
        this.$markerBack.setMarkers(this.session.getMarkers());
        this.$loop.schedule(this.CHANGE_MARKER_BACK);
    };

    this.addGutterDecoration = function(row, className){
        this.$gutterLayer.addGutterDecoration(row, className);
        this.$loop.schedule(this.CHANGE_GUTTER);
    };

    this.removeGutterDecoration = function(row, className){
        this.$gutterLayer.removeGutterDecoration(row, className);
        this.$loop.schedule(this.CHANGE_GUTTER);
    };

    this.setBreakpoints = function(rows) {
        this.$gutterLayer.setBreakpoints(rows);
        this.$loop.schedule(this.CHANGE_GUTTER);
    };

    this.setAnnotations = function(annotations) {
        this.$gutterLayer.setAnnotations(annotations);
        this.$loop.schedule(this.CHANGE_GUTTER);
    };

    this.updateCursor = function() {
        this.$loop.schedule(this.CHANGE_CURSOR);
    };

    this.hideCursor = function() {
        this.$cursorLayer.hideCursor();
    };

    this.showCursor = function() {
        this.$cursorLayer.showCursor();
    };

    this.scrollCursorIntoView = function() {
        // the editor is not visible
        if (this.$size.scrollerHeight === 0)
            return;

        var pos = this.$cursorLayer.getPixelPosition();

        var left = pos.left + this.$padding;
        var top = pos.top;

        if (this.scrollTop > top) {
            this.scrollToY(top);
        }

        if (this.scrollTop + this.$size.scrollerHeight < top + this.lineHeight) {
            this.scrollToY(top + this.lineHeight - this.$size.scrollerHeight);
        }

        var scrollLeft = this.scroller.scrollLeft;

        if (scrollLeft > left) {
            this.scrollToX(left);
        }

        if (scrollLeft + this.$size.scrollerWidth < left + this.characterWidth) {
            if (left > this.layerConfig.width)
                this.$desiredScrollLeft = left + 2 * this.characterWidth;
            else
                this.scrollToX(Math.round(left + this.characterWidth - this.$size.scrollerWidth));
        }
    };

    this.getScrollTop = function() {
        return this.scrollTop;
    };

    this.getScrollLeft = function() {
        return this.scroller.scrollLeft;
    };

    this.getScrollTopRow = function() {
        return this.scrollTop / this.lineHeight;
    };

    this.getScrollBottomRow = function() {
        return Math.max(0, Math.floor((this.scrollTop + this.$size.scrollerHeight) / this.lineHeight) - 1);
    };

    this.scrollToRow = function(row) {
        this.scrollToY(row * this.lineHeight);
    };

    this.scrollToLine = function(line, center) {
        var lineHeight = { lineHeight: this.lineHeight };
        var offset = 0;
        for (var l = 1; l < line; l++) {
            offset += this.session.getRowHeight(lineHeight, l-1);
        }

        if (center) {
            offset -= this.$size.scrollerHeight / 2;
        }
        this.scrollToY(offset);
    };

    this.scrollToY = function(scrollTop) {
        // after calling scrollBar.setScrollTop
        // scrollbar sends us event with same scrollTop. ignore it
        scrollTop = Math.max(0, scrollTop);
        if (this.scrollTop !== scrollTop) {
            this.$loop.schedule(this.CHANGE_SCROLL);
            this.scrollTop = scrollTop;
        }
    };

    this.scrollToX = function(scrollLeft) {
        if (scrollLeft <= this.$padding)
            scrollLeft = 0;

        this.scroller.scrollLeft = scrollLeft;
    };

    this.scrollBy = function(deltaX, deltaY) {
        deltaY && this.scrollToY(this.scrollTop + deltaY);
        deltaX && this.scrollToX(this.scroller.scrollLeft + deltaX);
    };

    this.screenToTextCoordinates = function(pageX, pageY) {
        var canvasPos = this.scroller.getBoundingClientRect();

        var col = Math.round((pageX + this.scroller.scrollLeft - canvasPos.left - this.$padding - dom.getPageScrollLeft())
                / this.characterWidth);
        var row = Math.floor((pageY + this.scrollTop - canvasPos.top - dom.getPageScrollTop())
                / this.lineHeight);

        return this.session.screenToDocumentPosition(row, Math.max(col, 0));
    };

    this.textToScreenCoordinates = function(row, column) {
        var canvasPos = this.scroller.getBoundingClientRect();
        var pos = this.session.documentToScreenPosition(row, column);

        var x = this.$padding + Math.round(pos.column * this.characterWidth);
        var y = pos.row * this.lineHeight;

        return {
            pageX: canvasPos.left + x - this.getScrollLeft(),
            pageY: canvasPos.top + y - this.getScrollTop()
        };
    };

    this.visualizeFocus = function() {
        dom.addCssClass(this.container, "ace_focus");
    };

    this.visualizeBlur = function() {
        dom.removeCssClass(this.container, "ace_focus");
    };

    this.showComposition = function(position) {
        if (!this.$composition) {
            this.$composition = dom.createElement("div");
            this.$composition.className = "ace_composition";
            this.content.appendChild(this.$composition);
        }

        this.$composition.innerHTML = "&#160;";

        var pos = this.$cursorLayer.getPixelPosition();
        var style = this.$composition.style;
        style.top = pos.top + "px";
        style.left = (pos.left + this.$padding) + "px";
        style.height = this.lineHeight + "px";

        this.hideCursor();
    };

    this.setCompositionText = function(text) {
        dom.setInnerText(this.$composition, text);
    };

    this.hideComposition = function() {
        this.showCursor();

        if (!this.$composition)
            return;

        var style = this.$composition.style;
        style.top = "-10000px";
        style.left = "-10000px";
    };

    this.setTheme = function(theme) {
        var _self = this;
        
        this.$themeValue = theme;
        if (!theme || typeof theme == "string") {
            theme = theme || "ace/theme/textmate";
            require([theme], function(theme) {
                afterLoad(theme);
            });
        } else {
            afterLoad(theme);
        }

        function afterLoad(theme) {
            if (_self.$theme)
                dom.removeCssClass(_self.container, _self.$theme);

            _self.$theme = theme ? theme.cssClass : null;

            if (_self.$theme)
                dom.addCssClass(_self.container, _self.$theme);

            // force re-measure of the gutter width
            if (_self.$size) {
                _self.$size.width = 0;
                _self.onResize();
            }
        }
    };

    this.getTheme = function() {
        return this.$themeValue;
    };

    // Methods allows to add / remove CSS classnames to the editor element.
    // This feature can be used by plug-ins to provide a visual indication of
    // a certain mode that editor is in.

    this.setStyle = function setStyle(style) {
      dom.addCssClass(this.container, style);
    };

    this.unsetStyle = function unsetStyle(style) {
      dom.removeCssClass(this.container, style);
    };

    this.destroy = function() {
        this.$textLayer.destroy();
        this.$cursorLayer.destroy();
    };

}).call(VirtualRenderer.prototype);

exports.VirtualRenderer = VirtualRenderer;
});
/* vim:ts=4:sts=4:sw=4:
 * ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *      Julian Viereck <julian DOT viereck AT gmail DOT com>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('ace/layer/gutter', ['require', 'exports', 'module' , 'pilot/dom'], function(require, exports, module) {

var dom = require("pilot/dom");

var Gutter = function(parentEl) {
    this.element = dom.createElement("div");
    this.element.className = "ace_layer ace_gutter-layer";
    parentEl.appendChild(this.element);

    this.$breakpoints = [];
    this.$annotations = [];
    this.$decorations = [];
};

(function() {

    this.setSession = function(session) {
        this.session = session;
    };

    this.addGutterDecoration = function(row, className){
        if (!this.$decorations[row])
            this.$decorations[row] = "";
        this.$decorations[row] += " ace_" + className;
    }

    this.removeGutterDecoration = function(row, className){
        this.$decorations[row] = this.$decorations[row].replace(" ace_" + className, "");
    };

    this.setBreakpoints = function(rows) {
        this.$breakpoints = rows.concat();
    };

    this.setAnnotations = function(annotations) {
        // iterate over sparse array
        this.$annotations = [];
        for (var row in annotations) if (annotations.hasOwnProperty(row)) {
            var rowAnnotations = annotations[row];
            if (!rowAnnotations)
                continue;

            var rowInfo = this.$annotations[row] = {
                text: []
            };
            for (var i=0; i<rowAnnotations.length; i++) {
                var annotation = rowAnnotations[i];
                rowInfo.text.push(annotation.text.replace(/"/g, "&quot;").replace(/'/g, "&#8217;").replace(/</, "&lt;"));
                var type = annotation.type;
                if (type == "error")
                    rowInfo.className = "ace_error";
                else if (type == "warning" && rowInfo.className != "ace_error")
                    rowInfo.className = "ace_warning";
                else if (type == "info" && (!rowInfo.className))
                    rowInfo.className = "ace_info";
            }
        }
    };

    this.update = function(config) {
        this.$config = config;

        var emptyAnno = {className: "", text: []};
        var html = [];
        var i = config.firstRow;
        var lastRow = config.lastRow;
        var fold = this.session.getNextFold(i);
        var foldStart = fold ? fold.start.row : Infinity;

        while (true) {
            if(i > foldStart) {
                i = fold.end.row + 1;
                fold = this.session.getNextFold(i);
                foldStart = fold ?fold.start.row :Infinity;
            }
            if(i > lastRow)
                break;

            var annotation = this.$annotations[i] || emptyAnno;
            html.push("<div class='ace_gutter-cell",
                this.$decorations[i] || "",
                this.$breakpoints[i] ? " ace_breakpoint " : " ",
                annotation.className,
                "' title='", annotation.text.join("\n"),
                "' style='height:", config.lineHeight, "px;'>", (i+1));

            var wrappedRowLength = this.session.getRowLength(i) - 1;
            while (wrappedRowLength--) {
                html.push("</div><div class='ace_gutter-cell' style='height:", config.lineHeight, "px'>&brvbar;</div>");
            }

            html.push("</div>");

            i++;
        }
        this.element = dom.setInnerHtml(this.element, html.join(""));
        this.element.style.height = config.minHeight + "px";
    };

}).call(Gutter.prototype);

exports.Gutter = Gutter;

});
/* vim:ts=4:sts=4:sw=4:
 * ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *      Julian Viereck <julian.viereck@gmail.com>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('ace/layer/marker', ['require', 'exports', 'module' , 'ace/range', 'pilot/dom'], function(require, exports, module) {

var Range = require("ace/range").Range;
var dom = require("pilot/dom");

var Marker = function(parentEl) {
    this.element = dom.createElement("div");
    this.element.className = "ace_layer ace_marker-layer";
    parentEl.appendChild(this.element);
};

(function() {

    this.setSession = function(session) {
        this.session = session;
    };
    
    this.setMarkers = function(markers) {
        this.markers = markers;
    };

    this.update = function(config) {
        var config = config || this.config;
        if (!config)
            return;

        this.config = config;

        var html = [];        
        for ( var key in this.markers) {
            var marker = this.markers[key];

            var range = marker.range.clipRows(config.firstRow, config.lastRow);
            if (range.isEmpty()) continue;

            range = range.toScreenRange(this.session);

            if (marker.renderer) {
                var top = this.$getTop(range.start.row, config);
                var left = Math.round(range.start.column * config.characterWidth);        
                marker.renderer(html, range, left, top, config);
            }
            else if (range.isMultiLine()) {
                if (marker.type == "text") {
                    this.drawTextMarker(html, range, marker.clazz, config);
                } else {
                    this.drawMultiLineMarker(html, range, marker.clazz, config);
                }
            }
            else {
                this.drawSingleLineMarker(html, range, marker.clazz, config);
            }
        }
        this.element = dom.setInnerHtml(this.element, html.join(""));
    };

    this.$getTop = function(row, layerConfig) {
        return (row - layerConfig.firstRowScreen) * layerConfig.lineHeight;
    };

    this.drawTextMarker = function(stringBuilder, range, clazz, layerConfig) {
        // selection start
        var row = range.start.row;

        var lineRange = new Range(row, range.start.column,
                                  row, this.session.getScreenLastRowColumn(row));
        this.drawSingleLineMarker(stringBuilder, lineRange, clazz, layerConfig, 1);

        // selection end
        var row = range.end.row;
        var lineRange = new Range(row, 0, row, range.end.column);
        this.drawSingleLineMarker(stringBuilder, lineRange, clazz, layerConfig);

        for (var row = range.start.row + 1; row < range.end.row; row++) {
            lineRange.start.row = row;
            lineRange.end.row = row;
            lineRange.end.column = this.session.getScreenLastRowColumn(row);
            this.drawSingleLineMarker(stringBuilder, lineRange, clazz, layerConfig, 1);
        }
    };

    this.drawMultiLineMarker = function(stringBuilder, range, clazz, layerConfig) {
        // from selection start to the end of the line
        var height = layerConfig.lineHeight;
        var width = Math.round(layerConfig.width - (range.start.column * layerConfig.characterWidth));
        var top = this.$getTop(range.start.row, layerConfig);
        var left = Math.round(range.start.column * layerConfig.characterWidth);

        stringBuilder.push(
            "<div class='", clazz, "' style='",
            "height:", height, "px;",
            "width:", width, "px;",
            "top:", top, "px;",
            "left:", left, "px;'></div>"
        );

        // from start of the last line to the selection end
        var top = this.$getTop(range.end.row, layerConfig);
        var width = Math.round(range.end.column * layerConfig.characterWidth);

        stringBuilder.push(
            "<div class='", clazz, "' style='",
            "height:", height, "px;",
            "top:", top, "px;",
            "width:", width, "px;'></div>"
        );

        // all the complete lines
        var height = (range.end.row - range.start.row - 1) * layerConfig.lineHeight;
        if (height < 0)
            return;
        var top = this.$getTop(range.start.row + 1, layerConfig);

        stringBuilder.push(
            "<div class='", clazz, "' style='",
            "height:", height, "px;",
            "width:", layerConfig.width, "px;",
            "top:", top, "px;'></div>"
        );
    };

    this.drawSingleLineMarker = function(stringBuilder, range, clazz, layerConfig, extraLength) {
        var height = layerConfig.lineHeight;
        var width = Math.round((range.end.column + (extraLength || 0) - range.start.column) * layerConfig.characterWidth);
        var top = this.$getTop(range.start.row, layerConfig);
        var left = Math.round(range.start.column * layerConfig.characterWidth);

        stringBuilder.push(
            "<div class='", clazz, "' style='",
            "height:", height, "px;",
            "width:", width, "px;",
            "top:", top, "px;",
            "left:", left,"px;'></div>"
        );
    };

}).call(Marker.prototype);

exports.Marker = Marker;

});
/* vim:ts=4:sts=4:sw=4:
 * ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *      Julian Viereck <julian DOT viereck AT gmail DOT com>
 *      Mihai Sucan <mihai.sucan@gmail.com>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('ace/layer/text', ['require', 'exports', 'module' , 'pilot/oop', 'pilot/dom', 'pilot/lang', 'pilot/useragent', 'pilot/event_emitter'], function(require, exports, module) {

var oop = require("pilot/oop");
var dom = require("pilot/dom");
var lang = require("pilot/lang");
var useragent = require("pilot/useragent");
var EventEmitter = require("pilot/event_emitter").EventEmitter;

var Text = function(parentEl) {
    this.element = dom.createElement("div");
    this.element.className = "ace_layer ace_text-layer";
    parentEl.appendChild(this.element);

    this.$characterSize = this.$measureSizes() || {width: 0, height: 0};
    this.$pollSizeChanges();
};

(function() {

    oop.implement(this, EventEmitter);

    this.EOF_CHAR = "&para;";
    this.EOL_CHAR = "&not;";
    this.TAB_CHAR = "&rarr;";
    this.SPACE_CHAR = "&middot;";

    this.getLineHeight = function() {
        return this.$characterSize.height || 1;
    };

    this.getCharacterWidth = function() {
        return this.$characterSize.width || 1;
    };

    this.checkForSizeChanges = function() {
        var size = this.$measureSizes();
        if (size && (this.$characterSize.width !== size.width || this.$characterSize.height !== size.height)) {
            this.$characterSize = size;
            this._dispatchEvent("changeCharaterSize", {data: size});
        }
    };

    this.$pollSizeChanges = function() {
        var self = this;
        this.$pollSizeChangesTimer = setInterval(function() {
            self.checkForSizeChanges();
        }, 500);
    };

    this.$fontStyles = {
        fontFamily : 1,
        fontSize : 1,
        fontWeight : 1,
        fontStyle : 1,
        lineHeight : 1
    };

    this.$measureSizes = function() {
        var n = 1000;
        if (!this.$measureNode) {
            var measureNode = this.$measureNode = dom.createElement("div");
            var style = measureNode.style;

            style.width = style.height = "auto";
            style.left = style.top = (-n * 40)  + "px";

            style.visibility = "hidden";
            style.position = "absolute";
            style.overflow = "visible";
            style.whiteSpace = "nowrap";

            // in FF 3.6 monospace fonts can have a fixed sub pixel width.
            // that's why we have to measure many characters
            // Note: characterWidth can be a float!
            measureNode.innerHTML = lang.stringRepeat("Xy", n);

            if (document.body) {
                document.body.appendChild(measureNode);
            } else {
                var container = this.element.parentNode;
                while (!dom.hasCssClass(container, "ace_editor"))
                    container = container.parentNode;
                container.appendChild(measureNode);
            }

        }

        var style = this.$measureNode.style;
        var computedStyle = dom.computedStyle(this.element);
        for (var prop in this.$fontStyles)
            style[prop] = computedStyle[prop];

        var size = {
            height: this.$measureNode.offsetHeight,
            width: this.$measureNode.offsetWidth / (n * 2)
        };

        // Size and width can be null if the editor is not visible or
        // detached from the document
        if (size.width == 0 && size.height == 0)
            return null;

        return size;
    };

    this.setSession = function(session) {
        this.session = session;
    };

    this.showInvisibles = false;
    this.setShowInvisibles = function(showInvisibles) {
        if (this.showInvisibles == showInvisibles)
            return false;

        this.showInvisibles = showInvisibles;
        return true;
    };

    this.$tabStrings = [];
    this.$computeTabString = function() {
        var tabSize = this.session.getTabSize();
        var tabStr = this.$tabStrings = [0];
        for (var i = 1; i < tabSize + 1; i++) {
            if (this.showInvisibles) {
                tabStr.push("<span class='ace_invisible'>"
                    + this.TAB_CHAR
                    + new Array(i).join("&#160;")
                    + "</span>");
            } else {
                tabStr.push(new Array(i+1).join("&#160;"));
            }
        }

    };

    this.updateLines = function(config, firstRow, lastRow) {
        this.$computeTabString();
        // Due to wrap line changes there can be new lines if e.g.
        // the line to updated wrapped in the meantime.
        if (this.config.lastRow != config.lastRow ||
            this.config.firstRow != config.firstRow) {
            this.scrollLines(config);
        }
        this.config = config;

        var first = Math.max(firstRow, config.firstRow);
        var last = Math.min(lastRow, config.lastRow);

        var lineElements = this.element.childNodes,
            lineElementsIdx = 0;

        for (var row = config.firstRow; row < first; row++) {
            var foldLine = this.session.getFoldLine(row);
            if (foldLine) {
                if (foldLine.containsRow(first)) {
                    break;
                } else {
                    row = foldLine.end.row;
                }
            }
            lineElementsIdx ++;
        }

        for (var i=first; i<=last; i++) {
            var lineElement = lineElements[lineElementsIdx++];
            if (!lineElement)
                continue;

            var html = [];
            var tokens = this.session.getTokens(i, i);
            this.$renderLine(html, i, tokens[0].tokens);
            lineElement = dom.setInnerHtml(lineElement, html.join(""));

            i = this.session.getRowFoldEnd(i);
        }
    };

    this.scrollLines = function(config) {
        this.$computeTabString();
        var oldConfig = this.config;
        this.config = config;

        if (!oldConfig || oldConfig.lastRow < config.firstRow)
            return this.update(config);

        if (config.lastRow < oldConfig.firstRow)
            return this.update(config);

        var el = this.element;
        if (oldConfig.firstRow < config.firstRow)
            for (var row=this.session.getFoldedRowCount(oldConfig.firstRow, config.firstRow - 1); row>0; row--)
                el.removeChild(el.firstChild);

        if (oldConfig.lastRow > config.lastRow)
            for (var row=this.session.getFoldedRowCount(config.lastRow + 1, oldConfig.lastRow); row>0; row--)
                el.removeChild(el.lastChild);

        if (config.firstRow < oldConfig.firstRow) {
            var fragment = this.$renderLinesFragment(config, config.firstRow, oldConfig.firstRow - 1);
            if (el.firstChild)
                el.insertBefore(fragment, el.firstChild);
            else
                el.appendChild(fragment);
        }

        if (config.lastRow > oldConfig.lastRow) {
            var fragment = this.$renderLinesFragment(config, oldConfig.lastRow + 1, config.lastRow);
            el.appendChild(fragment);
        }
    };

    this.$renderLinesFragment = function(config, firstRow, lastRow) {
        var fragment = document.createDocumentFragment(),
            row = firstRow,
            fold = this.session.getNextFold(row),
            foldStart = fold ?fold.start.row :Infinity;

        while (true) {
            if(row > foldStart) {
                row = fold.end.row+1;
                fold = this.session.getNextFold(row);
                foldStart = fold ?fold.start.row :Infinity;
            }
            if(row > lastRow)
                break;

            var lineEl = dom.createElement("div");

            lineEl.className = "ace_line";

            var html = [];
            // Get the tokens per line as there might be some lines in between
            // beeing folded.
            // OPTIMIZE: If there is a long block of unfolded lines, just make
            // this call once for that big block of unfolded lines.
            var tokens = this.session.getTokens(row, row);
            if (tokens.length == 1)
                this.$renderLine(html, row, tokens[0].tokens);

            // don't use setInnerHtml since we are working with an empty DIV
            lineEl.innerHTML = html.join("");
            fragment.appendChild(lineEl);

            row++;
        }
        return fragment;
    };

    this.update = function(config) {
        this.$computeTabString();
        this.config = config;

        var html = [];
        var firstRow = config.firstRow, lastRow = config.lastRow;

        var row = firstRow,
            fold = this.session.getNextFold(row),
            foldStart = fold ?fold.start.row :Infinity;

        while (true) {
            if(row > foldStart) {
                row = fold.end.row+1;
                fold = this.session.getNextFold(row);
                foldStart = fold ?fold.start.row :Infinity;
            }
            if(row > lastRow)
                break;

            html.push("<div class='ace_line'>");
            // Get the tokens per line as there might be some lines in between
            // beeing folded.
            // OPTIMIZE: If there is a long block of unfolded lines, just make
            // this call once for that big block of unfolded lines.
            var tokens = this.session.getTokens(row, row);
            if (tokens.length == 1)
                this.$renderLine(html, row, tokens[0].tokens);
            html.push("</div>");

            row++;
        }
        this.element = dom.setInnerHtml(this.element, html.join(""));
    };

    this.$textToken = {
        "text": true,
        "rparen": true,
        "lparen": true
    };

    this.$renderToken = function(stringBuilder, screenColumn, token, value) {        
        var self = this;
        var replaceReg = /\t|&|<|( +)|([\v\f \u00a0\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u200b\u2028\u2029\u3000])|[\u1100-\u115F]|[\u11A3-\u11A7]|[\u11FA-\u11FF]|[\u2329-\u232A]|[\u2E80-\u2E99]|[\u2E9B-\u2EF3]|[\u2F00-\u2FD5]|[\u2FF0-\u2FFB]|[\u3000-\u303E]|[\u3041-\u3096]|[\u3099-\u30FF]|[\u3105-\u312D]|[\u3131-\u318E]|[\u3190-\u31BA]|[\u31C0-\u31E3]|[\u31F0-\u321E]|[\u3220-\u3247]|[\u3250-\u32FE]|[\u3300-\u4DBF]|[\u4E00-\uA48C]|[\uA490-\uA4C6]|[\uA960-\uA97C]|[\uAC00-\uD7A3]|[\uD7B0-\uD7C6]|[\uD7CB-\uD7FB]|[\uF900-\uFAFF]|[\uFE10-\uFE19]|[\uFE30-\uFE52]|[\uFE54-\uFE66]|[\uFE68-\uFE6B]|[\uFF01-\uFF60]|[\uFFE0-\uFFE6]/g;
        var replaceFunc = function(c, a, b, tabIdx, idx4) {
            if (c.charCodeAt(0) == 32) {
                return new Array(c.length+1).join("&#160;");
            } else if (c == "\t") {
                var tabSize = self.session.getScreenTabSize(screenColumn + tabIdx);
                screenColumn += tabSize - 1;
                return self.$tabStrings[tabSize];
            } else if (c == "&") {
                if (useragent.isOldGecko)
                    return "&";
                else
                    return "&amp;";
            } else if (c == "<") {
                return "&lt;";
            } else if (c.match(/[\v\f \u00a0\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u200b\u2028\u2029\u3000]/)) {
                if (self.showInvisibles) {
                    var space = new Array(c.length+1).join(self.SPACE_CHAR);
                    return "<span class='ace_invisible'>" + space + "</span>";
                } else {
                    return "&#160;";
                }
            } else {
                screenColumn += 1;
                return "<span class='ace_cjk' style='width:" +
                    (self.config.characterWidth * 2) +
                    "px'>" + c + "</span>";
            }
        };

        var output = value.replace(replaceReg, replaceFunc);

        if (!this.$textToken[token.type]) {
            var classes = "ace_" + token.type.replace(/\./g, " ace_");
            stringBuilder.push("<span class='", classes, "'>", output, "</span>");
        }
        else {
            stringBuilder.push(output);
        }
        return value.length;
    };

    this.$renderLineCore = function(stringBuilder, lastRow, tokens, splits) {
        var chars = 0,
            split = 0,
            splitChars,
            characterWidth = this.config.characterWidth,
            screenColumn = 0,
            self = this;

        function addToken(token, value) {
            screenColumn += self.$renderToken(
                stringBuilder, screenColumn, token, value);
        }

        if (!splits || splits.length == 0) {
            splitChars = Number.MAX_VALUE;
        } else {
            splitChars = splits[0];
        }

        stringBuilder.push("<div style='height:",
            this.config.lineHeight, "px",
            "'>");
        for (var i = 0; i < tokens.length; i++) {
            var token = tokens[i];
            var value = token.value;

            if (chars + value.length < splitChars) {
                addToken(token, value);
                chars += value.length;
            } else {
                while (chars + value.length >= splitChars) {
                    addToken(token, value.substring(0, splitChars - chars));
                    value = value.substring(splitChars - chars);
                    chars = splitChars;
                    stringBuilder.push("</div>",
                        "<div style='height:",
                        this.config.lineHeight, "px",
                        "'>");

                    split ++;
                    screenColumn = 0;
                    splitChars = splits[split] || Number.MAX_VALUE;
                }
                if (value.length != 0) {
                    chars += value.length;
                    addToken(token, value);
                }
            }
        }

        if (this.showInvisibles) {
            if (lastRow !== this.session.getLength() - 1) {
                stringBuilder.push("<span class='ace_invisible'>" + this.EOL_CHAR + "</span>");
            } else {
                stringBuilder.push("<span class='ace_invisible'>" + this.EOF_CHAR + "</span>");
            }
        }
        stringBuilder.push("</div>");
    };

    this.$renderLine = function(stringBuilder, row, tokens) {
        // Check if the line to render is folded or not. If not, things are
        // simple, otherwise, we need to fake some things...
        if (!this.session.isRowFolded(row)) {
            var splits = this.session.getRowSplitData(row);
            this.$renderLineCore(stringBuilder, row, tokens, splits);
        } else {
            this.$renderFoldLine(stringBuilder, row, tokens);
        }
    };

    this.$renderFoldLine = function(stringBuilder, row, tokens) {
        var session = this.session,
            foldLine = session.getFoldLine(row),
            renderTokens = [];

        function addTokens(tokens, from, to) {
            var idx = 0, col = 0;
            while ((col + tokens[idx].value.length) < from) {
                col += tokens[idx].value.length;
                idx++;

                if (idx == tokens.length) {
                    return;
                }
            }
            if (col != from) {
                var value = tokens[idx].value.substring(from - col);
                // Check if the token value is longer then the from...to spacing.
                if (value.length > (to - from)) {
                    value = value.substring(0, to - from);
                }

                renderTokens.push({
                    type: tokens[idx].type,
                    value: value
                });

                col = from + value.length;
                idx += 1;
            }

            while (col < to) {
                var value = tokens[idx].value;
                if (value.length + col > to) {
                    value = value.substring(0, to - col);
                }
                renderTokens.push({
                    type: tokens[idx].type,
                    value: value
                });
                col += value.length;
                idx += 1;
            }
        }

        foldLine.walk(function(placeholder, row, column, lastColumn, isNewRow) {
            if (placeholder) {
               renderTokens.push({
                    type: "fold",
                    value: placeholder
                });
            } else {
                if (isNewRow) {
                   tokens = this.session.getTokens(row, row)[0].tokens;
                }
                if (tokens.length != 0) {
                    addTokens(tokens, lastColumn, column);
                }
            }
        }.bind(this), foldLine.end.row, this.session.getLine(foldLine.end.row).length);

        // TODO: Build a fake splits array!
        var splits = this.session.$useWrapMode?this.session.$wrapData[row]:null;
        this.$renderLineCore(stringBuilder, row, renderTokens, splits);
    };

    this.destroy = function() {
        clearInterval(this.$pollSizeChangesTimer);
    };

}).call(Text.prototype);

exports.Text = Text;

});
/* vim:ts=4:sts=4:sw=4:
 * ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *      Julian Viereck <julian.viereck@gmail.com>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('ace/layer/cursor', ['require', 'exports', 'module' , 'pilot/dom'], function(require, exports, module) {

var dom = require("pilot/dom");

var Cursor = function(parentEl) {
    this.element = dom.createElement("div");
    this.element.className = "ace_layer ace_cursor-layer";
    parentEl.appendChild(this.element);

    this.cursor = dom.createElement("div");
    this.cursor.className = "ace_cursor ace_hidden";
    this.element.appendChild(this.cursor);

    this.isVisible = false;
};

(function() {

    this.setSession = function(session) {
        this.session = session;
    };

    this.hideCursor = function() {
        this.isVisible = false;
        dom.addCssClass(this.cursor, "ace_hidden");
        clearInterval(this.blinkId);
    };

    this.showCursor = function() {
        this.isVisible = true;   
        dom.removeCssClass(this.cursor, "ace_hidden");
        this.cursor.style.visibility = "visible";
        this.restartTimer();
    };

    this.restartTimer = function() {
        clearInterval(this.blinkId);
        if (!this.isVisible) {
            return;
        }

        var cursor = this.cursor;
        this.blinkId = setInterval(function() {
            cursor.style.visibility = "hidden";
            setTimeout(function() {
                cursor.style.visibility = "visible";
            }, 400);
        }, 1000);
    };

    this.getPixelPosition = function(onScreen) {
        if (!this.config || !this.session) {
            return {
                left : 0,
                top : 0
            };
        }

        var position = this.session.selection.getCursor();
        var pos = this.session.documentToScreenPosition(position);
        var cursorLeft = Math.round(pos.column * this.config.characterWidth);
        var cursorTop = (pos.row - (onScreen ? this.config.firstRowScreen : 0)) *
            this.config.lineHeight;

        return {
            left : cursorLeft,
            top : cursorTop
        };
    };

    this.update = function(config) {
        this.config = config;

        this.pixelPos = this.getPixelPosition(true);

        this.cursor.style.left = this.pixelPos.left + "px";
        this.cursor.style.top =  this.pixelPos.top + "px";
        this.cursor.style.width = config.characterWidth + "px";
        this.cursor.style.height = config.lineHeight + "px";

        var overwrite = this.session.getOverwrite()
        if (overwrite != this.overwrite) {
            this.overwrite = overwrite;
            if (overwrite)
                dom.addCssClass(this.cursor, "ace_overwrite");
            else
                dom.removeCssClass(this.cursor, "ace_overwrite");
        }

        this.restartTimer();
    };

    this.destroy = function() {
        clearInterval(this.blinkId);
    }

}).call(Cursor.prototype);

exports.Cursor = Cursor;

});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('ace/scrollbar', ['require', 'exports', 'module' , 'pilot/oop', 'pilot/dom', 'pilot/event', 'pilot/event_emitter'], function(require, exports, module) {

var oop = require("pilot/oop");
var dom = require("pilot/dom");
var event = require("pilot/event");
var EventEmitter = require("pilot/event_emitter").EventEmitter;

var ScrollBar = function(parent) {
    this.element = dom.createElement("div");
    this.element.className = "ace_sb";

    this.inner = dom.createElement("div");
    this.element.appendChild(this.inner);

    parent.appendChild(this.element);

    this.width = dom.scrollbarWidth();
    this.element.style.width = this.width + "px";

    event.addListener(this.element, "scroll", this.onScroll.bind(this));
};

(function() {
    oop.implement(this, EventEmitter);

    this.onScroll = function() {
        this._dispatchEvent("scroll", {data: this.element.scrollTop});
    };

    this.getWidth = function() {
        return this.width;
    };

    this.setHeight = function(height) {
        this.element.style.height = height + "px";
    };

    this.setInnerHeight = function(height) {
        this.inner.style.height = height + "px";
    };

    this.setScrollTop = function(scrollTop) {
        this.element.scrollTop = scrollTop;
    };

}).call(ScrollBar.prototype);

exports.ScrollBar = ScrollBar;
});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('ace/renderloop', ['require', 'exports', 'module' , 'pilot/event'], function(require, exports, module) {

var event = require("pilot/event");

var RenderLoop = function(onRender) {
    this.onRender = onRender;
    this.pending = false;
    this.changes = 0;
};

(function() {

    this.schedule = function(change) {
        //this.onRender(change);
        //return;
        this.changes = this.changes | change;
        if (!this.pending) {
            this.pending = true;
            var _self = this;
            this.setTimeoutZero(function() {
                _self.pending = false;
                var changes = _self.changes;
                _self.changes = 0;
                _self.onRender(changes);
            })
        }
    };

    this.setTimeoutZero = window.requestAnimationFrame ||
         window.webkitRequestAnimationFrame ||
         window.mozRequestAnimationFrame ||
         window.oRequestAnimationFrame ||
         window.msRequestAnimationFrame;

    if (this.setTimeoutZero) {

        this.setTimeoutZero = this.setTimeoutZero.bind(window)
    } else if (window.postMessage) {

        this.messageName = "zero-timeout-message";

        this.setTimeoutZero = function(callback) {
            if (!this.attached) {
                var _self = this;
                event.addListener(window, "message", function(e) {
                    if (_self.callback && e.data == _self.messageName) {
                        event.stopPropagation(e);
                        _self.callback();
                    }
                });
                this.attached = true;
            }
            this.callback = callback;
            window.postMessage(this.messageName, "*");
        }

    } else {

        this.setTimeoutZero = function(callback) {
            setTimeout(callback, 0);
        }
    }

}).call(RenderLoop.prototype);

exports.RenderLoop = RenderLoop;
});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Ajax.org Code Editor (ACE).
 *
 * The Initial Developer of the Original Code is
 * Ajax.org B.V.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Fabian Jakobs <fabian AT ajax DOT org>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('ace/theme/textmate', ['require', 'exports', 'module' , 'pilot/dom'], function(require, exports, module) {

    var dom = require("pilot/dom");

    var cssText = ".ace-tm .ace_editor {\
  border: 2px solid rgb(159, 159, 159);\
}\
\
.ace-tm .ace_editor.ace_focus {\
  border: 2px solid #327fbd;\
}\
\
.ace-tm .ace_gutter {\
  width: 50px;\
  background: #e8e8e8;\
  color: #333;\
  overflow : hidden;\
}\
\
.ace-tm .ace_gutter-layer {\
  width: 100%;\
  text-align: right;\
}\
\
.ace-tm .ace_gutter-layer .ace_gutter-cell {\
  padding-right: 6px;\
}\
\
.ace-tm .ace_print_margin {\
  width: 1px;\
  background: #e8e8e8;\
}\
\
.ace-tm .ace_text-layer {\
  cursor: text;\
}\
\
.ace-tm .ace_cursor {\
  border-left: 2px solid black;\
}\
\
.ace-tm .ace_cursor.ace_overwrite {\
  border-left: 0px;\
  border-bottom: 1px solid black;\
}\
        \
.ace-tm .ace_line .ace_invisible {\
  color: rgb(191, 191, 191);\
}\
\
.ace-tm .ace_line .ace_keyword {\
  color: blue;\
}\
\
.ace-tm .ace_line .ace_constant.ace_buildin {\
  color: rgb(88, 72, 246);\
}\
\
.ace-tm .ace_line .ace_constant.ace_language {\
  color: rgb(88, 92, 246);\
}\
\
.ace-tm .ace_line .ace_constant.ace_library {\
  color: rgb(6, 150, 14);\
}\
\
.ace-tm .ace_line .ace_invalid {\
  background-color: rgb(153, 0, 0);\
  color: white;\
}\
\
.ace-tm .ace_line .ace_fold {\
    background-color: #E4E4E4;\
    border-radius: 3px;\
}\
\
.ace-tm .ace_line .ace_support.ace_function {\
  color: rgb(60, 76, 114);\
}\
\
.ace-tm .ace_line .ace_support.ace_constant {\
  color: rgb(6, 150, 14);\
}\
\
.ace-tm .ace_line .ace_support.ace_type,\
.ace-tm .ace_line .ace_support.ace_class {\
  color: rgb(109, 121, 222);\
}\
\
.ace-tm .ace_line .ace_keyword.ace_operator {\
  color: rgb(104, 118, 135);\
}\
\
.ace-tm .ace_line .ace_string {\
  color: rgb(3, 106, 7);\
}\
\
.ace-tm .ace_line .ace_comment {\
  color: rgb(76, 136, 107);\
}\
\
.ace-tm .ace_line .ace_comment.ace_doc {\
  color: rgb(0, 102, 255);\
}\
\
.ace-tm .ace_line .ace_comment.ace_doc.ace_tag {\
  color: rgb(128, 159, 191);\
}\
\
.ace-tm .ace_line .ace_constant.ace_numeric {\
  color: rgb(0, 0, 205);\
}\
\
.ace-tm .ace_line .ace_variable {\
  color: rgb(49, 132, 149);\
}\
\
.ace-tm .ace_line .ace_xml_pe {\
  color: rgb(104, 104, 91);\
}\
\
.ace-tm .ace_marker-layer .ace_selection {\
  background: rgb(181, 213, 255);\
}\
\
.ace-tm .ace_marker-layer .ace_step {\
  background: rgb(252, 255, 0);\
}\
\
.ace-tm .ace_marker-layer .ace_stack {\
  background: rgb(164, 229, 101);\
}\
\
.ace-tm .ace_marker-layer .ace_bracket {\
  margin: -1px 0 0 -1px;\
  border: 1px solid rgb(192, 192, 192);\
}\
\
.ace-tm .ace_marker-layer .ace_active_line {\
  background: rgb(232, 242, 254);\
}\
\
.ace-tm .ace_marker-layer .ace_selected_word {\
  background: rgb(250, 250, 255);\
  border: 1px solid rgb(200, 200, 250);\
}\
\
.ace-tm .ace_string.ace_regex {\
  color: rgb(255, 0, 0)\
}";

    // import CSS once
    dom.importCssString(cssText);

    exports.cssClass = "ace-tm";
});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is DomTemplate.
 *
 * The Initial Developer of the Original Code is Mozilla.
 * Portions created by the Initial Developer are Copyright (C) 2009
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Joe Walker (jwalker@mozilla.com) (original author)
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('pilot/environment', ['require', 'exports', 'module' , 'pilot/settings'], function(require, exports, module) {


var settings = require("pilot/settings").settings;

/**
 * Create an environment object
 */
function create() {
    return {
        settings: settings
    };
};

exports.create = create;


});
define("text/ace/css/editor.css", [], ".ace_editor {" +
  "    position: absolute;" +
  "    overflow: hidden;" +
  "" +
  "    font-family: \"Menlo\", \"Monaco\", \"Courier New\", monospace;" +
  "    font-size: 12px;" +
  "}" +
  "" +
  ".ace_scroller {" +
  "    position: absolute;" +
  "    overflow-x: scroll;" +
  "    overflow-y: hidden;" +
  "}" +
  "" +
  ".ace_content {" +
  "    position: absolute;" +
  "    box-sizing: border-box;" +
  "    -moz-box-sizing: border-box;" +
  "    -webkit-box-sizing: border-box;" +
  "}" +
  "" +
  ".ace_composition {" +
  "    position: absolute;" +
  "    background: #555;" +
  "    color: #DDD;" +
  "    z-index: 4;" +
  "}" +
  "" +
  ".ace_gutter {" +
  "    position: absolute;" +
  "    overflow-x: hidden;" +
  "    overflow-y: hidden;" +
  "    height: 100%;" +
  "}" +
  "" +
  ".ace_gutter-cell.ace_error {" +
  "    background-image: url(\"data:image/gif,GIF89a%10%00%10%00%D5%00%00%F5or%F5%87%88%F5nr%F4ns%EBmq%F5z%7F%DDJT%DEKS%DFOW%F1Yc%F2ah%CE(7%CE)8%D18E%DD%40M%F2KZ%EBU%60%F4%60m%DCir%C8%16(%C8%19*%CE%255%F1%3FR%F1%3FS%E6%AB%B5%CA%5DI%CEn%5E%F7%A2%9A%C9G%3E%E0a%5B%F7%89%85%F5yy%F6%82%80%ED%82%80%FF%BF%BF%E3%C4%C4%FF%FF%FF%FF%FF%FF%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00!%F9%04%01%00%00%25%00%2C%00%00%00%00%10%00%10%00%00%06p%C0%92pH%2C%1A%8F%C8%D2H%93%E1d4%23%E4%88%D3%09mB%1DN%B48%F5%90%40%60%92G%5B%94%20%3E%22%D2%87%24%FA%20%24%C5%06A%00%20%B1%07%02B%A38%89X.v%17%82%11%13q%10%0Fi%24%0F%8B%10%7BD%12%0Ei%09%92%09%0EpD%18%15%24%0A%9Ci%05%0C%18F%18%0B%07%04%01%04%06%A0H%18%12%0D%14%0D%12%A1I%B3%B4%B5IA%00%3B\");" +
  "    background-repeat: no-repeat;" +
  "    background-position: 4px center;" +
  "}" +
  "" +
  ".ace_gutter-cell.ace_warning {" +
  "    background-image: url(\"data:image/gif,GIF89a%10%00%10%00%D5%00%00%FF%DBr%FF%DE%81%FF%E2%8D%FF%E2%8F%FF%E4%96%FF%E3%97%FF%E5%9D%FF%E6%9E%FF%EE%C1%FF%C8Z%FF%CDk%FF%D0s%FF%D4%81%FF%D5%82%FF%D5%83%FF%DC%97%FF%DE%9D%FF%E7%B8%FF%CCl%7BQ%13%80U%15%82W%16%81U%16%89%5B%18%87%5B%18%8C%5E%1A%94d%1D%C5%83-%C9%87%2F%C6%84.%C6%85.%CD%8B2%C9%871%CB%8A3%CD%8B5%DC%98%3F%DF%9BB%E0%9CC%E1%A5U%CB%871%CF%8B5%D1%8D6%DB%97%40%DF%9AB%DD%99B%E3%B0p%E7%CC%AE%FF%FF%FF%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00!%F9%04%01%00%00%2F%00%2C%00%00%00%00%10%00%10%00%00%06a%C0%97pH%2C%1A%8FH%A1%ABTr%25%87%2B%04%82%F4%7C%B9X%91%08%CB%99%1C!%26%13%84*iJ9(%15G%CA%84%14%01%1A%97%0C%03%80%3A%9A%3E%81%84%3E%11%08%B1%8B%20%02%12%0F%18%1A%0F%0A%03'F%1C%04%0B%10%16%18%10%0B%05%1CF%1D-%06%07%9A%9A-%1EG%1B%A0%A1%A0U%A4%A5%A6BA%00%3B\");" +
  "    background-repeat: no-repeat;" +
  "    background-position: 4px center;" +
  "}" +
  "" +
  ".ace_editor .ace_sb {" +
  "    position: absolute;" +
  "    overflow-x: hidden;" +
  "    overflow-y: scroll;" +
  "    right: 0;" +
  "}" +
  "" +
  ".ace_editor .ace_sb div {" +
  "    position: absolute;" +
  "    width: 1px;" +
  "    left: 0;" +
  "}" +
  "" +
  ".ace_editor .ace_print_margin_layer {" +
  "    z-index: 0;" +
  "    position: absolute;" +
  "    overflow: hidden;" +
  "    margin: 0;" +
  "    left: 0;" +
  "    height: 100%;" +
  "    width: 100%;" +
  "}" +
  "" +
  ".ace_editor .ace_print_margin {" +
  "    position: absolute;" +
  "    height: 100%;" +
  "}" +
  "" +
  ".ace_editor textarea {" +
  "    position: fixed;" +
  "    z-index: -1;" +
  "    width: 10px;" +
  "    height: 30px;" +
  "    opacity: 0;" +
  "    background: transparent;" +
  "    appearance: none;" +
  "    border: none;" +
  "    resize: none;" +
  "    outline: none;" +
  "    overflow: hidden;" +
  "}" +
  "" +
  ".ace_layer {" +
  "    z-index: 1;" +
  "    position: absolute;" +
  "    overflow: hidden;" +
  "    white-space: nowrap;" +
  "    height: 100%;" +
  "    width: 100%;" +
  "}" +
  "" +
  ".ace_text-layer {" +
  "    font-family: Monaco, \"Courier New\", monospace;" +
  "    color: black;" +
  "}" +
  "" +
  ".ace_cjk {" +
  "    display: inline-block;" +
  "    text-align: center;" +
  "}" +
  "" +
  ".ace_cursor-layer {" +
  "    z-index: 4;" +
  "    cursor: text;" +
  "    pointer-events: none;" +
  "}" +
  "" +
  ".ace_cursor {" +
  "    z-index: 4;" +
  "    position: absolute;" +
  "}" +
  "" +
  ".ace_cursor.ace_hidden {" +
  "    opacity: 0.2;" +
  "}" +
  "" +
  ".ace_line {" +
  "    white-space: nowrap;" +
  "}" +
  "" +
  ".ace_marker-layer {" +
  "    cursor: text;" +
  "    pointer-events: none;" +
  "}" +
  "" +
  ".ace_marker-layer .ace_step {" +
  "    position: absolute;" +
  "    z-index: 3;" +
  "}" +
  "" +
  ".ace_marker-layer .ace_selection {" +
  "    position: absolute;" +
  "    z-index: 4;" +
  "}" +
  "" +
  ".ace_marker-layer .ace_bracket {" +
  "    position: absolute;" +
  "    z-index: 5;" +
  "}" +
  "" +
  ".ace_marker-layer .ace_active_line {" +
  "    position: absolute;" +
  "    z-index: 2;" +
  "}" +
  "" +
  ".ace_marker-layer .ace_selected_word {" +
  "    position: absolute;" +
  "    z-index: 6;" +
  "    box-sizing: border-box;" +
  "    -moz-box-sizing: border-box;" +
  "    -webkit-box-sizing: border-box;" +
  "}" +
  "" +
  ".ace_line .ace_fold {" +
  "    cursor: pointer;" +
  "}" +
  "" +
  ".ace_dragging .ace_marker-layer, .ace_dragging .ace_text-layer {" +
  "  cursor: move;" +
  "}" +
  "");

define("text/styles.css", [], "html {" +
  "    height: 100%;" +
  "    width: 100%;" +
  "    overflow: hidden;" +
  "}" +
  "" +
  "body {" +
  "    overflow: hidden;" +
  "    margin: 0;" +
  "    padding: 0;" +
  "    height: 100%;" +
  "    width: 100%;" +
  "    font-family: Arial, Helvetica, sans-serif, Tahoma, Verdana, sans-serif;" +
  "    font-size: 12px;" +
  "    background: rgb(14, 98, 165);" +
  "    color: white;" +
  "}" +
  "" +
  "#logo {" +
  "    padding: 15px;" +
  "    margin-left: 65px;" +
  "}" +
  "" +
  "#editor {" +
  "    position: absolute;" +
  "    top:  0px;" +
  "    left: 280px;" +
  "    bottom: 0px;" +
  "    right: 0px;" +
  "    background: white;" +
  "}" +
  "" +
  "#controls {" +
  "    padding: 5px;" +
  "}" +
  "" +
  "#controls td {" +
  "    text-align: right;" +
  "}" +
  "" +
  "#controls td + td {" +
  "    text-align: left;" +
  "}" +
  "" +
  "#cockpitInput {" +
  "    position: absolute;" +
  "    left: 280px;" +
  "    right: 0px;" +
  "    bottom: 0;" +
  "" +
  "    border: none; outline: none;" +
  "    font-family: consolas, courier, monospace;" +
  "    font-size: 120%;" +
  "}" +
  "" +
  "#cockpitOutput {" +
  "    padding: 10px;" +
  "    margin: 0 15px;" +
  "    border: 1px solid #AAA;" +
  "    -moz-border-radius-topleft: 10px;" +
  "    -moz-border-radius-topright: 10px;" +
  "    border-top-left-radius: 4px; border-top-right-radius: 4px;" +
  "    background: #DDD; color: #000;" +
  "}");

/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Mozilla Skywriter.
 *
 * The Initial Developer of the Original Code is
 * Mozilla.
 * Portions created by the Initial Developer are Copyright (C) 2009
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Kevin Dangoor (kdangoor@mozilla.com)
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

require(["ace/ace"], function(ace) {
    window.ace = ace;
});p;11;_Ace/ace.jst;185239;(function(){var a=function(){return this}();if(a.require&&a.define)require.packaged=!0;else{var b=function(a,c,d){typeof a!=="string"?b.original?b.original.apply(window,arguments):(console.error("dropping module because define wasn't a string."),console.trace()):(arguments.length==2&&(d=c),define.modules||(define.modules={}),define.modules[a]=d)};a.define&&(b.original=a.define),a.define=b;var c=function(a,b){if(Object.prototype.toString.call(a)==="[object Array]"){var e=[];for(var f=0,g=a.length;f<g;++f){var h=d(a[f]);if(!h&&c.original)return c.original.apply(window,arguments);e.push(h)}b&&b.apply(null,e)}else{if(typeof a==="string"){var i=d(a);if(!i&&c.original)return c.original.apply(window,arguments);b&&b();return i}if(c.original)return c.original.apply(window,arguments)}};a.require&&(c.original=a.require),a.require=c,require.packaged=!0;var d=function(a){var b=define.modules[a];if(b==null){console.error("Missing module: "+a);return null}if(typeof b==="function"){var c={};b(require,c,{id:a,uri:""}),define.modules[a]=c;return c}return b}}})(),define("pilot/fixoldbrowsers",["require","exports","module"],function(a,b,c){if(!Function.prototype.bind){var d=Array.prototype.slice;Function.prototype.bind=function e(a){var b=this;if(typeof b.apply!=="function"||typeof b.call!=="function")return new TypeError;var c=d.call(arguments),e=function e(){if(this instanceof e){var a=Object.create(b.prototype);b.apply(a,c.concat(d.call(arguments)));return a}return b.call.apply(b,c.concat(d.call(arguments)))};e.length=typeof b==="function"?Math.max(b.length-c.length,0):0;return e}}var f=Function.prototype.call,g=Array.prototype,h=Object.prototype,i=f.bind(h.hasOwnProperty),j,k,l,m,n;if(n=i(h,"__defineGetter__"))j=f.bind(h.__defineGetter__),k=f.bind(h.__defineSetter__),l=f.bind(h.__lookupGetter__),m=f.bind(h.__lookupSetter__);Array.isArray||(Array.isArray=function o(a){return Object.prototype.toString.call(a)==="[object Array]"}),Array.prototype.forEach||(Array.prototype.forEach=function p(a,b){var c=+this.length;for(var d=0;d<c;d++)d in this&&a.call(b,this[d],d,this)}),Array.prototype.map||(Array.prototype.map=function q(a){var b=+this.length;if(typeof a!=="function")throw new TypeError;var c=Array(b),d=arguments[1];for(var e=0;e<b;e++)e in this&&(c[e]=a.call(d,this[e],e,this));return c}),Array.prototype.filter||(Array.prototype.filter=function r(a){var b=[],c=arguments[1];for(var d=0;d<this.length;d++)a.call(c,this[d])&&b.push(this[d]);return b}),Array.prototype.every||(Array.prototype.every=function s(a){var b=arguments[1];for(var c=0;c<this.length;c++)if(!a.call(b,this[c]))return!1;return!0}),Array.prototype.some||(Array.prototype.some=function t(a){var b=arguments[1];for(var c=0;c<this.length;c++)if(a.call(b,this[c]))return!0;return!1}),Array.prototype.reduce||(Array.prototype.reduce=function u(a){var b=+this.length;if(typeof a!=="function")throw new TypeError;if(b===0&&arguments.length===1)throw new TypeError;var c=0;if(arguments.length<2){do{if(c in this){d=this[c++];break}if(++c>=b)throw new TypeError}while(!0)}else var d=arguments[1];for(;c<b;c++)c in this&&(d=a.call(null,d,this[c],c,this));return d}),Array.prototype.reduceRight||(Array.prototype.reduceRight=function v(a){var b=+this.length;if(typeof a!=="function")throw new TypeError;if(b===0&&arguments.length===1)throw new TypeError;var c=b-1;if(arguments.length<2){do{if(c in this){d=this[c--];break}if(--c<0)throw new TypeError}while(!0)}else var d=arguments[1];for(;c>=0;c--)c in this&&(d=a.call(null,d,this[c],c,this));return d}),Array.prototype.indexOf||(Array.prototype.indexOf=function w(a){var b=this.length;if(!b)return-1;var c=arguments[1]||0;if(c>=b)return-1;c<0&&(c+=b);for(;c<b;c++){if(!i(this,c))continue;if(a===this[c])return c}return-1}),Array.prototype.lastIndexOf||(Array.prototype.lastIndexOf=function x(a){var b=this.length;if(!b)return-1;var c=arguments[1]||b;c<0&&(c+=b),c=Math.min(c,b-1);for(;c>=0;c--){if(!i(this,c))continue;if(a===this[c])return c}return-1}),Object.getPrototypeOf||(Object.getPrototypeOf=function y(a){return a.__proto__||a.constructor.prototype});if(!Object.getOwnPropertyDescriptor){var z="Object.getOwnPropertyDescriptor called on a non-object: ";Object.getOwnPropertyDescriptor=function A(a,b){if(typeof a!=="object"&&typeof a!=="function"||a===null)throw new TypeError(z+a);if(!i(a,b))return undefined;var c,d,e;c={enumerable:!0,configurable:!0};if(n){var f=a.__proto__;a.__proto__=h;var d=l(a,b),e=m(a,b);a.__proto__=f;if(d||e){d&&(descriptor.get=d),e&&(descriptor.set=e);return descriptor}}descriptor.value=a[b];return descriptor}}Object.getOwnPropertyNames||(Object.getOwnPropertyNames=function B(a){return Object.keys(a)}),Object.create||(Object.create=function C(a,b){var c;if(a===null)c={"__proto__":null};else{if(typeof a!=="object")throw new TypeError("typeof prototype["+typeof a+"] != 'object'");var d=function(){};d.prototype=a,c=new d,c.__proto__=a}typeof b!=="undefined"&&Object.defineProperties(c,b);return c});if(!Object.defineProperty){var D="Property description must be an object: ",E="Object.defineProperty called on non-object: ",F="getters & setters can not be defined on this javascript engine";Object.defineProperty=function G(a,b,c){if(typeof a!=="object"&&typeof a!=="function")throw new TypeError(E+a);if(typeof a!=="object"||a===null)throw new TypeError(D+c);if(i(c,"value"))if(n&&(l(a,b)||m(a,b))){var d=a.__proto__;a.__proto__=h,delete a[b],a[b]=c.value,a.prototype}else a[b]=c.value;else{if(!n)throw new TypeError(F);i(c,"get")&&j(a,b,c.get),i(c,"set")&&k(a,b,c.set)}return a}}Object.defineProperties||(Object.defineProperties=function H(a,b){for(var c in b)i(b,c)&&Object.defineProperty(a,c,b[c]);return a}),Object.seal||(Object.seal=function I(a){return a}),Object.freeze||(Object.freeze=function J(a){return a});try{Object.freeze(function(){})}catch(K){Object.freeze=function J(a){return function b(b){return typeof b==="function"?b:a(b)}}(Object.freeze)}Object.preventExtensions||(Object.preventExtensions=function L(a){return a}),Object.isSealed||(Object.isSealed=function M(a){return!1}),Object.isFrozen||(Object.isFrozen=function N(a){return!1}),Object.isExtensible||(Object.isExtensible=function O(a){return!0});if(!Object.keys){var P=!0,Q=["toString","toLocaleString","valueOf","hasOwnProperty","isPrototypeOf","propertyIsEnumerable","constructor"],R=Q.length;for(var S in {toString:null})P=!1;Object.keys=function T(a){if(typeof a!=="object"&&typeof a!=="function"||a===null)throw new TypeError("Object.keys called on a non-object");var b=[];for(var c in a)i(a,c)&&b.push(c);if(P)for(var d=0,e=R;d<e;d++){var f=Q[d];i(a,f)&&b.push(f)}return b}}Date.prototype.toISOString||(Date.prototype.toISOString=function U(){return this.getUTCFullYear()+"-"+(this.getUTCMonth()+1)+"-"+this.getUTCDate()+"T"+this.getUTCHours()+":"+this.getUTCMinutes()+":"+this.getUTCSeconds()+"Z"}),Date.now||(Date.now=function V(){return(new Date).getTime()}),Date.prototype.toJSON||(Date.prototype.toJSON=function W(a){if(typeof this.toISOString!=="function")throw new TypeError;return this.toISOString()}),isNaN(Date.parse("T00:00"))&&(Date=function(a){var b=function(c,d,e,f,g,h,i){var j=arguments.length;if(this instanceof a){var k=j===1&&String(c)===c?new a(b.parse(c)):j>=7?new a(c,d,e,f,g,h,i):j>=6?new a(c,d,e,f,g,h):j>=5?new a(c,d,e,f,g):j>=4?new a(c,d,e,f):j>=3?new a(c,d,e):j>=2?new a(c,d):j>=1?new a(c):new a;k.constructor=b;return k}return a.apply(this,arguments)},c=new RegExp("^(?:((?:[+-]\\d\\d)?\\d\\d\\d\\d)(?:-(\\d\\d)(?:-(\\d\\d))?)?)?(?:T(\\d\\d):(\\d\\d)(?::(\\d\\d)(?:\\.(\\d\\d\\d))?)?)?(?:Z|([+-])(\\d\\d):(\\d\\d))?$");for(var d in a)b[d]=a[d];b.now=a.now,b.UTC=a.UTC,b.prototype=a.prototype,b.prototype.constructor=b,b.parse=function e(b){var d=c.exec(b);if(d){d.shift();var e=d[0]===undefined;for(var f=0;f<10;f++){if(f===7)continue;d[f]=+(d[f]||(f<3?1:0)),f===1&&d[f]--}if(e)return((d[3]*60+d[4])*60+d[5])*1e3+d[6];var g=(d[8]*60+d[9])*60*1e3;d[6]==="-"&&(g=-g);return a.UTC.apply(this,d.slice(0,7))+g}return a.parse.apply(this,arguments)};return b}(Date));if(!String.prototype.trim){var X=/^\s\s*/,Y=/\s\s*$/;String.prototype.trim=function Z(){return String(this).replace(X,"").replace(Y,"")}}}),define("ace/ace",["require","exports","module","pilot/index","pilot/fixoldbrowsers","pilot/plugin_manager","pilot/dom","pilot/event","ace/editor","ace/edit_session","ace/undomanager","ace/virtual_renderer","ace/theme/textmate","pilot/environment"],function(a,b,c){a("pilot/index"),a("pilot/fixoldbrowsers");var d=a("pilot/plugin_manager").catalog;d.registerPlugins(["pilot/index"]);var e=a("pilot/dom"),f=a("pilot/event"),g=a("ace/editor").Editor,h=a("ace/edit_session").EditSession,i=a("ace/undomanager").UndoManager,j=a("ace/virtual_renderer").VirtualRenderer;b.edit=function(b){typeof b=="string"&&(b=document.getElementById(b));var c=new h(e.getInnerText(b));c.setUndoManager(new i),b.innerHTML="";var k=new g(new j(b,a("ace/theme/textmate")));k.setSession(c);var l=a("pilot/environment").create();d.startupPlugins({env:l}).then(function(){l.document=c,l.editor=k,k.resize(),f.addListener(window,"resize",function(){k.resize()}),b.env=l}),k.env=l;return k}}),define("pilot/index",["require","exports","module","pilot/fixoldbrowsers","pilot/types/basic","pilot/types/command","pilot/types/settings","pilot/commands/settings","pilot/commands/basic","pilot/settings/canon","pilot/canon"],function(a,b,c){b.startup=function(b,c){a("pilot/fixoldbrowsers"),a("pilot/types/basic").startup(b,c),a("pilot/types/command").startup(b,c),a("pilot/types/settings").startup(b,c),a("pilot/commands/settings").startup(b,c),a("pilot/commands/basic").startup(b,c),a("pilot/settings/canon").startup(b,c),a("pilot/canon").startup(b,c)},b.shutdown=function(b,c){a("pilot/types/basic").shutdown(b,c),a("pilot/types/command").shutdown(b,c),a("pilot/types/settings").shutdown(b,c),a("pilot/commands/settings").shutdown(b,c),a("pilot/commands/basic").shutdown(b,c),a("pilot/settings/canon").shutdown(b,c),a("pilot/canon").shutdown(b,c)}}),define("pilot/types/basic",["require","exports","module","pilot/types"],function(a,b,c){function m(a){if(a instanceof e)this.subtype=a;else{if(typeof a!=="string")throw new Error("Can' handle array subtype");this.subtype=d.getType(a);if(this.subtype==null)throw new Error("Unknown array subtype: "+a)}}function l(a){if(typeof a.defer!=="function")throw new Error("Instances of DeferredType need typeSpec.defer to be a function that returns a type");Object.keys(a).forEach(function(b){this[b]=a[b]},this)}function j(a){if(!Array.isArray(a.data)&&typeof a.data!=="function")throw new Error("instances of SelectionType need typeSpec.data to be an array or function that returns an array:"+JSON.stringify(a));Object.keys(a).forEach(function(b){this[b]=a[b]},this)}var d=a("pilot/types"),e=d.Type,f=d.Conversion,g=d.Status,h=new e;h.stringify=function(a){return a},h.parse=function(a){if(typeof a!="string")throw new Error("non-string passed to text.parse()");return new f(a)},h.name="text";var i=new e;i.stringify=function(a){if(!a)return null;return""+a},i.parse=function(a){if(typeof a!="string")throw new Error("non-string passed to number.parse()");if(a.replace(/\s/g,"").length===0)return new f(null,g.INCOMPLETE,"");var b=new f(parseInt(a,10));isNaN(b.value)&&(b.status=g.INVALID,b.message="Can't convert \""+a+'" to a number.');return b},i.decrement=function(a){return a-1},i.increment=function(a){return a+1},i.name="number",j.prototype=new e,j.prototype.stringify=function(a){return a},j.prototype.parse=function(a){if(typeof a!="string")throw new Error("non-string passed to parse()");if(!this.data)throw new Error("Missing data on selection type extension.");var b=typeof this.data==="function"?this.data():this.data,c=!1,d,e=[];b.forEach(function(b){a==b?(d=this.fromString(b),c=!0):b.indexOf(a)===0&&e.push(this.fromString(b))},this);if(c)return new f(d);this.noMatch&&this.noMatch();if(e.length>0){var h="Possibilities"+(a.length===0?"":" for '"+a+"'");return new f(null,g.INCOMPLETE,h,e)}var h="Can't use '"+a+"'.";return new f(null,g.INVALID,h,e)},j.prototype.fromString=function(a){return a},j.prototype.decrement=function(a){var b=typeof this.data==="function"?this.data():this.data,c;if(a==null)c=b.length-1;else{var d=this.stringify(a),c=b.indexOf(d);c=c===0?b.length-1:c-1}return this.fromString(b[c])},j.prototype.increment=function(a){var b=typeof this.data==="function"?this.data():this.data,c;if(a==null)c=0;else{var d=this.stringify(a),c=b.indexOf(d);c=c===b.length-1?0:c+1}return this.fromString(b[c])},j.prototype.name="selection",b.SelectionType=j;var k=new j({name:"bool",data:["true","false"],stringify:function(a){return""+a},fromString:function(a){return a==="true"?!0:!1}});l.prototype=new e,l.prototype.stringify=function(a){return this.defer().stringify(a)},l.prototype.parse=function(a){return this.defer().parse(a)},l.prototype.decrement=function(a){var b=this.defer();return b.decrement?b.decrement(a):undefined},l.prototype.increment=function(a){var b=this.defer();return b.increment?b.increment(a):undefined},l.prototype.name="deferred",b.DeferredType=l,m.prototype=new e,m.prototype.stringify=function(a){return a.join(" ")},m.prototype.parse=function(a){return this.defer().parse(a)},m.prototype.name="array";var n=!1;b.startup=function(){n||(n=!0,d.registerType(h),d.registerType(i),d.registerType(k),d.registerType(j),d.registerType(l),d.registerType(m))},b.shutdown=function(){n=!1,d.unregisterType(h),d.unregisterType(i),d.unregisterType(k),d.unregisterType(j),d.unregisterType(l),d.unregisterType(m)}}),define("pilot/types",["require","exports","module"],function(a,b,c){function i(a,b){if(a.substr(-2)==="[]"){var c=a.slice(0,-2);return new g.array(c)}var d=g[a];typeof d==="function"&&(d=new d(b));return d}function f(){}function e(a,b,c,e){this.value=a,this.status=b||d.VALID,this.message=c,this.predictions=e||[]}var d={VALID:{toString:function(){return"VALID"},valueOf:function(){return 0}},INCOMPLETE:{toString:function(){return"INCOMPLETE"},valueOf:function(){return 1}},INVALID:{toString:function(){return"INVALID"},valueOf:function(){return 2}},combine:function(a){var b=d.VALID;for(var c=0;c<a.length;c++)a[c].valueOf()>b.valueOf()&&(b=a[c]);return b}};b.Status=d,b.Conversion=e,f.prototype={stringify:function(a){throw new Error("not implemented")},parse:function(a){throw new Error("not implemented")},name:undefined,increment:function(a){return undefined},decrement:function(a){return undefined},getDefault:function(){return this.parse("")}},b.Type=f;var g={};b.registerType=function(a){if(typeof a==="object"){if(!(a instanceof f))throw new Error("Can't registerType using: "+a);if(!a.name)throw new Error("All registered types must have a name");g[a.name]=a}else{if(typeof a!=="function")throw new Error("Unknown type: "+a);if(!a.prototype.name)throw new Error("All registered types must have a name");g[a.prototype.name]=a}},b.registerTypes=function h(a){Object.keys(a).forEach(function(c){var d=a[c];d.name=c,b.registerType(d)})},b.deregisterType=function(a){delete g[a.name]},b.getType=function(a){if(typeof a==="string")return i(a);if(typeof a==="object"){if(!a.name)throw new Error("Missing 'name' member to typeSpec");return i(a.name,a)}throw new Error("Can't extract type from "+a)}}),define("pilot/types/command",["require","exports","module","pilot/canon","pilot/types/basic","pilot/types"],function(a,b,c){var d=a("pilot/canon"),e=a("pilot/types/basic").SelectionType,f=a("pilot/types"),g=new e({name:"command",data:function(){return d.getCommandNames()},stringify:function(a){return a.name},fromString:function(a){return d.getCommand(a)}});b.startup=function(){f.registerType(g)},b.shutdown=function(){f.unregisterType(g)}}),define("pilot/canon",["require","exports","module","pilot/console","pilot/stacktrace","pilot/oop","pilot/useragent","pilot/keys","pilot/event_emitter","pilot/typecheck","pilot/catalog","pilot/types","pilot/lang"],function(a,b,c){function J(a){a=a||{},this.command=a.command,this.args=a.args,this.typed=a.typed,this._begunOutput=!1,this.start=new Date,this.end=null,this.completed=!1,this.error=!1}function G(a,b,c,e,f){function h(){a.exec(b,g.args,g),!g.isAsync&&!g.isDone&&g.done()}typeof a==="string"&&(a=q[a]);if(!a)return!1;var g=new J({sender:c,command:a,args:e||{},typed:f});if(g.getStatus()==l.INVALID){d.error("Canon.exec: Invalid parameter(s) passed to "+a.name);return!1}if(g.getStatus()==l.INCOMPLETE){var i,j=b[c];if(!j||!j.getArgsProvider||!(i=j.getArgsProvider()))i=F;i(g,function(){g.getStatus()==l.VALID&&h()});return!0}h();return!0}function F(a,b){var c=a.args,d=a.command.params;for(var e=0;e<d.length;e++){var f=d[e];if(a.getParamStatus(f)!=l.VALID||f.defaultValue===null){var g=f.description;f.defaultValue===null&&(g+=" (optional)");var h=prompt(g,f.defaultValue||"");if(h)c[f.name]=h;else{b();return}}}b()}function E(){return z}function D(a){return q[a]}function C(a){var b=typeof a==="string"?a:a.name;delete q[b],n.arrayRemove(z,b)}function B(a,b){var c=b.type;b.type=m.getType(c);if(b.type==null)throw new Error("In "+a+"/"+b.name+": can't find type for: "+JSON.stringify(c))}function A(a){if(!a.name)throw new Error("All registered commands must have a name");a.params==null&&(a.params=[]);if(!Array.isArray(a.params))throw new Error("command.params must be an array in "+a.name);a.params.forEach(function(b){if(!b.name)throw new Error("In "+a.name+": all params must have a name");B(a.name,b)},this),q[a.name]=a,a.bindKey&&w(a),z.push(a.name),z.sort()}function y(a,b,c,d){var e=x(a,b,c,d);return e?G(e,a,b,{}):!1}function x(a,b,c,d){j.isNumber(d)&&(d=h.keyCodeToString(d));var e=(s[c]||{})[d]||[];for(var f=0;f<e.length;f++)if(e[f].sender(a,b,c,d))return e[f].command;var g=r[b];return g&&g[c]&&g[c][d]}function w(a){var b=a.bindKey,c=b[v],d=r,e=s;if(!b.sender)throw new Error("All key bindings must have a sender");if(!b.mac&&b.mac!==null)throw new Error("All key bindings must have a mac key binding");if(!b.win&&b.win!==null)throw new Error("All key bindings must have a windows key binding");if(b[v])if(typeof b.sender=="string"){var f=t(b.sender,"\\|",null,!0);f.forEach(function(b){d[b]||(d[b]={}),c.split("|").forEach(function(c){u(c,a,d[b])})})}else{if(!j.isFunction(b.sender))throw new Error("Key binding must have a sender that is a string or function");var g={command:a,sender:b.sender};keyData=u(c),e[keyData.hashId]||(e[keyData.hashId]={}),e[keyData.hashId][keyData.key]?e[keyData.hashId][keyData.key].push(g):e[keyData.hashId][keyData.key]=[g]}}function u(a,b,c){var d,e=0,f=t(a,"\\-",null,!0),g=0,i=f.length;for(;g<i;++g)h.KEY_MODS[f[g]]?e=e|h.KEY_MODS[f[g]]:d=f[g]||"-";if(c==null)return{key:d,hashId:e};(c[e]||(c[e]={}))[d]=b}function t(a,b,c,d){return(d&&a.toLowerCase()||a).replace(/(?:^\s+|\n|\s+$)/g,"").split(new RegExp("[\\s ]*"+b+"[\\s ]*","g"),c||999)}var d=a("pilot/console"),e=a("pilot/stacktrace").Trace,f=a("pilot/oop"),g=a("pilot/useragent"),h=a("pilot/keys"),i=a("pilot/event_emitter").EventEmitter,j=a("pilot/typecheck"),k=a("pilot/catalog"),l=a("pilot/types").Status,m=a("pilot/types"),n=a("pilot/lang"),o={name:"command",description:"A command is a bit of functionality with optional typed arguments which can do something small like moving the cursor around the screen, or large like cloning a project from VCS.",indexOn:"name"};b.startup=function(a,b){k.addExtensionSpec(o)},b.shutdown=function(a,b){k.removeExtensionSpec(o)};var p={name:"thing",description:"thing is an example command",params:[{name:"param1",description:"an example parameter",type:"text",defaultValue:null}],exec:function(a,b,c){thing()}},q={},r={},s={},v=g.isMac?"mac":"win",z=[];b.removeCommand=C,b.addCommand=A,b.getCommand=D,b.getCommandNames=E,b.findKeyCommand=x,b.exec=G,b.execKeyCommand=y,b.upgradeType=B,f.implement(b,i);var H=[],I=100;f.implement(J.prototype,i),J.prototype.getParamStatus=function(a){var b=this.args||{};if(a.name in b){if(b[a.name]==null)return a.defaultValue===null?l.VALID:l.INCOMPLETE;var c,d=b[a.name].toString();try{c=a.type.parse(d)}catch(e){return l.INVALID}if(c.status!=l.VALID)return c.status}else if(a.defaultValue===undefined)return l.INCOMPLETE;return l.VALID},J.prototype.getParamNameStatus=function(a){var b=this.command.params||[];for(var c=0;c<b.length;c++)if(b[c].name==a)return this.getParamStatus(b[c]);throw"Parameter '"+a+"' not defined on command '"+this.command.name+"'"},J.prototype.getStatus=function(){var a=this.args||{},b=this.command.params;if(!b||b.length==0)return l.VALID;var c=[];for(var d=0;d<b.length;d++)c.push(this.getParamStatus(b[d]));return l.combine(c)},J.prototype._beginOutput=function(){this._begunOutput=!0,this.outputs=[],H.push(this);while(H.length>I)H.shiftObject();b._dispatchEvent("output",{requests:H,request:this})},J.prototype.doneWithError=function(a){this.error=!0,this.done(a)},J.prototype.async=function(){this.isAsync=!0,this._begunOutput||this._beginOutput()},J.prototype.output=function(a){this._begunOutput||this._beginOutput(),typeof a!=="string"&&!(a instanceof Node)&&(a=a.toString()),this.outputs.push(a),this.isDone=!0,this._dispatchEvent("output",{});return this},J.prototype.done=function(a){this.completed=!0,this.end=new Date,this.duration=this.end.getTime()-this.start.getTime(),a&&this.output(a),this.isDone||(this.isDone=!0,this._dispatchEvent("output",{}))},b.Request=J}),define("pilot/console",["require","exports","module"],function(a,b,c){var d=function(){},e=["assert","count","debug","dir","dirxml","error","group","groupEnd","info","log","profile","profileEnd","time","timeEnd","trace","warn"];typeof window==="undefined"?e.forEach(function(a){b[a]=function(){var b=Array.prototype.slice.call(arguments),c={op:"log",method:a,args:b};postMessage(JSON.stringify(c))}}):e.forEach(function(a){window.console&&window.console[a]?b[a]=Function.prototype.bind.call(window.console[a],window.console):b[a]=d})}),define("pilot/stacktrace",["require","exports","module","pilot/useragent","pilot/console"],function(a,b,c){function i(){}function g(a){for(var b=0;b<a.length;++b){var c=a[b];typeof c=="object"?a[b]="#object":typeof c=="function"?a[b]="#function":typeof c=="string"&&(a[b]='"'+c+'"')}return a.join(",")}var d=a("pilot/useragent"),e=a("pilot/console"),f=function(){return d.isGecko?"firefox":d.isOpera?"opera":"other"}(),h={chrome:function(a){var b=a.stack;if(!b){e.log(a);return[]}return b.replace(/^.*?\n/,"").replace(/^.*?\n/,"").replace(/^.*?\n/,"").replace(/^[^\(]+?[\n$]/gm,"").replace(/^\s+at\s+/gm,"").replace(/^Object.<anonymous>\s*\(/gm,"{anonymous}()@").split("\n")},firefox:function(a){var b=a.stack;if(!b){e.log(a);return[]}b=b.replace(/(?:\n@:0)?\s+$/m,""),b=b.replace(/^\(/gm,"{anonymous}(");return b.split("\n")},opera:function(a){var b=a.message.split("\n"),c="{anonymous}",d=/Line\s+(\d+).*?script\s+(http\S+)(?:.*?in\s+function\s+(\S+))?/i,e,f,g;for(e=4,f=0,g=b.length;e<g;e+=2)d.test(b[e])&&(b[f++]=(RegExp.$3?RegExp.$3+"()@"+RegExp.$2+RegExp.$1:c+"()@"+RegExp.$2+":"+RegExp.$1)+" -- "+b[e+1].replace(/^\s+/,""));b.splice(f,b.length-f);return b},other:function(a){var b="{anonymous}",c=/function\s*([\w\-$]+)?\s*\(/i,d=[],e=0,f,h,i=10;while(a&&d.length<i){f=c.test(a.toString())?RegExp.$1||b:b,h=Array.prototype.slice.call(a.arguments),d[e++]=f+"("+g(h)+")";if(a===a.caller&&window.opera)break;a=a.caller}return d}};i.prototype={sourceCache:{},ajax:function(a){var b=this.createXMLHTTPObject();if(b){b.open("GET",a,!1),b.setRequestHeader("User-Agent","XMLHTTP/1.0"),b.send("");return b.responseText}},createXMLHTTPObject:function(){var a,b=[function(){return new XMLHttpRequest},function(){return new ActiveXObject("Msxml2.XMLHTTP")},function(){return new ActiveXObject("Msxml3.XMLHTTP")},function(){return new ActiveXObject("Microsoft.XMLHTTP")}];for(var c=0;c<b.length;c++)try{a=b[c](),this.createXMLHTTPObject=b[c];return a}catch(d){}},getSource:function(a){a in this.sourceCache||(this.sourceCache[a]=this.ajax(a).split("\n"));return this.sourceCache[a]},guessFunctions:function(a){for(var b=0;b<a.length;++b){var c=/{anonymous}\(.*\)@(\w+:\/\/([-\w\.]+)+(:\d+)?[^:]+):(\d+):?(\d+)?/,d=a[b],e=c.exec(d);if(e){var f=e[1],g=e[4];if(f&&g){var h=this.guessFunctionName(f,g);a[b]=d.replace("{anonymous}",h)}}}return a},guessFunctionName:function(a,b){try{return this.guessFunctionNameFromLines(b,this.getSource(a))}catch(c){return"getSource failed with url: "+a+", exception: "+c.toString()}},guessFunctionNameFromLines:function(a,b){var c=/function ([^(]*)\(([^)]*)\)/,d=/['"]?([0-9A-Za-z_]+)['"]?\s*[:=]\s*(function|eval|new Function)/,e="",f=10;for(var g=0;g<f;++g){e=b[a-g]+e;if(e!==undefined){var h=d.exec(e);if(h)return h[1];h=c.exec(e);if(h&&h[1])return h[1]}}return"(?)"}};var j=new i,k=[/http:\/\/localhost:4020\/sproutcore.js:/];b.ignoreFramesMatching=function(a){k.push(a)},b.Trace=function l(a,b){this._ex=a,this._stack=h[f](a),b&&(this._stack=j.guessFunctions(this._stack))},b.Trace.prototype.log=function(a){a<=0&&(a=999999999);var b=0;for(var c=0;c<this._stack.length&&b<a;c++){var d=this._stack[c],f=!0;k.forEach(function(a){a.test(d)&&(f=!1)}),f&&(e.debug(d),b++)}}}),define("pilot/useragent",["require","exports","module"],function(a,b,c){var d=(navigator.platform.match(/mac|win|linux/i)||["other"])[0].toLowerCase(),e=navigator.userAgent,f=navigator.appVersion;b.isWin=d=="win",b.isMac=d=="mac",b.isLinux=d=="linux",b.isIE=!+"1",b.isGecko=b.isMozilla=window.controllers&&window.navigator.product==="Gecko",b.isOldGecko=b.isGecko&&/rv\:1/.test(navigator.userAgent),b.isOpera=window.opera&&Object.prototype.toString.call(window.opera)=="[object Opera]",b.isWebKit=parseFloat(e.split("WebKit/")[1])||undefined,b.isAIR=e.indexOf("AdobeAIR")>=0,b.isIPad=e.indexOf("iPad")>=0,b.OS={LINUX:"LINUX",MAC:"MAC",WINDOWS:"WINDOWS"},b.getOS=function(){return b.isMac?b.OS.MAC:b.isLinux?b.OS.LINUX:b.OS.WINDOWS}}),define("pilot/oop",["require","exports","module"],function(a,b,c){b.inherits=function(){var a=function(){};return function(b,c){a.prototype=c.prototype,b.super_=c.prototype,b.prototype=new a,b.prototype.constructor=b}}(),b.mixin=function(a,b){for(var c in b)a[c]=b[c]},b.implement=function(a,c){b.mixin(a,c)}}),define("pilot/keys",["require","exports","module","pilot/oop"],function(a,b,c){var d=a("pilot/oop"),e=function(){var a={MODIFIER_KEYS:{16:"Shift",17:"Ctrl",18:"Alt",224:"Meta"},KEY_MODS:{ctrl:1,alt:2,option:2,shift:4,meta:8,command:8},FUNCTION_KEYS:{8:"Backspace",9:"Tab",13:"Return",19:"Pause",27:"Esc",32:"Space",33:"PageUp",34:"PageDown",35:"End",36:"Home",37:"Left",38:"Up",39:"Right",40:"Down",44:"Print",45:"Insert",46:"Delete",112:"F1",113:"F2",114:"F3",115:"F4",116:"F5",117:"F6",118:"F7",119:"F8",120:"F9",121:"F10",122:"F11",123:"F12",144:"Numlock",145:"Scrolllock"},PRINTABLE_KEYS:{32:" ",48:"0",49:"1",50:"2",51:"3",52:"4",53:"5",54:"6",55:"7",56:"8",57:"9",59:";",61:"=",65:"a",66:"b",67:"c",68:"d",69:"e",70:"f",71:"g",72:"h",73:"i",74:"j",75:"k",76:"l",77:"m",78:"n",79:"o",80:"p",81:"q",82:"r",83:"s",84:"t",85:"u",86:"v",87:"w",88:"x",89:"y",90:"z",107:"+",109:"-",110:".",188:",",190:".",191:"/",192:"`",219:"[",220:"\\",221:"]",222:'"'}};for(i in a.FUNCTION_KEYS){var b=a.FUNCTION_KEYS[i].toUpperCase();a[b]=parseInt(i,10)}d.mixin(a,a.MODIFIER_KEYS),d.mixin(a,a.PRINTABLE_KEYS),d.mixin(a,a.FUNCTION_KEYS);return a}();d.mixin(b,e),b.keyCodeToString=function(a){return(e[a]||String.fromCharCode(a)).toLowerCase()}}),define("pilot/event_emitter",["require","exports","module"],function(a,b,c){var d={};d._emit=d._dispatchEvent=function(a,b){this._eventRegistry=this._eventRegistry||{};var c=this._eventRegistry[a];if(c&&c.length){var b=b||{};b.type=a;for(var d=0;d<c.length;d++)c[d](b)}},d.on=d.addEventListener=function(a,b){this._eventRegistry=this._eventRegistry||{};var c=this._eventRegistry[a];if(!c)var c=this._eventRegistry[a]=[];c.indexOf(b)==-1&&c.push(b)},d.removeListener=d.removeEventListener=function(a,b){this._eventRegistry=this._eventRegistry||{};var c=this._eventRegistry[a];if(c){var d=c.indexOf(b);d!==-1&&c.splice(d,1)}},d.removeAllListeners=function(a){this._eventRegistry&&(this._eventRegistry[a]=[])},b.EventEmitter=d}),define("pilot/typecheck",["require","exports","module"],function(a,b,c){var d=Object.prototype.toString;b.isString=function(a){return a&&d.call(a)==="[object String]"},b.isBoolean=function(a){return a&&d.call(a)==="[object Boolean]"},b.isNumber=function(a){return a&&d.call(a)==="[object Number]"&&isFinite(a)},b.isObject=function(a){return a!==undefined&&(a===null||typeof a=="object"||Array.isArray(a)||b.isFunction(a))},b.isFunction=function(a){return a&&d.call(a)==="[object Function]"}}),define("pilot/catalog",["require","exports","module"],function(a,b,c){var d={};b.addExtensionSpec=function(a){d[a.name]=a},b.removeExtensionSpec=function(a){typeof a==="string"?delete d[a]:delete d[a.name]},b.getExtensionSpec=function(a){return d[a]},b.getExtensionSpecs=function(){return Object.keys(d)}}),define("pilot/lang",["require","exports","module"],function(a,b,c){b.stringReverse=function(a){return a.split("").reverse().join("")},b.stringRepeat=function(a,b){return Array(b+1).join(a)};var d=/^\s\s*/,e=/\s\s*$/;b.stringTrimLeft=function(a){return a.replace(d,"")},b.stringTrimRight=function(a){return a.replace(e,"")},b.copyObject=function(a){var b={};for(var c in a)b[c]=a[c];return b},b.copyArray=function(a){var b=[];for(i=0,l=a.length;i<l;i++)a[i]&&typeof a[i]=="object"?b[i]=this.copyObject(a[i]):b[i]=a[i];return b},b.deepCopy=function(a){if(typeof a!="object")return a;var b=a.constructor();for(var c in a)typeof a[c]=="object"?b[c]=this.deepCopy(a[c]):b[c]=a[c];return b},b.arrayToMap=function(a){var b={};for(var c=0;c<a.length;c++)b[a[c]]=1;return b},b.arrayRemove=function(a,b){for(var c=0;c<=a.length;c++)b===a[c]&&a.splice(c,1)},b.escapeRegExp=function(a){return a.replace(/([.*+?^${}()|[\]\/\\])/g,"\\$1")},b.deferredCall=function(a){var b=null,c=function(){b=null,a()},d=function(a){b||(b=setNativeTimeout(c,a||0));return d};d.schedule=d,d.call=function(){this.cancel(),a();return d},d.cancel=function(){clearTimeout(b),b=null;return d};return d}}),define("pilot/types/settings",["require","exports","module","pilot/types/basic","pilot/types","pilot/settings"],function(a,b,c){var d=a("pilot/types/basic").SelectionType,e=a("pilot/types/basic").DeferredType,f=a("pilot/types"),g=a("pilot/settings").settings,h,i=new d({name:"setting",data:function(){return k.settings.getSettingNames()},stringify:function(a){h=a;return a.name},fromString:function(a){h=g.getSetting(a);return h},noMatch:function(){h=null}}),j=new e({name:"settingValue",defer:function(){return h?h.type:f.getType("text")},getDefault:function(){var a=this.parse("");if(h){var b=h.get();if(a.predictions.length===0)a.predictions.push(b);else{var c=!1;while(!0){var d=a.predictions.indexOf(b);if(d===-1)break;a.predictions.splice(d,1),c=!0}c&&a.predictions.push(b)}}return a}}),k;b.startup=function(a,b){k=a.env,f.registerType(i),f.registerType(j)},b.shutdown=function(a,b){f.unregisterType(i),f.unregisterType(j)}}),define("pilot/settings",["require","exports","module","pilot/console","pilot/oop","pilot/types","pilot/event_emitter","pilot/catalog"],function(a,b,c){function n(){}function k(a){this._deactivated={},this._settings={},this._settingNames=[],a&&this.setPersister(a)}function j(a,b){this._settings=b,Object.keys(a).forEach(function(b){this[b]=a[b]},this),this.type=f.getType(this.type);if(this.type==null)throw new Error("In "+this.name+": can't find type for: "+JSON.stringify(a.type));if(!this.name)throw new Error("Setting.name == undefined. Ignoring.",this);if(!this.defaultValue===undefined)throw new Error("Setting.defaultValue == undefined",this);this.onChange&&this.on("change",this.onChange.bind(this)),this.set(this.defaultValue)}var d=a("pilot/console"),e=a("pilot/oop"),f=a("pilot/types"),g=a("pilot/event_emitter").EventEmitter,h=a("pilot/catalog"),i={name:"setting",description:"A setting is something that the application offers as a way to customize how it works",register:"env.settings.addSetting",indexOn:"name"};b.startup=function(a,b){h.addExtensionSpec(i)},b.shutdown=function(a,b){h.removeExtensionSpec(i)},j.prototype={get:function(){return this.value},set:function(a){this.value!==a&&(this.value=a,this._settings.persister&&this._settings.persister.persistValue(this._settings,this.name,a),this._dispatchEvent("change",{setting:this,value:a}))},resetValue:function(){this.set(this.defaultValue)}},e.implement(j.prototype,g),k.prototype={addSetting:function(a){var b=new j(a,this);this._settings[b.name]=b,this._settingNames.push(b.name),this._settingNames.sort()},addSettings:function l(a){Object.keys(a).forEach(function(b){var c=a[b];"name"in c||(c.name=b),this.addSetting(c)},this)},removeSetting:function(a){var b=typeof a==="string"?a:a.name;a=this._settings[b],delete this._settings[b],util.arrayRemove(this._settingNames,b),settings.removeAllListeners("change")},removeSettings:function m(a){Object.keys(a).forEach(function(b){var c=a[b];"name"in c||(c.name=b),this.removeSettings(c)},this)},getSettingNames:function(){return this._settingNames},getSetting:function(a){return this._settings[a]},setPersister:function(a){this._persister=a,a&&a.loadInitialValues(this)},resetAll:function(){this.getSettingNames().forEach(function(a){this.resetValue(a)},this)},_list:function(){var a=[];this.getSettingNames().forEach(function(b){a.push({key:b,value:this.getSetting(b).get()})},this);return a},_loadDefaultValues:function(){this._loadFromObject(this._getDefaultValues())},_loadFromObject:function(a){for(var b in a)if(a.hasOwnProperty(b)){var c=this._settings[b];if(c){var d=c.type.parse(a[b]);this.set(b,d)}else this.set(b,a[b])}},_saveToObject:function(){return this.getSettingNames().map(function(a){return this._settings[a].type.stringify(this.get(a))}.bind(this))},_getDefaultValues:function(){return this.getSettingNames().map(function(a){return this._settings[a].spec.defaultValue}.bind(this))}},b.settings=new k,n.prototype={loadInitialValues:function(a){a._loadDefaultValues();var b=cookie.get("settings");a._loadFromObject(JSON.parse(b))},persistValue:function(a,b,c){try{var e=JSON.stringify(a._saveToObject());cookie.set("settings",e)}catch(f){d.error("Unable to JSONify the settings! "+f);return}}},b.CookiePersister=n}),define("pilot/commands/settings",["require","exports","module","pilot/canon"],function(a,b,c){var d={name:"set",params:[{name:"setting",type:"setting",description:"The name of the setting to display or alter",defaultValue:null},{name:"value",type:"settingValue",description:"The new value for the chosen setting",defaultValue:null}],description:"define and show settings",exec:function(a,b,c){var d;if(b.setting)b.value===undefined?d="<strong>"+setting.name+"</strong> = "+setting.get():(b.setting.set(b.value),d="Setting: <strong>"+b.setting.name+"</strong> = "+b.setting.get());else{var e=a.settings.getSettingNames();d="",e.sort(function(a,b){return a.localeCompare(b)}),e.forEach(function(b){var c=a.settings.getSetting(b),e="https://wiki.mozilla.org/Labs/Skywriter/Settings#"+c.name;d+='<a class="setting" href="'+e+'" title="View external documentation on setting: '+c.name+'" target="_blank">'+c.name+"</a> = "+c.value+"<br/>"})}c.done(d)}},e={name:"unset",params:[{name:"setting",type:"setting",description:"The name of the setting to return to defaults"}],description:"unset a setting entirely",exec:function(a,b,c){var d=a.settings.get(b.setting);d?(d.reset(),c.done("Reset "+d.name+" to default: "+a.settings.get(b.setting))):c.doneWithError("No setting with the name <strong>"+b.setting+"</strong>.")}},f=a("pilot/canon");b.startup=function(a,b){f.addCommand(d),f.addCommand(e)},b.shutdown=function(a,b){f.removeCommand(d),f.removeCommand(e)}}),define("pilot/commands/basic",["require","exports","module","pilot/typecheck","pilot/canon"],function(require,exports,module){var checks=require("pilot/typecheck"),canon=require("pilot/canon"),helpMessages={plainPrefix:'<h2>Welcome to Skywriter - Code in the Cloud</h2><ul><li><a href="http://labs.mozilla.com/projects/skywriter" target="_blank">Home Page</a></li><li><a href="https://wiki.mozilla.org/Labs/Skywriter" target="_blank">Wiki</a></li><li><a href="https://wiki.mozilla.org/Labs/Skywriter/UserGuide" target="_blank">User Guide</a></li><li><a href="https://wiki.mozilla.org/Labs/Skywriter/Tips" target="_blank">Tips and Tricks</a></li><li><a href="https://wiki.mozilla.org/Labs/Skywriter/FAQ" target="_blank">FAQ</a></li><li><a href="https://wiki.mozilla.org/Labs/Skywriter/DeveloperGuide" target="_blank">Developers Guide</a></li></ul>',plainSuffix:'For more information, see the <a href="https://wiki.mozilla.org/Labs/Skywriter">Skywriter Wiki</a>.'},helpCommandSpec={name:"help",params:[{name:"search",type:"text",description:"Search string to narrow the output.",defaultValue:null}],description:"Get help on the available commands.",exec:function(a,b,c){var d=[],e=canon.getCommand(b.search);if(e&&e.exec)d.push(e.description?e.description:"No description for "+b.search);else{var f=!1;!b.search&&helpMessages.plainPrefix&&d.push(helpMessages.plainPrefix),e?(d.push("<h2>Sub-Commands of "+e.name+"</h2>"),d.push("<p>"+e.description+"</p>")):b.search?(b.search=="hidden"&&(b.search="",f=!0),d.push("<h2>Commands starting with '"+b.search+"':</h2>")):d.push("<h2>Available Commands:</h2>");var g=canon.getCommandNames();g.sort(),d.push("<table>");for(var h=0;h<g.length;h++){e=canon.getCommand(g[h]);if(!f&&e.hidden)continue;if(e.description===undefined)continue;if(b.search&&e.name.indexOf(b.search)!==0)continue;if(!b.search&&e.name.indexOf(" ")!=-1)continue;if(e&&e.name==b.search)continue;d.push("<tr>"),d.push('<th class="right">'+e.name+"</th>"),d.push("<td>"+e.description+"</td>"),d.push("</tr>")}d.push("</table>"),!b.search&&helpMessages.plainSuffix&&d.push(helpMessages.plainSuffix)}c.done(d.join(""))}},evalCommandSpec={name:"eval",params:[{name:"javascript",type:"text",description:"The JavaScript to evaluate"}],description:"evals given js code and show the result",hidden:!0,exec:function(env,args,request){var result,javascript=args.javascript;try{result=eval(javascript)}catch(e){result="<b>Error: "+e.message+"</b>"}var msg="",type="",x;if(checks.isFunction(result))msg=(result+"").replace(/\n/g,"<br>").replace(/ /g,"&#160"),type="function";else if(checks.isObject(result)){Array.isArray(result)?type="array":type="object";var items=[],value;for(x in result)result.hasOwnProperty(x)&&(checks.isFunction(result[x])?value="[function]":checks.isObject(result[x])?value="[object]":value=result[x],items.push({name:x,value:value}));items.sort(function(a,b){return a.name.toLowerCase()<b.name.toLowerCase()?-1:1});for(x=0;x<items.length;x++)msg+="<b>"+items[x].name+"</b>: "+items[x].value+"<br>"}else msg=result,type=typeof result;request.done("Result for eval <b>'"+javascript+"'</b> (type: "+type+"): <br><br>"+msg)}},versionCommandSpec={name:"version",description:"show the Skywriter version",hidden:!0,exec:function(a,b,c){var d="Skywriter "+skywriter.versionNumber+" ("+skywriter.versionCodename+")";c.done(d)}},skywriterCommandSpec={name:"skywriter",hidden:!0,exec:function(a,b,c){var d=Math.floor(Math.random()*messages.length);c.done("Skywriter "+messages[d])}},messages=["really wants you to trick it out in some way.","is your Web editor.","would love to be like Emacs on the Web.","is written on the Web platform, so you can tweak it."],canon=require("pilot/canon");exports.startup=function(a,b){canon.addCommand(helpCommandSpec),canon.addCommand(evalCommandSpec),canon.addCommand(skywriterCommandSpec)},exports.shutdown=function(a,b){canon.removeCommand(helpCommandSpec),canon.removeCommand(evalCommandSpec),canon.removeCommand(skywriterCommandSpec)}}),define("pilot/settings/canon",["require","exports","module"],function(a,b,c){var d={name:"historyLength",description:"How many typed commands do we recall for reference?",type:"number",defaultValue:50};b.startup=function(a,b){a.env.settings.addSetting(d)},b.shutdown=function(a,b){a.env.settings.removeSetting(d)}}),define("pilot/plugin_manager",["require","exports","module","pilot/promise"],function(a,b,c){var d=a("pilot/promise").Promise;b.REASONS={APP_STARTUP:1,APP_SHUTDOWN:2,PLUGIN_ENABLE:3,PLUGIN_DISABLE:4,PLUGIN_INSTALL:5,PLUGIN_UNINSTALL:6,PLUGIN_UPGRADE:7,PLUGIN_DOWNGRADE:8},b.Plugin=function(a){this.name=a,this.status=this.INSTALLED},b.Plugin.prototype={NEW:0,INSTALLED:1,REGISTERED:2,STARTED:3,UNREGISTERED:4,SHUTDOWN:5,install:function(b,c){var e=new d;if(this.status>this.NEW){e.resolve(this);return e}a([this.name],function(a){a.install&&a.install(b,c),this.status=this.INSTALLED,e.resolve(this)}.bind(this));return e},register:function(b,c){var e=new d;if(this.status!=this.INSTALLED){e.resolve(this);return e}a([this.name],function(a){a.register&&a.register(b,c),this.status=this.REGISTERED,e.resolve(this)}.bind(this));return e},startup:function(c,e){e=e||b.REASONS.APP_STARTUP;var f=new d;if(this.status!=this.REGISTERED){f.resolve(this);return f}a([this.name],function(a){a.startup&&a.startup(c,e),this.status=this.STARTED,f.resolve(this)}.bind(this));return f},shutdown:function(b,c){this.status==this.STARTED&&(pluginModule=a(this.name),pluginModule.shutdown&&pluginModule.shutdown(b,c))}},b.PluginCatalog=function(){this.plugins={}},b.PluginCatalog.prototype={registerPlugins:function(a,c,e){var f=[];a.forEach(function(a){var d=this.plugins[a];d===undefined&&(d=new b.Plugin(a),this.plugins[a]=d,f.push(d.register(c,e)))}.bind(this));return d.group(f)},startupPlugins:function(a,b){var c=[];for(var e in this.plugins){var f=this.plugins[e];c.push(f.startup(a,b))}return d.group(c)}},b.catalog=new b.PluginCatalog}),define("pilot/promise",["require","exports","module","pilot/console","pilot/stacktrace"],function(a,b,c){var d=a("pilot/console"),e=a("pilot/stacktrace").Trace,f=-1,g=0,h=1,i=0,j=!1,k=[],l=[];Promise=function(){this._status=g,this._value=undefined,this._onSuccessHandlers=[],this._onErrorHandlers=[],this._id=i++,k[this._id]=this},Promise.prototype.isPromise=!0,Promise.prototype.isComplete=function(){return this._status!=g},Promise.prototype.isResolved=function(){return this._status==h},Promise.prototype.isRejected=function(){return this._status==f},Promise.prototype.then=function(a,b){typeof a==="function"&&(this._status===h?a.call(null,this._value):this._status===g&&this._onSuccessHandlers.push(a)),typeof b==="function"&&(this._status===f?b.call(null,this._value):this._status===g&&this._onErrorHandlers.push(b));return this},Promise.prototype.chainPromise=function(a){var b=new Promise;b._chainedFrom=this,this.then(function(c){try{b.resolve(a(c))}catch(d){b.reject(d)}},function(a){b.reject(a)});return b},Promise.prototype.resolve=function(a){return this._complete(this._onSuccessHandlers,h,a,"resolve")},Promise.prototype.reject=function(a){return this._complete(this._onErrorHandlers,f,a,"reject")},Promise.prototype._complete=function(a,b,c,f){if(this._status!=g){d.group("Promise already closed"),d.error("Attempted "+f+"() with ",c),d.error("Previous status = ",this._status,", previous value = ",this._value),d.trace(),this._completeTrace&&(d.error("Trace of previous completion:"),this._completeTrace.log(5)),d.groupEnd();return this}j&&(this._completeTrace=new e(new Error)),this._status=b,this._value=c,a.forEach(function(a){a.call(null,this._value)},this),this._onSuccessHandlers.length=0,this._onErrorHandlers.length=0,delete k[this._id],l.push(this);while(l.length>20)l.shift();return this},Promise.group=function(a){a instanceof Array||(a=Array.prototype.slice.call(arguments));if(a.length===0)return(new Promise).resolve([]);var b=new Promise,c=[],d=0,e=function(e){return function(g){c[e]=g,d++,b._status!==f&&(d===a.length&&b.resolve(c))}};a.forEach(function(a,c){var d=e(c),f=b.reject.bind(b);a.then(d,f)});return b},b.Promise=Promise,b._outstanding=k,b._recent=l}),define("pilot/dom",["require","exports","module"],function(a,b,c){var d="http://www.w3.org/1999/xhtml";b.createElement=function(a,b){return document.createElementNS?document.createElementNS(b||d,a):document.createElement(a)},b.setText=function(a,b){a.innerText!==undefined&&(a.innerText=b),a.textContent!==undefined&&(a.textContent=b)},document.documentElement.classList?(b.hasCssClass=function(a,b){return a.classList.contains(b)},b.addCssClass=function(a,b){a.classList.add(b)},b.removeCssClass=function(a,b){a.classList.remove(b)},b.toggleCssClass=function(a,b){return a.classList.toggle(b)}):(b.hasCssClass=function(a,b){var c=a.className.split(/\s+/g);return c.indexOf(b)!==-1},b.addCssClass=function(a,c){b.hasCssClass(a,c)||(a.className+=" "+c)},b.removeCssClass=function(a,b){var c=a.className.split(/\s+/g);while(!0){var d=c.indexOf(b);if(d==-1)break;c.splice(d,1)}a.className=c.join(" ")},b.toggleCssClass=function(a,b){var c=a.className.split(/\s+/g),d=!0;while(!0){var e=c.indexOf(b);if(e==-1)break;d=!1,c.splice(e,1)}d&&c.push(b),a.className=c.join(" ");return d}),b.setCssClass=function(a,c,d){d?b.addCssClass(a,c):b.removeCssClass(a,c)},b.importCssString=function(a,b){b=b||document;if(b.createStyleSheet){var c=b.createStyleSheet();c.cssText=a}else{var e=b.createElementNS?b.createElementNS(d,"style"):b.createElement("style");e.appendChild(b.createTextNode(a));var f=b.getElementsByTagName("head")[0]||b.documentElement;f.appendChild(e)}},b.getInnerWidth=function(a){return parseInt(b.computedStyle(a,"paddingLeft"))+parseInt(b.computedStyle(a,"paddingRight"))+a.clientWidth},b.getInnerHeight=function(a){return parseInt(b.computedStyle(a,"paddingTop"))+parseInt(b.computedStyle(a,"paddingBottom"))+a.clientHeight},window.pageYOffset!==undefined?(b.getPageScrollTop=function(){return window.pageYOffset},b.getPageScrollLeft=function(){return window.pageXOffset}):(b.getPageScrollTop=function(){return document.body.scrollTop},b.getPageScrollLeft=function(){return document.body.scrollLeft}),window.getComputedStyle?b.computedStyle=function(a,b){if(b)return(window.getComputedStyle(a,"")||{})[b]||"";return window.getComputedStyle(a,"")||{}}:b.computedStyle=function(a,b){if(b)return a.currentStyle[b];return a.currentStyle},b.scrollbarWidth=function(){var a=b.createElement("p");a.style.width="100%",a.style.height="200px";var c=b.createElement("div"),d=c.style;d.position="absolute",d.left="-10000px",d.overflow="hidden",d.width="200px",d.height="150px",c.appendChild(a);var e=document.body||document.documentElement;e.appendChild(c);var f=a.offsetWidth;d.overflow="scroll";var g=a.offsetWidth;f==g&&(g=c.clientWidth),e.removeChild(c);return f-g},b.setInnerHtml=function(a,b){var c=a.cloneNode(!1);c.innerHTML=b,a.parentNode.replaceChild(c,a);return c},b.setInnerText=function(a,b){document.body&&"textContent"in document.body?a.textContent=b:a.innerText=b},b.getInnerText=function(a){return document.body&&"textContent"in document.body?a.textContent:a.innerText||a.textContent||""},b.getParentWindow=function(a){return a.defaultView||a.parentWindow},b.getSelectionStart=function(a){var b;try{b=a.selectionStart||0}catch(c){b=0}return b},b.setSelectionStart=function(a,b){return a.selectionStart=b},b.getSelectionEnd=function(a){var b;try{b=a.selectionEnd||0}catch(c){b=0}return b},b.setSelectionEnd=function(a,b){return a.selectionEnd=b}}),define("pilot/event",["require","exports","module","pilot/keys","pilot/useragent","pilot/dom"],function(a,b,c){function g(a,b,c){var f=0;e.isOpera&&e.isMac?f=0|(b.metaKey?1:0)|(b.altKey?2:0)|(b.shiftKey?4:0)|(b.ctrlKey?8:0):f=0|(b.ctrlKey?1:0)|(b.altKey?2:0)|(b.shiftKey?4:0)|(b.metaKey?8:0);if(c in d.MODIFIER_KEYS){switch(d.MODIFIER_KEYS[c]){case"Alt":f=2;break;case"Shift":f=4;break;case"Ctrl":f=1;break;default:f=8}c=0}f&8&&(c==91||c==93)&&(c=0);if(f==0&&!(c in d.FUNCTION_KEYS))return!1;return a(b,f,c)}var d=a("pilot/keys"),e=a("pilot/useragent"),f=a("pilot/dom");b.addListener=function(a,b,c){if(a.addEventListener)return a.addEventListener(b,c,!1);if(a.attachEvent){var d=function(){c(window.event)};c._wrapper=d,a.attachEvent("on"+b,d)}},b.removeListener=function(a,b,c){if(a.removeEventListener)return a.removeEventListener(b,c,!1);a.detachEvent&&a.detachEvent("on"+b,c._wrapper||c)},b.stopEvent=function(a){b.stopPropagation(a),b.preventDefault(a);return!1},b.stopPropagation=function(a){a.stopPropagation?a.stopPropagation():a.cancelBubble=!0},b.preventDefault=function(a){a.preventDefault?a.preventDefault():a.returnValue=!1},b.getDocumentX=function(a){return a.clientX?a.clientX+f.getPageScrollLeft():a.pageX},b.getDocumentY=function(a){return a.clientY?a.clientY+f.getPageScrollTop():a.pageY},b.getButton=function(a){if(a.type=="dblclick")return 0;if(a.type=="contextmenu")return 2;return a.preventDefault?a.button:({1:0,2:2,4:1})[a.button]},document.documentElement.setCapture?b.capture=function(a,c,d){function f(e){c&&c(e),d&&d(),b.removeListener(a,"mousemove",c),b.removeListener(a,"mouseup",f),b.removeListener(a,"losecapture",f),a.releaseCapture()}function e(a){c(a);return b.stopPropagation(a)}b.addListener(a,"mousemove",c),b.addListener(a,"mouseup",f),b.addListener(a,"losecapture",f),a.setCapture()}:b.capture=function(a,b,c){function e(a){b&&b(a),c&&c(),document.removeEventListener("mousemove",d,!0),document.removeEventListener("mouseup",e,!0),a.stopPropagation()}function d(a){b(a),a.stopPropagation()}document.addEventListener("mousemove",d,!0),document.addEventListener("mouseup",e,!0)},b.addMouseWheelListener=function(a,c){var d=function(a){a.wheelDelta!==undefined?a.wheelDeltaX!==undefined?(a.wheelX=-a.wheelDeltaX/8,a.wheelY=-a.wheelDeltaY/8):(a.wheelX=0,a.wheelY=-a.wheelDelta/8):a.axis&&a.axis==a.HORIZONTAL_AXIS?(a.wheelX=(a.detail||0)*5,a.wheelY=0):(a.wheelX=0,a.wheelY=(a.detail||0)*5),c(a)};b.addListener(a,"DOMMouseScroll",d),b.addListener(a,"mousewheel",d)},b.addMultiMouseDownListener=function(a,c,d,f,g){var h=0,i,j,k=function(a){h+=1,h==1&&(i=a.clientX,j=a.clientY,setNativeTimeout(function(){h=0},f||600));var e=b.getButton(a)==c;if(!e||Math.abs(a.clientX-i)>5||Math.abs(a.clientY-j)>5)h=0;h==d&&(h=0,g(a));if(e)return b.preventDefault(a)};b.addListener(a,"mousedown",k),e.isIE&&b.addListener(a,"dblclick",k)},b.addCommandKeyListener=function(a,c){var d=b.addListener;if(e.isOldGecko){var f=null;d(a,"keydown",function(a){f=a.keyCode}),d(a,"keypress",function(a){return g(c,a,f)})}else{var h=null;d(a,"keydown",function(a){h=a.keyIdentifier||a.keyCode;return g(c,a,a.keyCode)}),e.isMac&&e.isOpera&&d(a,"keypress",function(a){var b=a.keyIdentifier||a.keyCode;if(h!==b)return g(c,a,a.keyCode);h=null})}}}),define("ace/editor",["require","exports","module","pilot/fixoldbrowsers","pilot/oop","pilot/event","pilot/lang","pilot/useragent","ace/keyboard/textinput","ace/mouse_handler","ace/keyboard/keybinding","ace/edit_session","ace/search","ace/range","pilot/event_emitter"],function(a,b,c){a("pilot/fixoldbrowsers");var d=a("pilot/oop"),e=a("pilot/event"),f=a("pilot/lang"),g=a("pilot/useragent"),h=a("ace/keyboard/textinput").TextInput,i=a("ace/mouse_handler").MouseHandler,j=a("ace/keyboard/keybinding").KeyBinding,k=a("ace/edit_session").EditSession,l=a("ace/search").Search,m=a("ace/range").Range,n=a("pilot/event_emitter").EventEmitter,o=function(a,b){var c=a.getContainerElement();this.container=c,this.renderer=a,this.textInput=new h(a.getTextAreaContainer(),this),this.keyBinding=new j(this),g.isIPad||(this.$mouseHandler=new i(this)),this.$blockScrolling=0,this.$search=(new l).set({wrap:!0}),this.setSession(b||new k(""))};(function(){d.implement(this,n),this.$forwardEvents={gutterclick:1,gutterdblclick:1},this.$originalAddEventListener=this.addEventListener,this.$originalRemoveEventListener=this.removeEventListener,this.addEventListener=function(a,b){return this.$forwardEvents[a]?this.renderer.addEventListener(a,b):this.$originalAddEventListener(a,b)},this.removeEventListener=function(a,b){return this.$forwardEvents[a]?this.renderer.removeEventListener(a,b):this.$originalRemoveEventListener(a,b)},this.setKeyboardHandler=function(a){this.keyBinding.setKeyboardHandler(a)},this.getKeyboardHandler=function(){return this.keyBinding.getKeyboardHandler()},this.setSession=function(a){if(this.session!=a){if(this.session){var b=this.session;this.session.removeEventListener("change",this.$onDocumentChange),this.session.removeEventListener("changeMode",this.$onChangeMode),this.session.removeEventListener("tokenizerUpdate",this.$onTokenizerUpdate),this.session.removeEventListener("changeTabSize",this.$onChangeTabSize),this.session.removeEventListener("changeWrapLimit",this.$onChangeWrapLimit),this.session.removeEventListener("changeWrapMode",this.$onChangeWrapMode),this.session.removeEventListener("onChangeFold",this.$onChangeFold),this.session.removeEventListener("changeFrontMarker",this.$onChangeFrontMarker),this.session.removeEventListener("changeBackMarker",this.$onChangeBackMarker),this.session.removeEventListener("changeBreakpoint",this.$onChangeBreakpoint),this.session.removeEventListener("changeAnnotation",this.$onChangeAnnotation),this.session.removeEventListener("changeOverwrite",this.$onCursorChange);var c=this.session.getSelection();c.removeEventListener("changeCursor",this.$onCursorChange),c.removeEventListener("changeSelection",this.$onSelectionChange),this.session.setScrollTopRow(this.renderer.getScrollTopRow())}this.session=a,this.$onDocumentChange=this.onDocumentChange.bind(this),a.addEventListener("change",this.$onDocumentChange),this.renderer.setSession(a),this.$onChangeMode=this.onChangeMode.bind(this),a.addEventListener("changeMode",this.$onChangeMode),this.$onTokenizerUpdate=this.onTokenizerUpdate.bind(this),a.addEventListener("tokenizerUpdate",this.$onTokenizerUpdate),this.$onChangeTabSize=this.renderer.updateText.bind(this.renderer),a.addEventListener("changeTabSize",this.$onChangeTabSize),this.$onChangeWrapLimit=this.onChangeWrapLimit.bind(this),a.addEventListener("changeWrapLimit",this.$onChangeWrapLimit),this.$onChangeWrapMode=this.onChangeWrapMode.bind(this),a.addEventListener("changeWrapMode",this.$onChangeWrapMode),this.$onChangeFold=this.onChangeFold.bind(this),a.addEventListener("changeFold",this.$onChangeFold),this.$onChangeFrontMarker=this.onChangeFrontMarker.bind(this),this.session.addEventListener("changeFrontMarker",this.$onChangeFrontMarker),this.$onChangeBackMarker=this.onChangeBackMarker.bind(this),this.session.addEventListener("changeBackMarker",this.$onChangeBackMarker),this.$onChangeBreakpoint=this.onChangeBreakpoint.bind(this),this.session.addEventListener("changeBreakpoint",this.$onChangeBreakpoint),this.$onChangeAnnotation=this.onChangeAnnotation.bind(this),this.session.addEventListener("changeAnnotation",this.$onChangeAnnotation),this.$onCursorChange=this.onCursorChange.bind(this),this.session.addEventListener("changeOverwrite",this.$onCursorChange),this.selection=a.getSelection(),this.selection.addEventListener("changeCursor",this.$onCursorChange),this.$onSelectionChange=this.onSelectionChange.bind(this),this.selection.addEventListener("changeSelection",this.$onSelectionChange),this.onChangeMode(),this.onCursorChange(),this.onSelectionChange(),this.onChangeFrontMarker(),this.onChangeBackMarker(),this.onChangeBreakpoint(),this.onChangeAnnotation(),this.renderer.scrollToRow(a.getScrollTopRow()),this.renderer.updateFull(),this._dispatchEvent("changeSession",{session:a,oldSession:b})}},this.getSession=function(){return this.session},this.getSelection=function(){return this.selection},this.resize=function(){this.renderer.onResize()},this.setTheme=function(a){this.renderer.setTheme(a)},this.getTheme=function(){return this.renderer.getTheme()},this.setStyle=function(a){this.renderer.setStyle(a)},this.unsetStyle=function(a){this.renderer.unsetStyle(a)},this.$highlightBrackets=function(){this.session.$bracketHighlight&&(this.session.removeMarker(this.session.$bracketHighlight),this.session.$bracketHighlight=null);if(!this.$highlightPending){var a=this;this.$highlightPending=!0,setNativeTimeout(function(){a.$highlightPending=!1;var b=a.session.findMatchingBracket(a.getCursorPosition());if(b){var c=new m(b.row,b.column,b.row,b.column+1);a.session.$bracketHighlight=a.session.addMarker(c,"ace_bracket")}},10)}},this.focus=function(){var a=this;g.isIE||setNativeTimeout(function(){a.textInput.focus()}),this.textInput.focus()},this.blur=function(){this.textInput.blur()},this.onFocus=function(){this.renderer.showCursor(),this.renderer.visualizeFocus(),this._dispatchEvent("focus")},this.onBlur=function(){this.renderer.hideCursor(),this.renderer.visualizeBlur(),this._dispatchEvent("blur")},this.onDocumentChange=function(a){var b=a.data,c=b.range;if(c.start.row==c.end.row&&b.action!="insertLines"&&b.action!="removeLines")var d=c.end.row;else d=Infinity;this.renderer.updateLines(c.start.row,d),this.renderer.updateCursor()},this.onTokenizerUpdate=function(a){var b=a.data;this.renderer.updateLines(b.first,b.last)},this.onCursorChange=function(a){this.renderer.updateCursor(),this.$blockScrolling||this.renderer.scrollCursorIntoView(),this.renderer.moveTextAreaToCursor(this.textInput.getElement()),this.$highlightBrackets(),this.$updateHighlightActiveLine()},this.$updateHighlightActiveLine=function(){var a=this.getSession();a.$highlightLineMarker&&a.removeMarker(a.$highlightLineMarker),a.$highlightLineMarker=null;if(this.getHighlightActiveLine()&&(this.getSelectionStyle()!="line"||!this.selection.isMultiLine())){var b=this.getCursorPosition(),c=this.session.getFoldLine(b.row),d;c?d=new m(c.start.row,0,c.end.row+1,0):d=new m(b.row,0,b.row+1,0),a.$highlightLineMarker=a.addMarker(d,"ace_active_line","line")}},this.onSelectionChange=function(a){var b=this.getSession();b.$selectionMarker&&b.removeMarker(b.$selectionMarker),b.$selectionMarker=null;if(this.selection.isEmpty())this.$updateHighlightActiveLine();else{var c=this.selection.getRange(),d=this.getSelectionStyle();b.$selectionMarker=b.addMarker(c,"ace_selection",d)}this.$highlightSelectedWord&&this.session.getMode().highlightSelection(this)},this.onChangeFrontMarker=function(){this.renderer.updateFrontMarkers()},this.onChangeBackMarker=function(){this.renderer.updateBackMarkers()},this.onChangeBreakpoint=function(){this.renderer.setBreakpoints(this.session.getBreakpoints())},this.onChangeAnnotation=function(){this.renderer.setAnnotations(this.session.getAnnotations())},this.onChangeMode=function(){this.renderer.updateText()},this.onChangeWrapLimit=function(){this.renderer.updateFull()},this.onChangeWrapMode=function(){this.renderer.onResize(!0)},this.onChangeFold=function(){this.$updateHighlightActiveLine(),this.renderer.updateFull()},this.getCopyText=function(){return this.selection.isEmpty()?"":this.session.getTextRange(this.getSelectionRange())},this.onCut=function(){this.$readOnly||(this.selection.isEmpty()||(this.session.remove(this.getSelectionRange()),this.clearSelection()))},this.insert=function(a){if(!this.$readOnly){var b=this.session,c=b.getMode(),d=this.getCursorPosition();if(this.getBehavioursEnabled()){var e=c.transformAction(b.getState(d.row),"insertion",this,b,a);e&&(a=e.text)}a=a.replace("\t",this.session.getTabString());if(this.selection.isEmpty()){if(this.session.getOverwrite()){var f=new m.fromPoints(d,d);f.end.column+=a.length,this.session.remove(f)}}else{var d=this.session.remove(this.getSelectionRange());this.clearSelection()}this.clearSelection();var g=d.column,h=b.getState(d.row),i=c.checkOutdent(h,b.getLine(d.row),a),j=b.getLine(d.row),k=c.getNextLineIndent(h,j.slice(0,d.column),b.getTabString()),l=b.insert(d,a);e&&e.selection&&(e.selection.length==2?this.selection.setSelectionRange(new m(d.row,g+e.selection[0],d.row,g+e.selection[1])):this.selection.setSelectionRange(new m(d.row+e.selection[0],e.selection[1],d.row+e.selection[2],e.selection[3])));var h=b.getState(d.row);if(b.getDocument().isNewLine(a)){this.moveCursorTo(d.row+1,0);var n=b.getTabSize(),o=Number.MAX_VALUE;for(var p=d.row+1;p<=l.row;++p){var q=0;j=b.getLine(p);for(var r=0;r<j.length;++r)if(j.charAt(r)=="\t")q+=n;else if(j.charAt(r)==" ")q+=1;else break;/[^\s]/.test(j)&&(o=Math.min(q,o))}for(var p=d.row+1;p<=l.row;++p){var s=o;j=b.getLine(p);for(var r=0;r<j.length&&s>0;++r)j.charAt(r)=="\t"?s-=n:j.charAt(r)==" "&&(s-=1);b.remove(new m(p,0,p,r))}b.indentRows(d.row+1,l.row,k)}else i&&c.autoOutdent(h,b,d.row)}},this.onTextInput=function(a){this.keyBinding.onTextInput(a)},this.onCommandKey=function(a,b,c){this.keyBinding.onCommandKey(a,b,c)},this.setOverwrite=function(a){this.session.setOverwrite(a)},this.getOverwrite=function(){return this.session.getOverwrite()},this.toggleOverwrite=function(){this.session.toggleOverwrite()},this.setScrollSpeed=function(a){this.$mouseHandler.setScrollSpeed(a)},this.getScrollSpeed=function(){return this.$mouseHandler.getScrollSpeed()},this.$selectionStyle="line",this.setSelectionStyle=function(a){this.$selectionStyle!=a&&(this.$selectionStyle=a,this.onSelectionChange(),this._dispatchEvent("changeSelectionStyle",{data:a}))},this.getSelectionStyle=function(){return this.$selectionStyle},this.$highlightActiveLine=!0,this.setHighlightActiveLine=function(a){this.$highlightActiveLine!=a&&(this.$highlightActiveLine=a,this.$updateHighlightActiveLine())},this.getHighlightActiveLine=function(){return this.$highlightActiveLine},this.$highlightSelectedWord=!0,this.setHighlightSelectedWord=function(a){this.$highlightSelectedWord!=a&&(this.$highlightSelectedWord=a,a?this.session.getMode().highlightSelection(this):this.session.getMode().clearSelectionHighlight(this))},this.getHighlightSelectedWord=function(){return this.$highlightSelectedWord},this.setShowInvisibles=function(a){this.getShowInvisibles()!=a&&this.renderer.setShowInvisibles(a)},this.getShowInvisibles=function(){return this.renderer.getShowInvisibles()},this.setShowPrintMargin=function(a){this.renderer.setShowPrintMargin(a)},this.getShowPrintMargin=function(){return this.renderer.getShowPrintMargin()},this.setPrintMarginColumn=function(a){this.renderer.setPrintMarginColumn(a)},this.getPrintMarginColumn=function(){return this.renderer.getPrintMarginColumn()},this.$readOnly=!1,this.setReadOnly=function(a){this.$readOnly=a},this.getReadOnly=function(){return this.$readOnly},this.$modeBehaviours=!1,this.setBehavioursEnabled=function(a){this.$modeBehaviours=a},this.getBehavioursEnabled=function(){return this.$modeBehaviours},this.removeRight=function(){this.$readOnly||(this.selection.isEmpty()&&this.selection.selectRight(),this.session.remove(this.getSelectionRange()),this.clearSelection())},this.removeLeft=function(){if(!this.$readOnly){this.selection.isEmpty()&&this.selection.selectLeft();var a=this.getSelectionRange();if(this.getBehavioursEnabled()){var b=this.session,c=b.getState(a.start.row),d=b.getMode().transformAction(c,"deletion",this,b,a);d!==!1&&(a=d)}this.session.remove(a),this.clearSelection()}},this.removeWordRight=function(){this.$readOnly||(this.selection.isEmpty()&&this.selection.selectWordRight(),this.session.remove(this.getSelectionRange()),this.clearSelection())},this.removeWordLeft=function(){this.$readOnly||(this.selection.isEmpty()&&this.selection.selectWordLeft(),this.session.remove(this.getSelectionRange()),this.clearSelection())},this.removeToLineStart=function(){this.$readOnly||(this.selection.isEmpty()&&this.selection.selectLineStart(),this.session.remove(this.getSelectionRange()),this.clearSelection())},this.removeToLineEnd=function(){if(!this.$readOnly){this.selection.isEmpty()&&this.selection.selectLineEnd();var a=this.getSelectionRange();a.start.column==a.end.column&&a.start.row==a.end.row&&(a.end.column=0,a.end.row++),this.session.remove(a),this.clearSelection()}},this.splitLine=function(){if(!this.$readOnly){this.selection.isEmpty()||(this.session.remove(this.getSelectionRange()),this.clearSelection());var a=this.getCursorPosition();this.insert("\n"),this.moveCursorToPosition(a)}},this.transposeLetters=function(){if(!this.$readOnly){if(!this.selection.isEmpty())return;var a=this.getCursorPosition(),b=a.column;if(b==0)return;var c=this.session.getLine(a.row);if(b<c.length)var d=c.charAt(b)+c.charAt(b-1),e=new m(a.row,b-1,a.row,b+1);else var d=c.charAt(b-1)+c.charAt(b-2),e=new m(a.row,b-2,a.row,b);this.session.replace(e,d)}},this.indent=function(){if(!this.$readOnly){var a=this.session,b=this.getSelectionRange();if(b.start.row>=b.end.row&&b.start.column>=b.end.column){var d;if(this.session.getUseSoftTabs()){var e=a.getTabSize(),g=this.getCursorPosition(),h=a.documentToScreenColumn(g.row,g.column),i=e-h%e;d=f.stringRepeat(" ",i)}else d="\t";return this.onTextInput(d)}var c=this.$getSelectedRows();a.indentRows(c.first,c.last,"\t")}},this.blockOutdent=function(){if(!this.$readOnly){var a=this.session.getSelection();this.session.outdentRows(a.getRange())}},this.toggleCommentLines=function(){if(!this.$readOnly){var a=this.session.getState(this.getCursorPosition().row),b=this.$getSelectedRows();this.session.getMode().toggleCommentLines(a,this.session,b.first,b.last)}},this.removeLines=function(){if(!this.$readOnly){var a=this.$getSelectedRows();this.session.remove(new m(a.first,0,a.last+1,0)),this.clearSelection()}},this.moveLinesDown=function(){this.$readOnly||this.$moveLines(function(a,b){return this.session.moveLinesDown(a,b)})},this.moveLinesUp=function(){this.$readOnly||this.$moveLines(function(a,b){return this.session.moveLinesUp(a,b)})},this.moveText=function(a,b){if(this.$readOnly)return null;return this.session.moveText(a,b)},this.copyLinesUp=function(){this.$readOnly||this.$moveLines(function(a,b){this.session.duplicateLines(a,b);return 0})},this.copyLinesDown=function(){this.$readOnly||this.$moveLines(function(a,b){return this.session.duplicateLines(a,b)})},this.$moveLines=function(a){var b=this.$getSelectedRows(),c=a.call(this,b.first,b.last),d=this.selection;d.setSelectionAnchor(b.last+c+1,0),d.$moveSelection(function(){d.moveCursorTo(b.first+c,0)})},this.$getSelectedRows=function(){var a=this.getSelectionRange().collapseRows();return{first:a.start.row,last:a.end.row}},this.onCompositionStart=function(a){this.renderer.showComposition(this.getCursorPosition())},this.onCompositionUpdate=function(a){this.renderer.setCompositionText(a)},this.onCompositionEnd=function(){this.renderer.hideComposition()},this.getFirstVisibleRow=function(){return this.renderer.getFirstVisibleRow()},this.getLastVisibleRow=function(){return this.renderer.getLastVisibleRow()},this.isRowVisible=function(a){return a>=this.getFirstVisibleRow()&&a<=this.getLastVisibleRow()},this.$getVisibleRowCount=function(){return this.renderer.getScrollBottomRow()-this.renderer.getScrollTopRow()+1},this.$getPageDownRow=function(){return this.renderer.getScrollBottomRow()},this.$getPageUpRow=function(){var a=this.renderer.getScrollTopRow(),b=this.renderer.getScrollBottomRow();return a-(b-a)},this.selectPageDown=function(){var a=this.$getPageDownRow()+Math.floor(this.$getVisibleRowCount()/2);this.scrollPageDown();var b=this.getSelection(),c=this.session.documentToScreenPosition(b.getSelectionLead()),d=this.session.screenToDocumentPosition(a,c.column);b.selectTo(d.row,d.column)},this.selectPageUp=function(){var a=this.renderer.getScrollTopRow()-this.renderer.getScrollBottomRow(),b=this.$getPageUpRow()+Math.round(a/2);this.scrollPageUp();var c=this.getSelection(),d=this.session.documentToScreenPosition(c.getSelectionLead()),e=this.session.screenToDocumentPosition(b,d.column);c.selectTo(e.row,e.column)},this.gotoPageDown=function(){var a=this.$getPageDownRow(),b=this.getCursorPositionScreen().column;this.scrollToRow(a),this.getSelection().moveCursorToScreen(a,b)},this.gotoPageUp=function(){var a=this.$getPageUpRow(),b=this.getCursorPositionScreen().column;this.scrollToRow(a),this.getSelection().moveCursorToScreen(a,b)},this.scrollPageDown=function(){this.scrollToRow(this.$getPageDownRow())},this.scrollPageUp=function(){this.renderer.scrollToRow(this.$getPageUpRow())},this.scrollToRow=function(a){this.renderer.scrollToRow(a)},this.scrollToLine=function(a,b){this.renderer.scrollToLine(a,b)},this.centerSelection=function(){var a=this.getSelectionRange(),b=Math.floor(a.start.row+(a.end.row-a.start.row)/2);this.renderer.scrollToLine(b,!0)},this.getCursorPosition=function(){return this.selection.getCursor()},this.getCursorPositionScreen=function(){return this.session.documentToScreenPosition(this.getCursorPosition())},this.getSelectionRange=function(){return this.selection.getRange()},this.selectAll=function(){this.$blockScrolling+=1,this.selection.selectAll(),this.$blockScrolling-=1},this.clearSelection=function(){this.selection.clearSelection()},this.moveCursorTo=function(a,b){this.selection.moveCursorTo(a,b)},this.moveCursorToPosition=function(a){this.selection.moveCursorToPosition(a)},this.gotoLine=function(a,b){this.selection.clearSelection(),this.$blockScrolling+=1,this.moveCursorTo(a-1,b||0),this.$blockScrolling-=1,this.isRowVisible(this.getCursorPosition().row)||this.scrollToLine(a,!0)},this.navigateTo=function(a,b){this.clearSelection(),this.moveCursorTo(a,b)},this.navigateUp=function(a){this.selection.clearSelection(),a=a||1,this.selection.moveCursorBy(-a,0)},this.navigateDown=function(a){this.selection.clearSelection(),a=a||1,this.selection.moveCursorBy(a,0)},this.navigateLeft=function(a){if(this.selection.isEmpty()){a=a||1;while(a--)this.selection.moveCursorLeft()}else{var b=this.getSelectionRange().start;this.moveCursorToPosition(b)}this.clearSelection()},this.navigateRight=function(a){if(this.selection.isEmpty()){a=a||1;while(a--)this.selection.moveCursorRight()}else{var b=this.getSelectionRange().end;this.moveCursorToPosition(b)}this.clearSelection()},this.navigateLineStart=function(){this.selection.moveCursorLineStart(),this.clearSelection()},this.navigateLineEnd=function(){this.selection.moveCursorLineEnd(),this.clearSelection()},this.navigateFileEnd=function(){this.selection.moveCursorFileEnd(),this.clearSelection()},this.navigateFileStart=function(){this.selection.moveCursorFileStart(),this.clearSelection()},this.navigateWordRight=function(){this.selection.moveCursorWordRight(),this.clearSelection()},this.navigateWordLeft=function(){this.selection.moveCursorWordLeft(),this.clearSelection()},this.replace=function(a,b){b&&this.$search.set(b);var c=this.$search.find(this.session);this.$tryReplace(c,a),c!==null&&this.selection.setSelectionRange(c)},this.replaceAll=function(a,b){b&&this.$search.set(b);var c=this.$search.findAll(this.session);if(c.length){var d=this.getSelectionRange();this.clearSelection(),this.selection.moveCursorTo(0,0),this.$blockScrolling+=1;for(var e=c.length-1;e>=0;--e)this.$tryReplace(c[e],a);this.selection.setSelectionRange(d),this.$blockScrolling-=1}},this.$tryReplace=function(a,b){var c=this.session.getTextRange(a),b=this.$search.replace(c,b);if(b!==null){a.end=this.session.replace(a,b);return a}return null},this.getLastSearchOptions=function(){return this.$search.getOptions()},this.find=function(a,b){this.clearSelection(),b=b||{},b.needle=a,this.$search.set(b),this.$find()},this.findNext=function(a){a=a||{},typeof a.backwards=="undefined"&&(a.backwards=!1),this.$search.set(a),this.$find()},this.findPrevious=function(a){a=a||{},typeof a.backwards=="undefined"&&(a.backwards=!0),this.$search.set(a),this.$find()},this.$find=function(a){this.selection.isEmpty()||this.$search.set({needle:this.session.getTextRange(this.getSelectionRange())}),typeof a!="undefined"&&this.$search.set({backwards:a});var b=this.$search.find(this.session);b&&(this.gotoLine(b.end.row+1,b.end.column),this.selection.setSelectionRange(b))},this.undo=function(){this.session.getUndoManager().undo()},this.redo=function(){this.session.getUndoManager().redo()},this.destroy=function(){this.renderer.destroy()}}).call(o.prototype),b.Editor=o}),define("ace/keyboard/textinput",["require","exports","module","pilot/event","pilot/useragent","pilot/dom"],function(a,b,c){var d=a("pilot/event"),e=a("pilot/useragent"),f=a("pilot/dom"),g=function(a,b){function k(a){if(!i){var d=a||c.value;d&&(d.charCodeAt(d.length-1)==g.charCodeAt(0)?(d=d.slice(0,-1),d&&b.onTextInput(d)):b.onTextInput(d))}i=!1,c.value=g,c.select()}var c=f.createElement("textarea");c.style.left="-10000px",a.appendChild(c);var g=String.fromCharCode(0);k();var h=!1,i=!1,j="",l=function(a){(!e.isIE||c.value.charCodeAt(0)<=128)&&setNativeTimeout(function(){h||k()},0)},m=function(a){h=!0,e.isIE||(k(),c.value=""),b.onCompositionStart(),e.isGecko||setNativeTimeout(n,0)},n=function(){h&&b.onCompositionUpdate(c.value)},o=function(a){h=!1,b.onCompositionEnd(),e.isGecko?k():setNativeTimeout(function(){h||k()},0)},p=function(a){i=!0;var d=b.getCopyText();d?c.value=d:a.preventDefault(),c.select(),setNativeTimeout(function(){k()},0)},q=function(a){i=!0;var d=b.getCopyText();d?(c.value=d,b.onCut()):a.preventDefault(),c.select(),setNativeTimeout(function(){k()},0)};d.addCommandKeyListener(c,b.onCommandKey.bind(b)),d.addListener(c,"keypress",l);if(e.isIE){var r={13:1,27:1};d.addListener(c,"keyup",function(a){h&&(!c.value||r[a.keyCode])&&setNativeTimeout(o,0);(c.value.charCodeAt(0)|0)>=129&&(h?n():m())})}d.addListener(c,"textInput",l),d.addListener(c,"paste",function(a){a.clipboardData&&a.clipboardData.getData?(k(a.clipboardData.getData("text/plain")),a.preventDefault()):l()}),e.isIE||d.addListener(c,"propertychange",l),e.isIE?(d.addListener(c,"beforecopy",function(a){var c=b.getCopyText();c?clipboardData.setData("Text",c):a.preventDefault()}),d.addListener(a,"keydown",function(a){if(a.ctrlKey&&a.keyCode==88){var c=b.getCopyText();c&&(clipboardData.setData("Text",c),b.onCut()),d.preventDefault(a)}})):(d.addListener(c,"copy",p),d.addListener(c,"cut",q)),d.addListener(c,"compositionstart",m),e.isGecko&&d.addListener(c,"text",n),e.isWebKit&&d.addListener(c,"keyup",n),d.addListener(c,"compositionend",o),d.addListener(c,"blur",function(){b.onBlur()}),d.addListener(c,"focus",function(){b.onFocus(),c.select()}),this.focus=function(){b.onFocus(),c.select(),c.focus()},this.blur=function(){c.blur()},this.getElement=function(){return c},this.onContextMenu=function(a,b){a&&(j||(j=c.style.cssText),c.style.cssText="position:fixed; z-index:1000;left:"+(a.x-2)+"px; top:"+(a.y-2)+"px;"),b&&(c.value="")},this.onContextMenuClose=function(){setNativeTimeout(function(){j&&(c.style.cssText=j,j=""),k()},0)}};b.TextInput=g}),define("ace/mouse_handler",["require","exports","module","pilot/event","pilot/dom"],function(a,b,c){var d=a("pilot/event"),e=a("pilot/dom"),f=0,g=1,h=2,i=250,j=5,k=function(a){this.editor=a,d.addListener(a.container,"mousedown",function(b){a.focus();return d.preventDefault(b)}),d.addListener(a.container,"selectstart",function(a){return d.preventDefault(a)});var b=a.renderer.getMouseEventTarget();d.addListener(b,"mousedown",this.onMouseDown.bind(this)),d.addMultiMouseDownListener(b,0,2,500,this.onMouseDoubleClick.bind(this)),d.addMultiMouseDownListener(b,0,3,600,this.onMouseTripleClick.bind(this)),d.addMultiMouseDownListener(b,0,4,600,this.onMouseQuadClick.bind(this)),d.addMouseWheelListener(b,this.onMouseWheel.bind(this))};(function(){this.$scrollSpeed=1,this.setScrollSpeed=function(a){this.$scrollSpeed=a},this.getScrollSpeed=function(){return this.$scrollSpeed},this.$getEventPosition=function(a){var b=d.getDocumentX(a),c=d.getDocumentY(a),e=this.editor.renderer.screenToTextCoordinates(b,c);e.row=Math.max(0,Math.min(e.row,this.editor.session.getLength()-1));return e},this.$distance=function(a,b,c,d){return Math.sqrt(Math.pow(c-a,2)+Math.pow(d-b,2))},this.onMouseDown=function(a){function D(b){a.shiftKey?l.selection.selectToPosition(b):m.$clickSelection||(l.moveCursorToPosition(b),l.selection.clearSelection(b.row,b.column)),p=g}var b=d.getDocumentX(a),c=d.getDocumentY(a),k=this.$getEventPosition(a),l=this.editor,m=this,n=l.getSelectionRange(),o=n.isEmpty(),p=f,q=!1,r=d.getButton(a);if(r!==0)o&&l.moveCursorToPosition(k),r==2&&(l.textInput.onContextMenu({x:b,y:c},o),d.capture(l.container,function(){},l.textInput.onContextMenuClose));else{var s=l.session.getFoldAt(k.row,k.column,1);if(s){l.selection.setSelectionRange(s.range);return}q=!l.getReadOnly()&&!o&&n.contains(k.row,k.column),q||D(k);var t,u,v=l.getOverwrite(),w=(new Date).getTime(),x,y,z=function(a){t=d.getDocumentX(a),u=d.getDocumentY(a)},A=function(){clearInterval(G),p==f?D(k):p==h&&B(),m.$clickSelection=null,p=f},B=function(){e.removeCssClass(l.container,"ace_dragging"),l.session.removeMarker(dragSelectionMarker),m.$clickSelection||(x||(l.moveCursorToPosition(k),l.selection.clearSelection(k.row,k.column)));if(x){if(y.contains(x.row,x.column)){x=null;return}l.clearSelection();var a=l.moveText(y,x);if(!a){x=null;return}l.selection.setSelectionRange(a)}},C=function(){if(t!==undefined&&u!==undefined){if(p==f){var a=m.$distance(b,c,t,u),d=(new Date).getTime();if(a>j){p=g;var k=l.renderer.screenToTextCoordinates(t,u);k.row=Math.max(0,Math.min(k.row,l.session.getLength()-1)),D(k)}else if(d-w>i){p=h,y=l.getSelectionRange();var n=l.getSelectionStyle();dragSelectionMarker=l.session.addMarker(y,"ace_selection",n),l.clearSelection(),e.addCssClass(l.container,"ace_dragging")}}p==h?F():p==g&&E()}},E=function(){var a=l.renderer.screenToTextCoordinates(t,u);a.row=Math.max(0,Math.min(a.row,l.session.getLength()-1));if(m.$clickSelection)if(m.$clickSelection.contains(a.row,a.column))l.selection.setSelectionRange(m.$clickSelection);else{if(m.$clickSelection.compare(a.row,a.column)==-1)var b=m.$clickSelection.end;else var b=m.$clickSelection.start;l.selection.setSelectionAnchor(b.row,b.column),l.selection.selectToPosition(a)}else l.selection.selectToPosition(a);l.renderer.scrollCursorIntoView()},F=function(){x=l.renderer.screenToTextCoordinates(t,u),x.row=Math.max(0,Math.min(x.row,l.session.getLength()-1)),l.moveCursorToPosition(x)};d.capture(l.container,z,A);var G=setInterval(C,20);return d.preventDefault(a)}},this.onMouseDoubleClick=function(a){var b=this.editor,c=this.$getEventPosition(a),d=b.session.getFoldAt(c.row,c.column,1);d?b.session.expandFold(d):(b.moveCursorToPosition(c),b.selection.selectWord(),this.$clickSelection=b.getSelectionRange())},this.onMouseTripleClick=function(a){var b=this.$getEventPosition(a);this.editor.moveCursorToPosition(b),this.editor.selection.selectLine(),this.$clickSelection=this.editor.getSelectionRange()},this.onMouseQuadClick=function(a){this.editor.selectAll(),this.$clickSelection=this.editor.getSelectionRange()},this.onMouseWheel=function(a){var b=this.$scrollSpeed*2;this.editor.renderer.scrollBy(a.wheelX*b,a.wheelY*b);return d.preventDefault(a)}}).call(k.prototype),b.MouseHandler=k}),define("ace/keyboard/keybinding",["require","exports","module","pilot/useragent","pilot/keys","pilot/event","pilot/settings","pilot/canon","ace/commands/default_commands"],function(a,b,c){var d=a("pilot/useragent"),e=a("pilot/keys"),f=a("pilot/event"),g=a("pilot/settings").settings,h=a("pilot/canon");a("ace/commands/default_commands");var i=function(a){this.$editor=a,this.$data={},this.$keyboardHandler=null};(function(){this.setKeyboardHandler=function(a){this.$keyboardHandler!=a&&(this.$data={},this.$keyboardHandler=a)},this.getKeyboardHandler=function(){return this.$keyboardHandler},this.$callKeyboardHandler=function(a,b,c,d){var e={editor:this.$editor},g;this.$keyboardHandler&&(g=this.$keyboardHandler.handleKeyboard(this.$data,b,c,d,a));if(!g||!g.command)b!=0||d!=0?g={command:h.findKeyCommand(e,"editor",b,c)}:g={command:"inserttext",args:{text:c}};if(g){var i=h.exec(g.command,e,"editor",g.args);if(i)return f.stopEvent(a)}},this.onCommandKey=function(a,b,c){var d=e.keyCodeToString(c);this.$callKeyboardHandler(a,b,d,c)},this.onTextInput=function(a){this.$callKeyboardHandler({},0,a,0)}}).call(i.prototype),b.KeyBinding=i}),define("ace/commands/default_commands",["require","exports","module","pilot/lang","pilot/canon"],function(a,b,c){function f(a,b){return{win:a,mac:b,sender:"editor"}}var d=a("pilot/lang"),e=a("pilot/canon");e.addCommand({name:"null",exec:function(a,b,c){}}),e.addCommand({name:"selectall",bindKey:f("Ctrl-A","Command-A"),exec:function(a,b,c){a.editor.selectAll()}}),e.addCommand({name:"removeline",bindKey:f("Ctrl-D","Command-D"),exec:function(a,b,c){a.editor.removeLines()}}),e.addCommand({name:"gotoline",bindKey:f("Ctrl-L","Command-L"),exec:function(a,b,c){var d=parseInt(prompt("Enter line number:"));isNaN(d)||a.editor.gotoLine(d)}}),e.addCommand({name:"togglecomment",bindKey:f("Ctrl-7","Command-7"),exec:function(a,b,c){a.editor.toggleCommentLines()}}),e.addCommand({name:"findnext",bindKey:f("Ctrl-K","Command-G"),exec:function(a,b,c){a.editor.findNext()}}),e.addCommand({name:"findprevious",bindKey:f("Ctrl-Shift-K","Command-Shift-G"),exec:function(a,b,c){a.editor.findPrevious()}}),e.addCommand({name:"find",bindKey:f("Ctrl-F","Command-F"),exec:function(a,b,c){var d=prompt("Find:");a.editor.find(d)}}),e.addCommand({name:"replace",bindKey:f("Ctrl-R","Command-Option-F"),exec:function(a,b,c){var d=prompt("Find:");if(d){var e=prompt("Replacement:");if(!e)return;a.editor.replace(e,{needle:d})}}}),e.addCommand({name:"replaceall",bindKey:f("Ctrl-Shift-R","Command-Shift-Option-F"),exec:function(a,b,c){var d=prompt("Find:");if(d){var e=prompt("Replacement:");if(!e)return;a.editor.replaceAll(e,{needle:d})}}}),e.addCommand({name:"undo",bindKey:f("Ctrl-Z","Command-Z"),exec:function(a,b,c){a.editor.undo()}}),e.addCommand({name:"redo",bindKey:f("Ctrl-Shift-Z|Ctrl-Y","Command-Shift-Z|Command-Y"),exec:function(a,b,c){a.editor.redo()}}),e.addCommand({name:"overwrite",bindKey:f("Insert","Insert"),exec:function(a,b,c){a.editor.toggleOverwrite()}}),e.addCommand({name:"copylinesup",bindKey:f("Ctrl-Alt-Up","Command-Option-Up"),exec:function(a,b,c){a.editor.copyLinesUp()}}),e.addCommand({name:"movelinesup",bindKey:f("Alt-Up","Option-Up"),exec:function(a,b,c){a.editor.moveLinesUp()}}),e.addCommand({name:"selecttostart",bindKey:f("Ctrl-Shift-Home|Alt-Shift-Up","Command-Shift-Up"),exec:function(a,b,c){a.editor.getSelection().selectFileStart()}}),e.addCommand({name:"gotostart",bindKey:f("Ctrl-Home|Ctrl-Up","Command-Home|Command-Up"),exec:function(a,b,c){a.editor.navigateFileStart()}}),e.addCommand({name:"selectup",bindKey:f("Shift-Up","Shift-Up"),exec:function(a,b,c){a.editor.getSelection().selectUp()}}),e.addCommand({name:"golineup",bindKey:f("Up","Up|Ctrl-P"),exec:function(a,b,c){a.editor.navigateUp(b.times)}}),e.addCommand({name:"copylinesdown",bindKey:f("Ctrl-Alt-Down","Command-Option-Down"),exec:function(a,b,c){a.editor.copyLinesDown()}}),e.addCommand({name:"movelinesdown",bindKey:f("Alt-Down","Option-Down"),exec:function(a,b,c){a.editor.moveLinesDown()}}),e.addCommand({name:"selecttoend",bindKey:f("Ctrl-Shift-End|Alt-Shift-Down","Command-Shift-Down"),exec:function(a,b,c){a.editor.getSelection().selectFileEnd()}}),e.addCommand({name:"gotoend",bindKey:f("Ctrl-End|Ctrl-Down","Command-End|Command-Down"),exec:function(a,b,c){a.editor.navigateFileEnd()}}),e.addCommand({name:"selectdown",bindKey:f("Shift-Down","Shift-Down"),exec:function(a,b,c){a.editor.getSelection().selectDown()}}),e.addCommand({name:"golinedown",bindKey:f("Down","Down|Ctrl-N"),exec:function(a,b,c){a.editor.navigateDown(b.times)}}),e.addCommand({name:"selectwordleft",bindKey:f("Ctrl-Shift-Left","Option-Shift-Left"),exec:function(a,b,c){a.editor.getSelection().selectWordLeft()}}),e.addCommand({name:"gotowordleft",bindKey:f("Ctrl-Left","Option-Left"),exec:function(a,b,c){a.editor.navigateWordLeft()}}),e.addCommand({name:"selecttolinestart",bindKey:f("Alt-Shift-Left","Command-Shift-Left"),exec:function(a,b,c){a.editor.getSelection().selectLineStart()}}),e.addCommand({name:"gotolinestart",bindKey:f("Alt-Left|Home","Command-Left|Home|Ctrl-A"),exec:function(a,b,c){a.editor.navigateLineStart()}}),e.addCommand({name:"selectleft",bindKey:f("Shift-Left","Shift-Left"),exec:function(a,b,c){a.editor.getSelection().selectLeft()}}),e.addCommand({name:"gotoleft",bindKey:f("Left","Left|Ctrl-B"),exec:function(a,b,c){a.editor.navigateLeft(b.times)}}),e.addCommand({name:"selectwordright",bindKey:f("Ctrl-Shift-Right","Option-Shift-Right"),exec:function(a,b,c){a.editor.getSelection().selectWordRight()}}),e.addCommand({name:"gotowordright",bindKey:f("Ctrl-Right","Option-Right"),exec:function(a,b,c){a.editor.navigateWordRight()}}),e.addCommand({name:"selecttolineend",bindKey:f("Alt-Shift-Right","Command-Shift-Right"),exec:function(a,b,c){a.editor.getSelection().selectLineEnd()}}),e.addCommand({name:"gotolineend",bindKey:f("Alt-Right|End","Command-Right|End|Ctrl-E"),exec:function(a,b,c){a.editor.navigateLineEnd()}}),e.addCommand({name:"selectright",bindKey:f("Shift-Right","Shift-Right"),exec:function(a,b,c){a.editor.getSelection().selectRight()}}),e.addCommand({name:"gotoright",bindKey:f("Right","Right|Ctrl-F"),exec:function(a,b,c){a.editor.navigateRight(b.times)}}),e.addCommand({name:"selectpagedown",bindKey:f("Shift-PageDown","Shift-PageDown"),exec:function(a,b,c){a.editor.selectPageDown()}}),e.addCommand({name:"pagedown",bindKey:f(null,"PageDown"),exec:function(a,b,c){a.editor.scrollPageDown()}}),e.addCommand({name:"gotopagedown",bindKey:f("PageDown","Option-PageDown|Ctrl-V"),exec:function(a,b,c){a.editor.gotoPageDown()}}),e.addCommand({name:"selectpageup",bindKey:f("Shift-PageUp","Shift-PageUp"),exec:function(a,b,c){a.editor.selectPageUp()}}),e.addCommand({name:"pageup",bindKey:f(null,"PageUp"),exec:function(a,b,c){a.editor.scrollPageUp()}}),e.addCommand({name:"gotopageup",bindKey:f("PageUp","Option-PageUp"),exec:function(a,b,c){a.editor.gotoPageUp()}}),e.addCommand({name:"selectlinestart",bindKey:f("Shift-Home","Shift-Home"),exec:function(a,b,c){a.editor.getSelection().selectLineStart()}}),e.addCommand({name:"selectlineend",bindKey:f("Shift-End","Shift-End"),exec:function(a,b,c){a.editor.getSelection().selectLineEnd()}}),e.addCommand({name:"del",bindKey:f("Delete","Delete|Ctrl-D"),exec:function(a,b,c){a.editor.removeRight()}}),e.addCommand({name:"backspace",bindKey:f("Ctrl-Backspace|Command-Backspace|Option-Backspace|Shift-Backspace|Backspace","Ctrl-Backspace|Command-Backspace|Shift-Backspace|Backspace|Ctrl-H"),exec:function(a,b,c){a.editor.removeLeft()}}),e.addCommand({name:"removetolinestart",bindKey:f(null,"Option-Backspace"),exec:function(a,b,c){a.editor.removeToLineStart()}}),e.addCommand({name:"removetolineend",bindKey:f(null,"Ctrl-K"),exec:function(a,b,c){a.editor.removeToLineEnd()}}),e.addCommand({name:"removewordleft",bindKey:f(null,"Alt-Backspace|Ctrl-Alt-Backspace"),exec:function(a,b,c){a.editor.removeWordLeft()}}),e.addCommand({name:"removewordright",bindKey:f(null,"Alt-Delete"),exec:function(a,b,c){a.editor.removeWordRight()}}),e.addCommand({name:"outdent",bindKey:f("Shift-Tab","Shift-Tab"),exec:function(a,b,c){a.editor.blockOutdent()}}),e.addCommand({name:"indent",bindKey:f("Tab","Tab"),exec:function(a,b,c){a.editor.indent()}}),e.addCommand({name:"inserttext",exec:function(a,b,c){a.editor.insert(d.stringRepeat(b.text||"",b.times||1))}}),e.addCommand({name:"centerselection",bindKey:f(null,"Ctrl-L"),exec:function(a,b,c){a.editor.centerSelection()}}),e.addCommand({name:"splitline",bindKey:f(null,"Ctrl-O"),exec:function(a,b,c){a.editor.splitLine()}}),e.addCommand({name:"transposeletters",bindKey:f("Ctrl-T","Ctrl-T"),exec:function(a,b,c){a.editor.transposeLetters()}})}),define("ace/edit_session",["require","exports","module","pilot/oop","pilot/lang","pilot/event_emitter","ace/selection","ace/mode/text","ace/range","ace/document","ace/background_tokenizer","ace/edit_session/folding"],function(a,b,c){var d=a("pilot/oop"),e=a("pilot/lang"),f=a("pilot/event_emitter").EventEmitter,g=a("ace/selection").Selection,h=a("ace/mode/text").Mode,j=a("ace/range").Range,k=a("ace/document").Document,l=a("ace/background_tokenizer").BackgroundTokenizer,m=function(a,b){this.$modified=!0,this.$breakpoints=[],this.$frontMarkers={},this.$backMarkers={},this.$markerId=1,this.$rowCache=[],this.$rowCacheSize=1e3,this.$wrapData=[],this.$foldData=[],this.$foldData.toString=function(){var a="";this.forEach(function(b){a+="\n"+b.toString()});return a},this.$docChangeCounter=0,a instanceof k?this.setDocument(a):this.setDocument(new k(a)),this.selection=new g(this),b?this.setMode(b):this.setMode(new h)};(function(){function o(a){if(a<4352)return!1;return a>=4352&&a<=4447||a>=4515&&a<=4519||a>=4602&&a<=4607||a>=9001&&a<=9002||a>=11904&&a<=11929||a>=11931&&a<=12019||a>=12032&&a<=12245||a>=12272&&a<=12283||a>=12288&&a<=12350||a>=12353&&a<=12438||a>=12441&&a<=12543||a>=12549&&a<=12589||a>=12593&&a<=12686||a>=12688&&a<=12730||a>=12736&&a<=12771||a>=12784&&a<=12830||a>=12832&&a<=12871||a>=12880&&a<=13054||a>=13056&&a<=19903||a>=19968&&a<=42124||a>=42128&&a<=42182||a>=43360&&a<=43388||a>=44032&&a<=55203||a>=55216&&a<=55238||a>=55243&&a<=55291||a>=63744&&a<=64255||a>=65040&&a<=65049||a>=65072&&a<=65106||a>=65108&&a<=65126||a>=65128&&a<=65131||a>=65281&&a<=65376||a>=65504&&a<=65510}d.implement(this,f),this.setDocument=function(a){if(this.doc)throw new Error("Document is already set");this.doc=a,a.on("change",this.onChange.bind(this)),a.on("changeStart",this.onChangeStart.bind(this)),a.on("changeEnd",this.onChangeEnd.bind(this)),this.on("changeFold",this.onChangeFold.bind(this))},this.getDocument=function(){return this.doc},this.onChangeStart=function(){this.$docChangeCounter++},this.$resetRowCache=function(a){if(a==0)this.$rowCache=[];else{var b=this.$rowCache;for(var c=0;c<b.length;c++)if(b[c].docRow>=a){b.splice(c,b.length);return}}},this.onChangeEnd=function(){this.$docChangeCounter--,this.$docChangeCounter==0&&!this.$fromUndo&&this.$undoManager&&(this.$deltasFold.length&&(this.$deltas.push({group:"fold",deltas:this.$deltasFold}),this.$deltasFold=[]),this.$deltasDoc&&(this.$deltas.push({group:"doc",deltas:this.$deltasDoc}),this.$deltasDoc=[]),this.$informUndoManager.schedule())},this.onChangeFold=function(a){var b=a.data;this.$resetRowCache(b.start.row)},this.onChange=function(a){var b=a.data;this.$modified=!0,this.$resetRowCache(b.range.start.row);var c=this.$updateInternalDataOnChange(a);!this.$fromUndo&&this.$undoManager&&!b.ignore&&(this.$deltasDoc.push(b),c&&c.length!=0&&this.$deltasFold.push({action:"removeFolds",folds:c})),this.bgTokenizer.start(b.range.start.row),this._dispatchEvent("change",a)},this.setValue=function(a){this.doc.setValue(a),this.$resetRowCache(0),this.$deltas=[],this.$deltasDoc=[],this.$deltasFold=[],this.getUndoManager().reset()},this.getValue=this.toString=function(){return this.doc.getValue()},this.getSelection=function(){return this.selection},this.getState=function(a){return this.bgTokenizer.getState(a)},this.getTokens=function(a,b){return this.bgTokenizer.getTokens(a,b)},this.setUndoManager=function(a){this.$undoManager=a,this.$resetRowCache(0),this.$deltas=[],this.$deltasDoc=[],this.$deltasFold=[],this.$informUndoManager&&this.$informUndoManager.cancel();if(a){var b=this;this.$syncInformUndoManager=function(){b.$informUndoManager.cancel(),b.$deltas.length>0&&a.execute({action:"aceupdate",args:[b.$deltas,b]}),b.$deltas=[]},this.$informUndoManager=e.deferredCall(this.$syncInformUndoManager)}},this.$defaultUndoManager={undo:function(){},redo:function(){},reset:function(){}},this.getUndoManager=function(){return this.$undoManager||this.$defaultUndoManager},this.getTabString=function(){return this.getUseSoftTabs()?e.stringRepeat(" ",this.getTabSize()):"\t"},this.$useSoftTabs=!0,this.setUseSoftTabs=function(a){this.$useSoftTabs!==a&&(this.$useSoftTabs=a)},this.getUseSoftTabs=function(){return this.$useSoftTabs},this.$tabSize=4,this.setTabSize=function(a){!isNaN(a)&&this.$tabSize!==a&&(this.$modified=!0,this.$tabSize=a,this._dispatchEvent("changeTabSize"))},this.getTabSize=function(){return this.$tabSize},this.isTabStop=function(a){return this.$useSoftTabs&&a.column%this.$tabSize==0},this.$overwrite=!1,this.setOverwrite=function(a){this.$overwrite!=a&&(this.$overwrite=a,this._dispatchEvent("changeOverwrite"))},this.getOverwrite=function(){return this.$overwrite},this.toggleOverwrite=function(){this.setOverwrite(!this.$overwrite)},this.getBreakpoints=function(){return this.$breakpoints},this.setBreakpoints=function(a){this.$breakpoints=[];for(var b=0;b<a.length;b++)this.$breakpoints[a[b]]=!0;this._dispatchEvent("changeBreakpoint",{})},this.clearBreakpoints=function(){this.$breakpoints=[],this._dispatchEvent("changeBreakpoint",{})},this.setBreakpoint=function(a){this.$breakpoints[a]=!0,this._dispatchEvent("changeBreakpoint",{})},this.clearBreakpoint=function(a){delete this.$breakpoints[a],this._dispatchEvent("changeBreakpoint",{})},this.getBreakpoints=function(){return this.$breakpoints},this.addMarker=function(a,b,c,d){var e=this.$markerId++,f={range:a,type:c||"line",renderer:typeof c=="function"?c:null,clazz:b,inFront:!!d};d?(this.$frontMarkers[e]=f,this._dispatchEvent("changeFrontMarker")):(this.$backMarkers[e]=f,this._dispatchEvent("changeBackMarker"));return e},this.removeMarker=function(a){var b=this.$frontMarkers[a]||this.$backMarkers[a];if(b){var c=b.inFront?this.$frontMarkers:this.$backMarkers;b&&(delete c[a],this._dispatchEvent(b.inFront?"changeFrontMarker":"changeBackMarker"))}},this.getMarkers=function(a){return a?this.$frontMarkers:this.$backMarkers},this.setAnnotations=function(a){this.$annotations={};for(var b=0;b<a.length;b++){var c=a[b],d=c.row;this.$annotations[d]?this.$annotations[d].push(c):this.$annotations[d]=[c]}this._dispatchEvent("changeAnnotation",{})},this.getAnnotations=function(){return this.$annotations},this.clearAnnotations=function(){this.$annotations={},this._dispatchEvent("changeAnnotation",{})},this.$detectNewLine=function(a){var b=a.match(/^.*?(\r?\n)/m);b?this.$autoNewLine=b[1]:this.$autoNewLine="\n"},this.tokenRe=/^[\w\d]+/g,this.nonTokenRe=/^(?:[^\w\d]|[\u3040-\u309F]|[\u30A0-\u30FF]|[\u4E00-\u9FFF\uF900-\uFAFF\u3400-\u4DBF])+/g,this.getWordRange=function(a,b){var c=this.getLine(a),d=!1;b>0&&(d=!!c.charAt(b-1).match(this.tokenRe)),d||(d=!!c.charAt(b).match(this.tokenRe));var e=d?this.tokenRe:this.nonTokenRe,f=b;if(f>0){do f--;while(f>=0&&c.charAt(f).match(e));f++}var g=b;while(g<c.length&&c.charAt(g).match(e))g++;return new j(a,f,a,g)},this.setNewLineMode=function(a){this.doc.setNewLineMode(a)},this.getNewLineMode=function(){return this.doc.getNewLineMode()},this.$useWorker=!0,this.setUseWorker=function(a){this.$useWorker!=a&&(this.$useWorker=a,this.$stopWorker(),a&&this.$startWorker())},this.getUseWorker=function(){return this.$useWorker},this.onReloadTokenizer=function(a){var b=a.data;this.bgTokenizer.start(b.first),this._dispatchEvent("tokenizerUpdate",a)},this.$mode=null,this.setMode=function(a){if(this.$mode!==a){this.$mode=a,this.$stopWorker(),this.$useWorker&&this.$startWorker();var b=a.getTokenizer();if(b.addEventListener!==undefined){var c=this.onReloadTokenizer.bind(this);b.addEventListener("update",c)}if(this.bgTokenizer)this.bgTokenizer.setTokenizer(b);else{this.bgTokenizer=new l(b);var d=this;this.bgTokenizer.addEventListener("update",function(a){d._dispatchEvent("tokenizerUpdate",a)})}this.bgTokenizer.setDocument(this.getDocument()),this.bgTokenizer.start(0),this._dispatchEvent("changeMode")}},this.$stopWorker=function(){this.$worker&&this.$worker.terminate(),this.$worker=null},this.$startWorker=function(){if(typeof Worker==="undefined"||a.noWorker)this.$worker=null;else try{this.$worker=this.$mode.createWorker(this)}catch(b){console.log("Could not load worker"),console.log(b),this.$worker=null}},this.getMode=function(){return this.$mode},this.$scrollTop=0,this.setScrollTopRow=function(a){this.$scrollTop!==a&&(this.$scrollTop=a,this._dispatchEvent("changeScrollTop"))},this.getScrollTopRow=function(){return this.$scrollTop},this.getWidth=function(){this.$computeWidth();return this.width},this.getScreenWidth=function(){this.$computeWidth();return this.screenWidth},this.$computeWidth=function(a){if(this.$modified||a){this.$modified=!1;var b=this.doc.getAllLines(),c=0,d=0;for(var e=0;e<b.length;e++){var f=this.getFoldLine(e),g,h;g=b[e];if(f){var i=f.range.end;g=this.getFoldDisplayLine(f),e=i.row}h=g.length,c=Math.max(c,h),this.$useWrapMode||(d=Math.max(d,this.$getStringScreenWidth(g)[0]))}this.width=c,this.$useWrapMode?this.screenWidth=this.$wrapLimit:this.screenWidth=d}},this.getLine=function(a){return this.doc.getLine(a)},this.getLines=function(a,b){return this.doc.getLines(a,b)},this.getLength=function(){return this.doc.getLength()},this.getTextRange=function(a){return this.doc.getTextRange(a)},this.findMatchingBracket=function(a){if(a.column==0)return null;var b=this.getLine(a.row).charAt(a.column-1);if(b=="")return null;var c=b.match(/([\(\[\{])|([\)\]\}])/);if(!c)return null;return c[1]?this.$findClosingBracket(c[1],a):this.$findOpeningBracket(c[2],a)},this.$brackets={")":"(","(":")","]":"[","[":"]","{":"}","}":"{"},this.$findOpeningBracket=function(a,b){var c=this.$brackets[a],d=b.column-2,e=b.row,f=1,g=this.getLine(e);while(!0){while(d>=0){var h=g.charAt(d);if(h==c){f-=1;if(f==0)return{row:e,column:d}}else h==a&&(f+=1);d-=1}e-=1;if(e<0)break;var g=this.getLine(e),d=g.length-1}return null},this.$findClosingBracket=function(a,b){var c=this.$brackets[a],d=b.column,e=b.row,f=1,g=this.getLine(e),h=this.getLength();while(!0){while(d<g.length){var i=g.charAt(d);if(i==c){f-=1;if(f==0)return{row:e,column:d}}else i==a&&(f+=1);d+=1}e+=1;if(e>=h)break;var g=this.getLine(e),d=0}return null},this.insert=function(a,b){return this.doc.insert(a,b)},this.remove=function(a){return this.doc.remove(a)},this.undoChanges=function(a,b){if(a.length){this.$fromUndo=!0;var c=null;for(var d=a.length-1;d!=-1;d--)delta=a[d],delta.group=="doc"?(this.doc.revertDeltas(delta.deltas),c=this.$getUndoSelection(delta.deltas,!0,c)):delta.deltas.forEach(function(a){this.addFolds(a.folds)},this);this.$fromUndo=!1,c&&!b&&this.selection.setSelectionRange(c);return c}},this.redoChanges=function(a,b){if(a.length){this.$fromUndo=!0;var c=null;for(var d=0;d<a.length;d++)delta=a[d],delta.group=="doc"&&(this.doc.applyDeltas(delta.deltas),c=this.$getUndoSelection(delta.deltas,!1,c));this.$fromUndo=!1,c&&!b&&this.selection.setSelectionRange(c);return c}},this.$getUndoSelection=function(a,b,c){function d(a){var c=a.action=="insertText"||a.action=="insertLines";return b?!c:c}var e=a[0],f,g,h=!1;d(e)?(f=e.range.clone(),h=!0):(f=j.fromPoints(e.range.start,e.range.start),h=!1);for(var i=1;i<a.length;i++)e=a[i],d(e)?(g=e.range.start,f.compare(g.row,g.column)==-1&&f.setStart(e.range.start),g=e.range.end,f.compare(g.row,g.column)==1&&f.setEnd(e.range.end),h=!0):(g=e.range.start,f.compare(g.row,g.column)==-1&&(f=j.fromPoints(e.range.start,e.range.start)),h=!1);if(c!=null){var k=c.compareRange(f);k==1?f.setStart(c.start):k==-1&&f.setEnd(c.end)}return f},this.replace=function(a,b){return this.doc.replace(a,b)},this.moveText=function(a,b){var c=this.getTextRange(a);this.remove(a);var d=b.row,e=b.column;!a.isMultiLine()&&a.start.row==d&&a.end.column<e&&(e-=c.length);if(a.isMultiLine()&&a.end.row<d){var f=this.doc.$split(c);d-=f.length-1}var g=d+a.end.row-a.start.row,h=a.isMultiLine()?a.end.column:e+a.end.column-a.start.column,i=new j(d,e,g,h);this.insert(i.start,c);return i},this.indentRows=function(a,b,c){c=c.replace(/\t/g,this.getTabString());for(var d=a;d<=b;d++)this.insert({row:d,column:0},c)},this.outdentRows=function(a){var b=a.collapseRows(),c=new j(0,0,0,0),d=this.getTabSize();for(var e=b.start.row;e<=b.end.row;++e){var f=this.getLine(e);c.start.row=e,c.end.row=e;for(var g=0;g<d;++g)if(f.charAt(g)!=" ")break;g<d&&f.charAt(g)=="\t"?(c.start.column=g,c.end.column=g+1):(c.start.column=0,c.end.column=g),this.remove(c)}},this.moveLinesUp=function(a,b){if(a<=0)return 0;var c=this.doc.removeLines(a,b);this.doc.insertLines(a-1,c);return-1},this.moveLinesDown=function(a,b){if(b>=this.doc.getLength()-1)return 0;var c=this.doc.removeLines(a,b);this.doc.insertLines(a+1,c);return 1},this.duplicateLines=function(a,b){var a=this.$clipRowToDocument(a),b=this.$clipRowToDocument(b),c=this.getLines(a,b);this.doc.insertLines(a,c);var d=b-a+1;return d},this.$clipRowToDocument=function(a){return Math.max(0,Math.min(a,this.doc.getLength()-1))},this.$wrapLimit=80,this.$useWrapMode=!1,this.$wrapLimitRange={min:null,max:null},this.setUseWrapMode=function(a){if(a!=this.$useWrapMode){this.$useWrapMode=a,this.$modified=!0,this.$resetRowCache(0);if(a){var b=this.getLength();this.$wrapData=[];for(i=0;i<b;i++)this.$wrapData.push([]);this.$updateWrapData(0,b-1)}this._dispatchEvent("changeWrapMode")}},this.getUseWrapMode=function(){return this.$useWrapMode},this.setWrapLimitRange=function(a,b){if(this.$wrapLimitRange.min!==a||this.$wrapLimitRange.max!==b)this.$wrapLimitRange.min=a,this.$wrapLimitRange.max=b,this.$modified=!0,this._dispatchEvent("changeWrapMode")},this.adjustWrapLimit=function(a){var b=this.$constrainWrapLimit(a);if(b!=this.$wrapLimit&&b>0){this.$wrapLimit=b,this.$modified=!0,this.$useWrapMode&&(this.$updateWrapData(0,this.getLength()-1),this.$resetRowCache(0),this._dispatchEvent("changeWrapLimit"));return!0}return!1},this.$constrainWrapLimit=function(a){var b=this.$wrapLimitRange.min;b&&(a=Math.max(b,a));var c=this.$wrapLimitRange.max;c&&(a=Math.min(c,a));return Math.max(1,a)},this.getWrapLimit=function(){return this.$wrapLimit},this.getWrapLimitRange=function(){return{min:this.$wrapLimitRange.min,max:this.$wrapLimitRange.max}},this.$updateInternalDataOnChange=function(a){var b=this.$useWrapMode,c,d=a.data.action,e=a.data.range.start.row,f=a.data.range.end.row,g=a.data.range.start,h=a.data.range.end,i=null;d.indexOf("Lines")!=-1?(d=="insertLines"?f=e+a.data.lines.length:f=e,c=a.data.lines.length):c=f-e;if(c!=0)if(d.indexOf("remove")!=-1){b&&this.$wrapData.splice(e,c);var j=this.$foldData;i=this.getFoldsInRange(a.data.range),this.removeFolds(i);var k=this.getFoldLine(h.row),l=0;if(k){k.addRemoveChars(h.row,h.column,g.column-h.column),k.shiftRow(-c);var m=this.getFoldLine(e);m&&m!==k&&(m.merge(k),k=m),l=j.indexOf(k)+1}for(l;l<j.length;l++){var k=j[l];k.start.row>=h.row&&k.shiftRow(-c)}f=e}else{var n;if(b){n=[e,0];for(var o=0;o<c;o++)n.push([]);this.$wrapData.splice.apply(this.$wrapData,n)}var j=this.$foldData,k=this.getFoldLine(e),l=0;if(k){var p=k.range.compareInside(g.row,g.column);p==0?(k=k.split(g.row,g.column),k.shiftRow(c),k.addRemoveChars(f,0,h.column-g.column)):p==-1&&(k.addRemoveChars(e,0,h.column-g.column),k.shiftRow(c)),l=j.indexOf(k)+1}for(l;l<j.length;l++){var k=j[l];k.start.row>=e&&k.shiftRow(c)}}else{var q;c=Math.abs(a.data.range.start.column-a.data.range.end.column),d.indexOf("remove")!=-1&&(i=this.getFoldsInRange(a.data.range),this.removeFolds(i),c=-c);var k=this.getFoldLine(e);k&&k.addRemoveChars(e,g.column,c)}b&&this.$wrapData.length!=this.doc.getLength()&&console.error("doc.getLength() and $wrapData.length have to be the same!"),b&&this.$updateWrapData(e,f);return i},this.$updateWrapData=function(a,b){var c=this.doc.getAllLines(),d=this.getTabSize(),f=this.$wrapData,i=this.$wrapLimit,j,l,m=a;b=Math.min(b,c.length-1);while(m<=b){l=this.getFoldLine(m);if(l){j=[],l.walk(function(a,b,d,e){var f;if(a){f=this.$getDisplayTokens(a,j.length),f[0]=g;for(var i=1;i<f.length;i++)f[i]=h}else f=this.$getDisplayTokens(c[b].substring(e,d),j.length);j=j.concat(f)}.bind(this),l.end.row,c[l.end.row].length+1);while(j.length!=0&&j[j.length-1]>=k)j.pop()}else j=this.$getDisplayTokens(e.stringTrimRight(c[m]));f[m]=this.$computeWrapSplits(j,i,d),m=this.getRowFoldEnd(m)+1}};var b=1,c=2,g=3,h=4,k=10,m=11,n=12;this.$computeWrapSplits=function(a,b,c){function j(b){var c=a.slice(f,b),e=c.length;c.join("").replace(/12/g,function(a){e-=1}).replace(/2/g,function(a){e-=1}),i+=e,d.push(i),f=b}if(a.length==0)return[];var c=this.getTabSize(),d=[],e=a.length,f=0,i=0;while(e-f>b){var l=f+b;if(a[l]>=k){while(a[l]>=k)l++;j(l);continue}if(a[l]==g||a[l]==h){for(l;l!=f-1;l--)if(a[l]==g)break;if(l>f){j(l);continue}l=f+b;for(l;l<a.length;l++)if(a[l]!=h)break;if(l==a.length)break;j(l);continue}for(l;l!=f-1;l--)if(a[l]>=g){l++;break}if(l>f){j(l);continue}l=f+b,j(f+b)}return d},this.$getDisplayTokens=function(a,d){var e=[],f;d=d||0;for(var g=0;g<a.length;g++){var h=a.charCodeAt(g);if(h==9){f=this.getScreenTabSize(e.length+d),e.push(m);for(var i=1;i<f;i++)e.push(n)}else h==32?e.push(k):o(h)?e.push(b,c):e.push(b)}return e},this.$getStringScreenWidth=function(a,b,c){if(b==0)return[0,0];b==null&&(b=c+a.length*Math.max(this.getTabSize(),2)),c=c||0;var d,e;for(e=0;e<a.length;e++){d=a.charCodeAt(e),d==9?c+=this.getScreenTabSize(c):o(d)?c+=2:c+=1;if(c>b)break}return[c,e]},this.getRowLength=function(a){return this.$useWrapMode&&this.$wrapData[a]?this.$wrapData[a].length+1:1},this.getRowHeight=function(a,b){return this.getRowLength(b)*a.lineHeight},this.getScreenLastRowColumn=function(a){return this.screenToDocumentColumn(a,Number.MAX_VALUE/10)},this.getDocumentLastRowColumn=function(a,b){var c=this.documentToScreenRow(a,b);return this.getScreenLastRowColumn(c)},this.getDocumentLastRowColumnPosition=function(a,b){var c=this.documentToScreenRow(a,b);return this.screenToDocumentPosition(c,Number.MAX_VALUE/10)},this.getRowSplitData=function(a){return this.$useWrapMode?this.$wrapData[a]:undefined},this.getScreenTabSize=function(a){return this.$tabSize-a%this.$tabSize},this.screenToDocumentRow=function(a,b){return this.screenToDocumentPosition(a,b).row},this.screenToDocumentColumn=function(a,b){return this.screenToDocumentPosition(a,b).column},this.screenToDocumentPosition=function(a,b){var c,d=0,e=0,f,g,h=0,i=0,j=null,k=this.$rowCache,l=!k.length;for(var m=0;m<k.length;m++)k[m].screenRow<a&&(h=k[m].screenRow,d=k[m].docRow,l=m==k.length-1);var n=d,o=this.getLength()-1,p=this.getNextFold(d),q=p?p.start.row:Infinity;while(h<=a){l&&d-n>this.$rowCacheSize&&(k.push({docRow:d,screenRow:h}),n=d),i=this.getRowLength(d);if(h+i-1<a&&d<o)h+=i,d++,d>q&&(d=p.end.row+1,p=this.getNextFold(d),q=p?p.start.row:Infinity);else break}p&&p.start.row<=d?c=this.getFoldDisplayLine(p):(c=this.getLine(d),p=null),this.$useWrapMode&&(j=this.$wrapData[d],j&&(f=j[a-h],a>h&&j.length&&(e=j[a-h-1]||j[j.length-1],c=c.substring(e)))),e+=this.$getStringScreenWidth(c,b)[1],this.$useWrapMode?e>=f&&(e=f-1):e=Math.min(e,c.length);if(p)return p.idxToPosition(e);return{row:d,column:e}},this.documentToScreenPosition=function(a,b){b==null&&(b=a.column,a=a.row);var c;if(this.$useWrapMode){c=this.$wrapData;if(a>c.length-1)return{row:this.getScreenLength(),column:c.length==0?0:c[c.length-1].length-1}}var d=0,e=0,f=null,g=null;g=this.getFoldAt(a,b,1),g&&(a=g.start.row,b=g.start.column);var h,i=0,j=this.$rowCache,k=!j.length;for(var l=0;l<j.length;l++)j[l].docRow<a&&(d=j[l].screenRow,i=j[l].docRow,k=l==j.length-1);var m=i,n=this.getNextFold(i),o=n?n.start.row:Infinity;while(i<a){if(i<o)h=i+1;else{h=n.end.row+1;if(h>a)break;n=this.getNextFold(h),o=n?n.start.row:Infinity}k&&i-m>this.$rowCacheSize&&(j.push({docRow:i,screenRow:d}),m=i),d+=this.getRowLength(i),i=h}var p="";n&&i>=o?(p=this.getFoldDisplayLine(n,a,b),f=n.start.row):(p=this.getLine(a).substring(0,b),f=a);if(this.$useWrapMode){var q=c[f],r=0;while(p.length>=q[r])d++,r++;p=p.substring(q[r-1]||0,p.length)}return{row:d,column:this.$getStringScreenWidth(p)[0]}},this.documentToScreenColumn=function(a,b){return this.documentToScreenPosition(a,b).column},this.documentToScreenRow=function(a,b){return this.documentToScreenPosition(a,b).row},this.getScreenLength=function(){var a=0,b=null,c=null;if(this.$useWrapMode)for(var f=0;f<this.$wrapData.length;f++)(c=this.getFoldLine(f,b))?(f=c.end.row,a+=1):a+=this.$wrapData[f].length+1;else{a=this.getLength();var d=this.$foldData;for(var e=0;e<d.length;e++)c=d[e],a-=c.end.row-c.start.row}return a}}).call(m.prototype),a("ace/edit_session/folding").Folding.call(m.prototype),b.EditSession=m}),define("ace/selection",["require","exports","module","pilot/oop","pilot/lang","pilot/event_emitter","ace/range"],function(a,b,c){var d=a("pilot/oop"),e=a("pilot/lang"),f=a("pilot/event_emitter").EventEmitter,g=a("ace/range").Range,h=function(a){this.session=a,this.doc=a.getDocument(),this.clearSelection(),this.selectionLead=this.doc.createAnchor(0,0),this.selectionAnchor=this.doc.createAnchor(0,0);var b=this;this.selectionLead.on("change",function(a){b._dispatchEvent("changeCursor"),b.$isEmpty||b._dispatchEvent("changeSelection"),a.old.row==a.value.row&&b.$updateDesiredColumn()}),this.selectionAnchor.on("change",function(){b.$isEmpty||b._dispatchEvent("changeSelection")})};(function(){d.implement(this,f),this.isEmpty=function(){return this.$isEmpty||this.selectionAnchor.row==this.selectionLead.row&&this.selectionAnchor.column==this.selectionLead.column},this.isMultiLine=function(){if(this.isEmpty())return!1;return this.getRange().isMultiLine()},this.getCursor=function(){return this.selectionLead.getPosition()},this.setSelectionAnchor=function(a,b){this.selectionAnchor.setPosition(a,b),this.$isEmpty&&(this.$isEmpty=!1,this._dispatchEvent("changeSelection"))},this.getSelectionAnchor=function(){return this.$isEmpty?this.getSelectionLead():this.selectionAnchor.getPosition()},this.getSelectionLead=function(){return this.selectionLead.getPosition()},this.shiftSelection=function(a){if(this.$isEmpty)this.moveCursorTo(this.selectionLead.row,this.selectionLead.column+a);else{var b=this.getSelectionAnchor(),c=this.getSelectionLead(),d=this.isBackwards();(!d||b.column!==0)&&this.setSelectionAnchor(b.row,b.column+a),(d||c.column!==0)&&this.$moveSelection(function(){this.moveCursorTo(c.row,c.column+a)})}},this.isBackwards=function(){var a=this.selectionAnchor,b=this.selectionLead;return a.row>b.row||a.row==b.row&&a.column>b.column},this.getRange=function(){var a=this.selectionAnchor,b=this.selectionLead;if(this.isEmpty())return g.fromPoints(b,b);return this.isBackwards()?g.fromPoints(b,a):g.fromPoints(a,b)},this.clearSelection=function(){this.$isEmpty||(this.$isEmpty=!0,this._dispatchEvent("changeSelection"))},this.selectAll=function(){var a=this.doc.getLength()-1;this.setSelectionAnchor(a,this.doc.getLine(a).length),this.moveCursorTo(0,0)},this.setSelectionRange=function(a,b){b?(this.setSelectionAnchor(a.end.row,a.end.column),this.selectTo(a.start.row,a.start.column)):(this.setSelectionAnchor(a.start.row,a.start.column),this.selectTo(a.end.row,a.end.column)),this.$updateDesiredColumn()},this.$updateDesiredColumn=function(){var a=this.getCursor();this.$desiredColumn=this.session.documentToScreenColumn(a.row,a.column)},this.$moveSelection=function(a){var b=this.selectionLead;this.$isEmpty&&this.setSelectionAnchor(b.row,b.column),a.call(this)},this.selectTo=function(a,b){this.$moveSelection(function(){this.moveCursorTo(a,b)})},this.selectToPosition=function(a){this.$moveSelection(function(){this.moveCursorToPosition(a)})},this.selectUp=function(){this.$moveSelection(this.moveCursorUp)},this.selectDown=function(){this.$moveSelection(this.moveCursorDown)},this.selectRight=function(){this.$moveSelection(this.moveCursorRight)},this.selectLeft=function(){this.$moveSelection(this.moveCursorLeft)},this.selectLineStart=function(){this.$moveSelection(this.moveCursorLineStart)},this.selectLineEnd=function(){this.$moveSelection(this.moveCursorLineEnd)},this.selectFileEnd=function(){this.$moveSelection(this.moveCursorFileEnd)},this.selectFileStart=function(){this.$moveSelection(this.moveCursorFileStart)},this.selectWordRight=function(){this.$moveSelection(this.moveCursorWordRight)},this.selectWordLeft=function(){this.$moveSelection(this.moveCursorWordLeft)},this.selectWord=function(){var a=this.getCursor(),b=this.session.getWordRange(a.row,a.column);this.setSelectionRange(b)},this.selectLine=function(){var a=this.selectionLead.row,b,c=this.session.getFoldLine(a);c?(a=c.start.row,b=c.end.row):b=a,this.setSelectionAnchor(a,0),this.$moveSelection(function(){this.moveCursorTo(b+1,0)})},this.moveCursorUp=function(){this.moveCursorBy(-1,0)},this.moveCursorDown=function(){this.moveCursorBy(1,0)},this.moveCursorLeft=function(){var a=this.selectionLead.getPosition(),b;if(b=this.session.getFoldAt(a.row,a.column,-1))this.moveCursorTo(b.start.row,b.start.column);else if(a.column==0)a.row>0&&this.moveCursorTo(a.row-1,this.doc.getLine(a.row-1).length);else{var c=this.session.getTabSize();this.session.isTabStop(a)&&this.doc.getLine(a.row).slice(a.column-c,a.column).split(" ").length-1==c?this.moveCursorBy(0,-c):this.moveCursorBy(0,-1)}},this.moveCursorRight=function(){var a=this.selectionLead.getPosition(),b;if(b=this.session.getFoldAt(a.row,a.column,1))this.moveCursorTo(b.end.row,b.end.column);else if(this.selectionLead.column==this.doc.getLine(this.selectionLead.row).length)this.selectionLead.row<this.doc.getLength()-1&&this.moveCursorTo(this.selectionLead.row+1,0);else{var c=this.session.getTabSize(),a=this.selectionLead;this.session.isTabStop(a)&&this.doc.getLine(a.row).slice(a.column,a.column+c).split(" ").length-1==c?this.moveCursorBy(0,c):this.moveCursorBy(0,1)}},this.moveCursorLineStart=function(){var a=this.selectionLead.row,b=this.selectionLead.column,c=this.session.documentToScreenRow(a,b),d=this.session.screenToDocumentPosition(c,0),e=this.session.getDisplayLine(a,b,d.row,d.column),f=e.match(/^\s*/);f[0].length!=0&&f[0].length<b-d.column?this.moveCursorTo(d.row,d.column+f[0].length):this.moveCursorTo(d.row,d.column)},this.moveCursorLineEnd=function(){var a=this.selectionLead,b=this.session.getDocumentLastRowColumnPosition(a.row,a.column);this.moveCursorTo(b.row,b.column)},this.moveCursorFileEnd=function(){var a=this.doc.getLength()-1,b=this.doc.getLine(a).length;this.moveCursorTo(a,b)},this.moveCursorFileStart=function(){this.moveCursorTo(0,0)},this.moveCursorWordRight=function(){var a=this.selectionLead.row,b=this.selectionLead.column,c=this.doc.getLine(a),d=c.substring(b),e;this.session.nonTokenRe.lastIndex=0,this.session.tokenRe.lastIndex=0;var f;if(f=this.session.getFoldAt(a,b,1))this.moveCursorTo(f.end.row,f.end.column);else{if(b==c.length){this.moveCursorRight();return}if(e=this.session.nonTokenRe.exec(d))b+=this.session.nonTokenRe.lastIndex,this.session.nonTokenRe.lastIndex=0;else if(e=this.session.tokenRe.exec(d))b+=this.session.tokenRe.lastIndex,this.session.tokenRe.lastIndex=0;this.moveCursorTo(a,b)}},this.moveCursorWordLeft=function(){var a=this.selectionLead.row,b=this.selectionLead.column,c;if(c=this.session.getFoldAt(a,b,-1))this.moveCursorTo(c.start.row,c.start.column);else{if(b==0){this.moveCursorLeft();return}var d=this.session.getFoldStringAt(a,b,-1);d==null&&(d=this.doc.getLine(a).substring(0,b));var f=e.stringReverse(d),g;this.session.nonTokenRe.lastIndex=0,this.session.tokenRe.lastIndex=0;if(g=this.session.nonTokenRe.exec(f))b-=this.session.nonTokenRe.lastIndex,this.session.nonTokenRe.lastIndex=0;else if(g=this.session.tokenRe.exec(f))b-=this.session.tokenRe.lastIndex,this.session.tokenRe.lastIndex=0;this.moveCursorTo(a,b)}},this.moveCursorBy=function(a,b){var c=this.session.documentToScreenPosition(this.selectionLead.row,this.selectionLead.column),d=b==0&&this.$desiredColumn||c.column,e=this.session.screenToDocumentPosition(c.row+a,d);this.moveCursorTo(e.row,e.column+b,b==0)},this.moveCursorToPosition=function(a){this.moveCursorTo(a.row,a.column)},this.moveCursorTo=function(a,b,c){var d=this.session.getFoldAt(a,b,1);d&&(a=d.start.row,b=d.start.column),this.selectionLead.setPosition(a,b),c||this.$updateDesiredColumn(this.selectionLead.column)},this.moveCursorToScreen=function(a,b,c){var d=this.session.screenToDocumentPosition(a,b);a=d.row,b=d.column,this.moveCursorTo(a,b,c)}}).call(h.prototype),b.Selection=h}),define("ace/range",["require","exports","module"],function(a,b,c){var d=function(a,b,c,d){this.start={row:a,column:b},this.end={row:c,column:d}};(function(){this.toString=function(){return"Range: ["+this.start.row+"/"+this.start.column+"] -> ["+this.end.row+"/"+this.end.column+"]"},this.contains=function(a,b){return this.compare(a,b)==0},this.compareRange=function(a){var b,c=a.end,d=a.start;b=this.compare(c.row,c.column);if(b==1){b=this.compare(d.row,d.column);return b==1?2:b==0?1:0}if(b==-1)return-2;b=this.compare(d.row,d.column);return b==-1?-1:b==1?42:0},this.containsRange=function(a){var b=this.compareRange(a);return b==-1||b==0||b==1},this.isEnd=function(a,b){return this.end.row==a&&this.end.column==b},this.isStart=function(a,b){return this.start.row==a&&this.start.column==b},this.setStart=function(a,b){typeof a=="object"?(this.start.column=a.column,this.start.row=a.row):(this.start.row=a,this.start.column=b)},this.setEnd=function(a,b){typeof a=="object"?(this.end.column=a.column,this.end.row=a.row):(this.end.row=a,this.end.column=b)},this.inside=function(a,b){if(this.compare(a,b)==0)return this.isEnd(a,b)||this.isStart(a,b)?!1:!0;return!1},this.insideStart=function(a,b){if(this.compare(a,b)==0)return this.isEnd(a,b)?!1:!0;return!1},this.insideEnd=function(a,b){if(this.compare(a,b)==0)return this.isStart(a,b)?!1:!0;return!1},this.compare=function(a,b){if(!this.isMultiLine())if(a===this.start.row)return b<this.start.column?-1:b>this.end.column?1:0;if(a<this.start.row)return-1;if(a>this.end.row)return 1;if(this.start.row===a)return b>=this.start.column?0:-1;if(this.end.row===a)return b<=this.end.column?0:1;return 0},this.compareStart=function(a,b){return this.start.row==a&&this.start.column==b?-1:this.compare(a,b)},this.compareEnd=function(a,b){return this.end.row==a&&this.end.column==b?1:this.compare(a,b)},this.compareInside=function(a,b){return this.end.row==a&&this.end.column==b?1:this.start.row==a&&this.start.column==b?-1:this.compare(a,b)},this.clipRows=function(a,b){if(this.end.row>b)var c={row:b+1,column:0};if(this.start.row>b)var e={row:b+1,column:0};if(this.start.row<a)var e={row:a,column:0};if(this.end.row<a)var c={row:a,column:0};return d.fromPoints(e||this.start,c||this.end)},this.extend=function(a,b){var c=this.compare(a,b);if(c==0)return this;if(c==-1)var e={row:a,column:b};else var f={row:a,column:b};return d.fromPoints(e||this.start,f||this.end)},this.isEmpty=function(){return this.start.row==this.end.row&&this.start.column==this.end.column},this.isMultiLine=function(){return this.start.row!==this.end.row},this.clone=function(){return d.fromPoints(this.start,this.end)},this.collapseRows=function(){return this.end.column==0?new d(this.start.row,0,Math.max(this.start.row,this.end.row-1),0):new d(this.start.row,0,this.end.row,0)},this.toScreenRange=function(a){var b=a.documentToScreenPosition(this.start),c=a.documentToScreenPosition(this.end);return new d(b.row,b.column,c.row,c.column)}}).call(d.prototype),d.fromPoints=function(a,b){return new d(a.row,a.column,b.row,b.column)},b.Range=d}),define("ace/mode/text",["require","exports","module","ace/tokenizer","ace/mode/text_highlight_rules","ace/mode/behaviour"],function(a,b,c){var d=a("ace/tokenizer").Tokenizer,e=a("ace/mode/text_highlight_rules").TextHighlightRules,f=a("ace/mode/behaviour").Behaviour,g=function(){this.$tokenizer=new d((new e).getRules()),this.$behaviour=new f};(function(){this.getTokenizer=function(){return this.$tokenizer},this.toggleCommentLines=function(a,b,c,d){},this.getNextLineIndent=function(a,b,c){return""},this.checkOutdent=function(a,b,c){return!1},this.autoOutdent=function(a,b,c){},this.$getIndent=function(a){var b=a.match(/^(\s+)/);if(b)return b[1];return""},this.createWorker=function(a){return null},this.highlightSelection=function(a){var b=a.session;b.$selectionOccurrences||(b.$selectionOccurrences=[]),b.$selectionOccurrences.length&&this.clearSelectionHighlight(a);var c=a.getSelectionRange();if(!c.isEmpty()&&!c.isMultiLine()){var d=c.start.column-1,e=c.end.column+1,f=b.getLine(c.start.row),g=f.length,h=f.substring(Math.max(d,0),Math.min(e,g));if(d>=0&&/^[\w\d]/.test(h)||e<=g&&/[\w\d]$/.test(h))return;h=f.substring(c.start.column,c.end.column);if(!/^[\w\d]+$/.test(h))return;var i=a.getCursorPosition(),j={wrap:!0,wholeWord:!0,caseSensitive:!0,needle:h},k=a.$search.getOptions();a.$search.set(j);var l=a.$search.findAll(b);l.forEach(function(a){if(!a.contains(i.row,i.column)){var c=b.addMarker(a,"ace_selected_word");b.$selectionOccurrences.push(c)}}),a.$search.set(k)}},this.clearSelectionHighlight=function(a){a.session.$selectionOccurrences&&(a.session.$selectionOccurrences.forEach(function(b){a.session.removeMarker(b)}),a.session.$selectionOccurrences=[])},this.createModeDelegates=function(a){if(this.$embeds){this.$modes={};for(var b=0;b<this.$embeds.length;b++)a[this.$embeds[b]]&&(this.$modes[this.$embeds[b]]=new a[this.$embeds[b]]);var c=["toggleCommentLines","getNextLineIndent","checkOutdent","autoOutdent","transformAction"];for(var b=0;b<c.length;b++)(function(a){var d=c[b],e=a[d];a[c[b]]=function(){return this.$delegator(d,arguments,e)}})(this)}},this.$delegator=function(a,b,c){var d=b[0];for(var e=0;e<this.$embeds.length;e++){if(!this.$modes[this.$embeds[e]])continue;var f=d.split(this.$embeds[e]);if(!f[0]&&f[1]){b[0]=f[1];var g=this.$modes[this.$embeds[e]];return g[a].apply(g,b)}}var h=c.apply(this,b);return c?h:undefined},this.transformAction=function(a,b,c,d,e){if(this.$behaviour){var f=this.$behaviour.getBehaviours();for(var g in f)if(f[g][b]){var h=f[g][b].apply(this,arguments);if(h!==!1)return h}}return!1}}).call(g.prototype),b.Mode=g}),define("ace/tokenizer",["require","exports","module"],function(a,b,c){var d=function(a){this.rules=a,this.regExps={},this.matchMappings={};for(var b in this.rules){var c=this.rules[b],d=c,e=[],f=0,g=this.matchMappings[b]={};for(var h=0;h<d.length;h++){var i=(new RegExp("(?:("+d[h].regex+")|(.))")).exec("a").length-2,j=d[h].regex.replace(/\\([0-9]+)/g,function(a,b){return"\\"+(parseInt(b,10)+f+1)});g[f]={rule:h,len:i},f+=i,e.push(j)}this.regExps[b]=new RegExp("(?:("+e.join(")|(")+")|(.))","g")}};(function(){this.getLineTokens=function(a,b){var c=b,d=this.rules[c],e=this.matchMappings[c],f=this.regExps[c];f.lastIndex=0;var g,h=[],i=0,j={type:null,value:""};while(g=f.exec(a)){var k="text",l=[g[0]];for(var m=0;m<g.length-2;m++)if(g[m+1]!==undefined){var n=d[e[m].rule];e[m].len>1&&(l=g.slice(m+2,m+1+e[m].len)),typeof n.token=="function"?k=n.token.apply(this,l):k=n.token,n.next&&n.next!==c&&(c=n.next,d=this.rules[c],e=this.matchMappings[c],i=f.lastIndex,f=this.regExps[c],f.lastIndex=i);break}typeof k=="string"&&(typeof l!="string"&&(l=[l.join("")]),k=[k]);for(var m=0;m<l.length;m++)j.type!==k[m]?(j.type&&h.push(j),j={type:k[m],value:l[m]}):j.value+=l[m];if(i==a.length)break;i=f.lastIndex}j.type&&h.push(j);return{tokens:h,state:c}}}).call(d.prototype),b.Tokenizer=d}),define("ace/mode/text_highlight_rules",["require","exports","module","pilot/lang"],function(a,b,c){var d=a("pilot/lang"),e=function(){this.$rules={start:[{token:"empty_line",regex:"^$"},{token:"text",regex:".+"}]}};(function(){this.addRules=function(a,b){for(var c in a){var d=a[c];for(var e=0;e<d.length;e++){var f=d[e];f.next?f.next=b+f.next:f.next=b+c}this.$rules[b+c]=d}},this.getRules=function(){return this.$rules},this.embedRules=function(a,b,c,e){var f=(new a).getRules();if(e)for(var g=0;g<e.length;g++)e[g]=b+e[g];else{e=[];for(var h in f)e.push(b+h)}this.addRules(f,b);for(var g=0;g<e.length;g++)Array.prototype.unshift.apply(this.$rules[e[g]],d.deepCopy(c));this.$embeds||(this.$embeds=[]),this.$embeds.push(b)},this.getEmbeds=function(){return this.$embeds}}).call(e.prototype),b.TextHighlightRules=e}),define("ace/mode/behaviour",["require","exports","module"],function(a,b,c){var d=function(){this.$behaviours={}};(function(){this.add=function(a,b,c){switch(undefined){case this.$behaviours:this.$behaviours={};case this.$behaviours[a]:this.$behaviours[a]={}}this.$behaviours[a][b]=c},this.addBehaviours=function(a){for(var b in a)for(var c in a[b])this.add(b,c,a[b][c])},this.remove=function(a){this.$behaviours&&this.$behaviours[a]&&delete this.$behaviours[a]},this.inherit=function(a,b){if(typeof a==="function")var c=(new a).getBehaviours(b);else var c=a.getBehaviours(b);this.addBehaviours(c)},this.getBehaviours=function(a){if(a){var b={};for(var c=0;c<a.length;c++)this.$behaviours[a[c]]&&(b[a[c]]=this.$behaviours[a[c]]);return b}return this.$behaviours}}).call(d.prototype),b.Behaviour=d}),define("ace/document",["require","exports","module","pilot/oop","pilot/event_emitter","ace/range","ace/anchor"],function(a,b,c){var d=a("pilot/oop"),e=a("pilot/event_emitter").EventEmitter,f=a("ace/range").Range,g=a("ace/anchor").Anchor,h=function(a){this.$lines=[],Array.isArray(a)?this.insertLines(0,a):a.length==0?this.$lines=[""]:this.insert({row:0,column:0},a)};(function(){d.implement(this,e),this.setValue=function(a){var b=this.getLength();this.remove(new f(0,0,b,this.getLine(b-1).length)),this.insert({row:0,column:0},a)},this.getValue=function(){return this.getAllLines().join(this.getNewLineCharacter())},this.createAnchor=function(a,b){return new g(this,a,b)},"aaa".split(/a/).length==0?this.$split=function(a){return a.replace(/\r\n|\r/g,"\n").split("\n")}:this.$split=function(a){return a.split(/\r\n|\r|\n/)},this.$detectNewLine=function(a){var b=a.match(/^.*?(\r?\n)/m);b?this.$autoNewLine=b[1]:this.$autoNewLine="\n"},this.getNewLineCharacter=function(){switch(this.$newLineMode){case"windows":return"\r\n";case"unix":return"\n";case"auto":return this.$autoNewLine}},this.$autoNewLine="\n",this.$newLineMode="auto",this.setNewLineMode=function(a){this.$newLineMode!==a&&(this.$newLineMode=a)},this.getNewLineMode=function(){return this.$newLineMode},this.isNewLine=function(a){return a=="\r\n"||a=="\r"||a=="\n"},this.getLine=function(a){return this.$lines[a]||""},this.getLines=function(a,b){return this.$lines.slice(a,b+1)},this.getAllLines=function(){return this.getLines(0,this.getLength())},this.getLength=function(){return this.$lines.length},this.getTextRange=function(a){if(a.start.row==a.end.row)return this.$lines[a.start.row].substring(a.start.column,a.end.column);var b=[];b.push(this.$lines[a.start.row].substring(a.start.column)),b.push.apply(b,this.getLines(a.start.row+1,a.end.row-1)),b.push(this.$lines[a.end.row].substring(0,a.end.column));return b.join(this.getNewLineCharacter())},this.$clipPosition=function(a){var b=this.getLength();a.row>=b&&(a.row=Math.max(0,b-1),a.column=this.getLine(b-1).length);return a},this.insert=function(a,b){if(b.length==0)return a;a=this.$clipPosition(a),this.getLength()<=1&&this.$detectNewLine(b);var c=this.$split(b),d=c.splice(0,1)[0],e=c.length==0?null:c.splice(c.length-1,1)[0];this._dispatchEvent("changeStart"),a=this.insertInLine(a,d),e!==null&&(a=this.insertNewLine(a),a=this.insertLines(a.row,c),a=this.insertInLine(a,e||"")),this._dispatchEvent("changeEnd");return a},this.insertLines=function(a,b){if(b.length==0)return{row:a,column:0};var c=[a,0];c.push.apply(c,b),this.$lines.splice.apply(this.$lines,c),this._dispatchEvent("changeStart");var d=new f(a,0,a+b.length,0),e={action:"insertLines",range:d,lines:b};this._dispatchEvent("change",{data:e}),this._dispatchEvent("changeEnd");return d.end},this.insertNewLine=function(a){a=this.$clipPosition(a);var b=this.$lines[a.row]||"";this._dispatchEvent("changeStart"),this.$lines[a.row]=b.substring(0,a.column),this.$lines.splice(a.row+1,0,b.substring(a.column,b.length));var c={row:a.row+1,column:0},d={action:"insertText",range:f.fromPoints(a,c),text:this.getNewLineCharacter()};this._dispatchEvent("change",{data:d}),this._dispatchEvent("changeEnd");return c},this.insertInLine=function(a,b){if(b.length==0)return a;var c=this.$lines[a.row]||"";this._dispatchEvent("changeStart"),this.$lines[a.row]=c.substring(0,a.column)+b+c.substring(a.column);var d={row:a.row,column:a.column+b.length},e={action:"insertText",range:f.fromPoints(a,d),text:b};this._dispatchEvent("change",{data:e}),this._dispatchEvent("changeEnd");return d},this.remove=function(a){a.start=this.$clipPosition(a.start),a.end=this.$clipPosition(a.end);if(a.isEmpty())return a.start;var b=a.start.row,c=a.end.row;this._dispatchEvent("changeStart");if(a.isMultiLine()){var d=a.start.column==0?b:b+1,e=c-1;a.end.column>0&&this.removeInLine(c,0,a.end.column),e>=d&&this.removeLines(d,e),d!=b&&(this.removeInLine(b,a.start.column,this.getLine(b).length),this.removeNewLine(a.start.row))}else this.removeInLine(b,a.start.column,a.end.column);this._dispatchEvent("changeEnd");return a.start},this.removeInLine=function(a,b,c){if(b!=c){var d=new f(a,b,a,c),e=this.getLine(a),g=e.substring(b,c),h=e.substring(0,b)+e.substring(c,e.length);this._dispatchEvent("changeStart"),this.$lines.splice(a,1,h);var i={action:"removeText",range:d,text:g};this._dispatchEvent("change",{data:i}),this._dispatchEvent("changeEnd");return d.start}},this.removeLines=function(a,b){this._dispatchEvent("changeStart");var c=new f(a,0,b+1,0),d=this.$lines.splice(a,b-a+1),e={action:"removeLines",range:c,nl:this.getNewLineCharacter(),lines:d};this._dispatchEvent("change",{data:e}),this._dispatchEvent("changeEnd");return d},this.removeNewLine=function(a){var b=this.getLine(a),c=this.getLine(a+1),d=new f(a,b.length,a+1,0),e=b+c;this._dispatchEvent("changeStart"),this.$lines.splice(a,2,e);var g={action:"removeText",range:d,text:this.getNewLineCharacter()};this._dispatchEvent("change",{data:g}),this._dispatchEvent("changeEnd")},this.replace=function(a,b){if(b.length==0&&a.isEmpty())return a.start;if(b==this.getTextRange(a))return a.end;this._dispatchEvent("changeStart"),this.remove(a);if(b)var c=this.insert(a.start,b);else c=a.start;this._dispatchEvent("changeEnd");return c},this.applyDeltas=function(a){for(var b=0;b<a.length;b++){var c=a[b],d=f.fromPoints(c.range.start,c.range.end);c.action=="insertLines"?this.insertLines(d.start.row,c.lines):c.action=="insertText"?this.insert(d.start,c.text):c.action=="removeLines"?this.removeLines(d.start.row,d.end.row-1):c.action=="removeText"&&this.remove(d)}},this.revertDeltas=function(a){for(var b=a.length-1;b>=0;b--){var c=a[b],d=f.fromPoints(c.range.start,c.range.end);c.action=="insertLines"?this.removeLines(d.start.row,d.end.row-1):c.action=="insertText"?this.remove(d):c.action=="removeLines"?this.insertLines(d.start.row,c.lines):c.action=="removeText"&&this.insert(d.start,c.text)}}}).call(h.prototype),b.Document=h}),define("ace/anchor",["require","exports","module","pilot/oop","pilot/event_emitter"],function(a,b,c){var d=a("pilot/oop"),e=a("pilot/event_emitter").EventEmitter,f=b.Anchor=function(a,b,c){this.document=a,typeof c=="undefined"?this.setPosition(b.row,b.column):this.setPosition(b,c),this.$onChange=this.onChange.bind(this),a.on("change",this.$onChange)};(function(){d.implement(this,e),this.getPosition=function(){return this.$clipPositionToDocument(this.row,this.column)},this.getDocument=function(){return this.document},this.onChange=function(a){var b=a.data,c=b.range;if(c.start.row!=c.end.row||c.start.row==this.row){if(c.start.row>this.row)return;if(c.start.row==this.row&&c.start.column>this.column)return;var d=this.row,e=this.column;b.action==="insertText"?c.start.row!==d||c.start.column>e?c.start.row!==c.end.row&&c.start.row<d&&(d+=c.end.row-c.start.row):c.start.row===c.end.row?e+=c.end.column-c.start.column:(e-=c.start.column,d+=c.end.row-c.start.row):b.action==="insertLines"?c.start.row<=d&&(d+=c.end.row-c.start.row):b.action=="removeText"?c.start.row==d&&c.start.column<e?c.end.column<e?e=Math.max(0,e-(c.end.column-c.start.column)):e=c.start.column:c.start.row!==c.end.row&&c.start.row<d?(c.end.row==d&&(e=Math.max(0,e-c.end.column)+c.start.column),d-=c.end.row-c.start.row):c.end.row==d&&(d-=c.end.row-c.start.row,e=Math.max(0,e-c.end.column)+c.start.column):b.action=="removeLines"&&(c.start.row<=d&&(c.end.row>d?(d=c.start.row,e=0):d-=c.end.row-c.start.row)),this.setPosition(d,e,!0)}},this.setPosition=function(a,b,c){c?pos={row:a,column:b}:pos=this.$clipPositionToDocument(a,b);if(this.row!=pos.row||this.column!=pos.column){var d={row:this.row,column:this.column};this.row=pos.row,this.column=pos.column,this._dispatchEvent("change",{old:d,value:pos})}},this.detach=function(){this.document.removeEventListener("change",this.$onChange)},this.$clipPositionToDocument=function(a,b){var c={};a<this.document.getLength()?a<0?(c.row=0,c.column=0):(c.row=a,c.column=Math.min(this.document.getLine(c.row).length,Math.max(0,b))):(c.row=Math.max(0,this.document.getLength()-1),c.column=this.document.getLine(c.row).length),b<0&&(c.column=0);return c}}).call(f.prototype)}),define("ace/background_tokenizer",["require","exports","module","pilot/oop","pilot/event_emitter"],function(a,b,c){var d=a("pilot/oop"),e=a("pilot/event_emitter").EventEmitter,f=function(a,b){this.running=!1,this.lines=[],this.currentLine=0,this.tokenizer=a;var c=this;this.$worker=function(){if(c.running){var a=new Date,b=c.currentLine,d=c.doc,e=0,f=d.getLength();while(c.currentLine<f){c.lines[c.currentLine]=c.$tokenizeRows(c.currentLine,c.currentLine)[0],c.currentLine++,e+=1;if(e%5==0&&new Date-a>20){c.fireUpdateEvent(b,c.currentLine-1),c.running=setNativeTimeout(c.$worker,20);return}}c.running=!1,c.fireUpdateEvent(b,f-1)}}};(function(){d.implement(this,e),this.setTokenizer=function(a){this.tokenizer=a,this.lines=[],this.start(0)},this.setDocument=function(a){this.doc=a,this.lines=[],this.stop()},this.fireUpdateEvent=function(a,b){var c={first:a,last:b};this._dispatchEvent("update",{data:c})},this.start=function(a){this.currentLine=Math.min(a||0,this.currentLine,this.doc.getLength()),this.lines.splice(this.currentLine,this.lines.length),this.stop(),this.running=setNativeTimeout(this.$worker,700)},this.stop=function(){this.running&&clearTimeout(this.running),this.running=!1},this.getTokens=function(a,b){return this.$tokenizeRows(a,b)},this.getState=function(a){return this.$tokenizeRows(a,a)[0].state},this.$tokenizeRows=function(a,b){if(!this.doc)return[];var c=[],d="start",e=!1;a>0&&this.lines[a-1]?(d=this.lines[a-1].state,e=!0):a==0?(d="start",e=!0):this.lines.length>0&&(d=this.lines[this.lines.length-1].state);var f=this.doc.getLines(a,b);for(var g=a;g<=b;g++)if(this.lines[g]){var h=this.lines[g];d=h.state,c.push(h)}else{var h=this.tokenizer.getLineTokens(f[g-a]||"",d),d=h.state;c.push(h),e&&(this.lines[g]=h)}return c}}).call(f.prototype),b.BackgroundTokenizer=f}),define("ace/edit_session/folding",["require","exports","module","ace/range","ace/edit_session/fold_line"],function(a,b,c){function g(){this.getFoldAt=function(a,b,c){var d=this.getFoldLine(a);if(!d)return null;var e=d.folds,f;for(var g=0;g<e.length;g++){f=e[g];if(f.range.contains(a,b)){if(c==1&&f.range.isEnd(a,b))continue;if(c==-1&&f.range.isStart(a,b))continue;return f}}},this.getFoldsInRange=function(a){a=a.clone();var b=a.start,c=a.end,d=this.$foldData,e,f,g,h=[];b.column+=1,c.column-=1;for(var i=0;i<d.length;i++){g=d[i].range.compareRange(a);if(g==2)continue;if(g==-2)break;e=d[i].folds;for(var j=0;j<e.length;j++){f=e[j],g=f.range.compareRange(a);if(g==-2)break;if(g==2)continue;if(g==42)break;h.push(f)}}return h},this.getFoldStringAt=function(a,b,c,d){var d=d||this.getFoldLine(a);if(d){var e,f,g,h;f={end:{column:0}};for(var i=0;i<d.folds.length;i++){e=d.folds[i],g=e.range.compareEnd(a,b);if(g==-1){h=this.getLine(e.start.row).substring(f.end.column,e.start.column);break}if(g==0)return null;f=e}h||(h=this.getLine(e.start.row).substring(f.end.column));return c==-1?h.substring(0,b-f.end.column):c==1?h.substring(b-f.end.column):h}return null},this.getFoldLine=function(a,b){var c=this.$foldData,d=0;b&&(d=c.indexOf(b)),d==-1&&(d=0);for(d;d<c.length;d++){var e=c[d];if(e.start.row<=a&&e.end.row>=a)return e;if(e.end.row>a)return null}return null},this.getNextFold=function(a,b){var c=this.$foldData,d,e=0;b&&(e=c.indexOf(b)),e==-1&&(e=0);for(e;e<c.length;e++){var f=c[e];if(f.end.row>=a)return f}return null},this.getFoldedRowCount=function(a,b){var c=this.$foldData,d=b-a+1;for(var e=0;e<c.length;e++){var f=c[e],g=f.end.row,h=f.start.row;if(g<b)g>=a&&(h<a?d-=g-a+1:d-=g-h);else{h<b&&(h<a?d=0:d-=b-h);break}}return d},this.$addFoldLine=function(a){this.$foldData.push(a),this.$foldData.sort(function(a,b){return a.start.row-b.start.row});return a},this.addFold=function(a,b,c,g,h){var i,j=this.$foldData,k=null,l,m,n,o,p=!1;a instanceof f&&(n=a,b=n.range,a=n.placeholder),b instanceof d?(i=b,b=i.start.row,c=i.start.column,g=i.end.row,h=i.end.column):i=new d(b,c,g,h);if(a.length<2)throw"Placeholder has to be at least 2 characters";if(b==g&&h-c<2)throw"The range has to be at least 2 characters width";m=this.getFoldAt(b,c,1);if(m&&m.range.isEnd(g,h)&&m.range.isStart(b,c))return m;m=this.getFoldAt(b,c,1);if(m&&!m.range.isStart(b,c))throw"A fold can't start inside of an already existing fold";m=this.getFoldAt(g,h,-1);if(m&&!m.range.isEnd(g,h))throw"A fold can't end inside of an already existing fold";if(g>=this.doc.getLength())throw"End of fold is outside of the document.";if(h>this.getLine(g).length||c>this.getLine(b).length)throw"End of fold is outside of the document.";m=n||new f(i,a),o=this.getFoldsInRange(i),o.length>0&&(this.removeFolds(o),m.subFolds=o);for(var q=0;q<j.length;q++){l=j[q];if(g==l.start.row){l.addFold(m),p=!0;break}if(b==l.end.row){l.addFold(m),p=!0;if(!m.sameRow){foldLineNext=j[q+1];if(foldLineNext&&foldLineNext.start.row==g){l.merge(foldLineNext);break}}break}if(g<=l.start.row)break}p||(l=this.$addFoldLine(new e(this.$foldData,m))),this.$useWrapMode&&this.$updateWrapData(l.start.row,l.start.row),this.$modified=!0,this._dispatchEvent("changeFold",{data:m});return m},this.addFolds=function(a){a.forEach(function(a){this.addFold(a)},this)},this.removeFold=function(a){var b=a.foldLine,c=b.start.row,d=b.end.row,e=this.$foldData,f=b.folds;if(f.length==1)e.splice(e.indexOf(b),1);else if(b.range.isEnd(a.end.row,a.end.column))f.pop(),b.end.row=f[f.length-1].end.row,b.end.column=f[f.length-1].end.column;else if(b.range.isStart(a.start.row,a.start.column))f.shift(),b.start.row=f[0].start.row,b.start.column=f[0].start.column;else if(a.sameRow)f.splice(f.indexOf(a),1);else{var g=b.split(a.start.row,a.start.column);g.folds.shift(),b.start.row=f[0].start.row,b.start.column=f[0].start.column,this.$addFoldLine(g)}this.$useWrapMode&&this.$updateWrapData(c,d),this.$modified=!0,this._dispatchEvent("changeFold",{data:a})},this.removeFolds=function(a){var b=[];for(var c=0;c<a.length;c++)b.push(a[c]);b.forEach(function(a){this.removeFold(a)},this),this.$modified=!0},this.expandFold=function(a){this.removeFold(a),a.subFolds.forEach(function(a){this.addFold(a)},this),a.subFolds=[]},this.expandFolds=function(a){a.forEach(function(a){this.expandFold(a)},this)},this.isRowFolded=function(a,b){return!!this.getFoldLine(a,b)},this.getRowFoldEnd=function(a,b){var c=this.getFoldLine(a,b);return c?c.end.row:a},this.getFoldDisplayLine=function(a,b,c,d,e){d==null&&(d=a.start.row,e=0),b==null&&(b=a.end.row,c=this.getLine(b).length);var f="",g=this.doc,h="";a.walk(function(a,b,c,f,i){if(b>=d){if(b==d){if(c<e)return;f=Math.max(e,f)}a?h+=a:h+=g.getLine(b).substring(f,c)}}.bind(this),b,c);return h},this.getDisplayLine=function(a,b,c,d){var e=this.getFoldLine(a);if(e)return this.getFoldDisplayLine(e,a,b,c,d);var f;f=this.doc.getLine(a);return f.substring(d||0,b||f.length)},this.$cloneFoldData=function(){var a=this.$foldData,b=[];b=this.$foldData.map(function(a){var c=a.folds.map(function(a){return a.clone()});return new e(b,c)});return b}}function f(a,b){this.foldLine=null,this.placeholder=b,this.range=a,this.start=a.start,this.end=a.end,this.sameRow=a.start.row==a.end.row,this.subFolds=[]}var d=a("ace/range").Range,e=a("ace/edit_session/fold_line").FoldLine;f.prototype.toString=function(){return'"'+this.placeholder+'" '+this.range.toString()},f.prototype.setFoldLine=function(a){this.foldLine=a,this.subFolds.forEach(function(b){b.setFoldLine(a)})},f.prototype.clone=function(){var a=this.range.clone(),b=new f(a,this.placeholder);this.subFolds.forEach(function(a){b.subFolds.push(a.clone())});return b},b.Folding=g}),define("ace/edit_session/fold_line",["require","exports","module","ace/range"],function(a,b,c){function e(a,b){this.foldData=a,Array.isArray(b)?this.folds=b:b=this.folds=[b];var c=b[b.length-1];this.range=new d(b[0].start.row,b[0].start.column,c.end.row,c.end.column),this.start=this.range.start,this.end=this.range.end,this.folds.forEach(function(a){a.setFoldLine(this)},this)}var d=a("ace/range").Range;(function(){this.shiftRow=function(a){this.start.row+=a,this.end.row+=a,this.folds.forEach(function(b){b.start.row+=a,b.end.row+=a})},this.addFold=function(a){if(a.sameRow){if(a.start.row<this.startRow||a.endRow>this.endRow)throw"Can't add a fold to this FoldLine as it has no connection";this.folds.push(a),this.folds.sort(function(a,b){return-a.range.compareEnd(b.start.row,b.start.column)}),this.range.compareEnd(a.start.row,a.start.column)>0?(this.end.row=a.end.row,this.end.column=a.end.column):this.range.compareStart(a.end.row,a.end.column)<0&&(this.start.row=a.start.row,this.start.column=a.start.column)}else if(a.start.row==this.end.row)this.folds.push(a),this.end.row=a.end.row,this.end.column=a.end.column;else if(a.end.row==this.start.row)this.folds.unshift(a),this.start.row=a.start.row,this.start.column=a.start.column;else throw"Trying to add fold to FoldRow that doesn't have a matching row";a.foldLine=this},this.containsRow=function(a){return a>=this.start.row&&a<=this.end.row},this.walk=function(a,b,c){var d=0,e=this.folds,f,g,h,i=!0;b==null&&(b=this.end.row,c=this.end.column);for(var j=0;j<e.length;j++){f=e[j],g=f.range.compareStart(b,c);if(g==-1){a(null,b,c,d,i);return}h=a(null,f.start.row,f.start.column,d,i),h=!h&&a(f.placeholder,f.start.row,f.start.column,d);if(h||g==0)return;i=!f.sameRow,d=f.end.column}a(null,b,c,d,i)},this.getNextFoldTo=function(a,b){var c,d;for(var e=0;e<this.folds.length;e++){c=this.folds[e],d=c.range.compareEnd(a,b);if(d==-1)return{fold:c,kind:"after"};if(d==0)return{fold:c,kind:"inside"}}return null},this.addRemoveChars=function(a,b,c){var d=this.getNextFoldTo(a,b),e,f;if(d){e=d.fold;if(d.kind=="inside"&&e.start.column!=b&&e.start.row!=a)throw"Moving characters inside of a fold should never be reached";if(e.start.row==a){f=this.folds;var g=f.indexOf(e);g==0&&(this.start.column+=c);for(g;g<f.length;g++){e=f[g],e.start.column+=c;if(!e.sameRow)return;e.end.column+=c}this.end.column+=c}}},this.split=function(a,b){var c=this.getNextFoldTo(a,b).fold,d=this.folds,f=this.foldData;if(!c)return null;var g=d.indexOf(c),h=d[g-1];this.end.row=h.end.row,this.end.column=h.end.column,d=d.splice(g,d.length-g);var i=new e(f,d);f.splice(f.indexOf(this)+1,0,i);return i},this.merge=function(a){var b=a.folds;for(var c=0;c<b.length;c++)this.addFold(b[c]);var d=this.foldData;d.splice(d.indexOf(a),1)},this.toString=function(){var a=[this.range.toString()+": ["];this.folds.forEach(function(b){a.push("  "+b.toString())}),a.push("]");return a.join("\n")},this.idxToPosition=function(a){var b=0,c;for(var d=0;d<this.folds.length;d++){var c=this.folds[d];a-=c.start.column-b;if(a<0)return{row:c.start.row,column:c.start.column+a};a-=c.placeholder.length;if(a<0)return c.start;b=c.end.column}return{row:this.end.row,column:this.end.column+a}}}).call(e.prototype),b.FoldLine=e}),define("ace/search",["require","exports","module","pilot/lang","pilot/oop","ace/range"],function(a,b,c){var d=a("pilot/lang"),e=a("pilot/oop"),f=a("ace/range").Range,g=function(){this.$options={needle:"",backwards:!1,wrap:!1,caseSensitive:!1,wholeWord:!1,scope:g.ALL,regExp:!1}};g.ALL=1,g.SELECTION=2,function(){this.set=function(a){e.mixin(this.$options,a);return this},this.getOptions=function(){return d.copyObject(this.$options)},this.find=function(a){if(!this.$options.needle)return null;if(this.$options.backwards)var b=this.$backwardMatchIterator(a);else b=this.$forwardMatchIterator(a);var c=null;b.forEach(function(a){c=a;return!0});return c},this.findAll=function(a){if(!this.$options.needle)return[];if(this.$options.backwards)var b=this.$backwardMatchIterator(a);else b=this.$forwardMatchIterator(a);var c=[];b.forEach(function(a){c.push(a)});return c},this.replace=function(a,b){var c=this.$assembleRegExp(),d=c.exec(a);return d&&d[0].length==a.length?this.$options.regExp?a.replace(c,b):b:null},this.$forwardMatchIterator=function(a){var b=this.$assembleRegExp(),c=this;return{forEach:function(d){c.$forwardLineIterator(a).forEach(function(a,e,f){e&&(a=a.substring(e));var g=[];a.replace(b,function(a){var b=arguments[arguments.length-2];g.push({str:a,offset:e+b});return a});for(var h=0;h<g.length;h++){var i=g[h],j=c.$rangeFromMatch(f,i.offset,i.str.length);if(d(j))return!0}})}}},this.$backwardMatchIterator=function(a){var b=this.$assembleRegExp(),c=this;return{forEach:function(d){c.$backwardLineIterator(a).forEach(function(a,e,f){e&&(a=a.substring(e));var g=[];a.replace(b,function(a,b){g.push({str:a,offset:e+b});return a});for(var h=g.length-1;h>=0;h--){var i=g[h],j=c.$rangeFromMatch(f,i.offset,i.str.length);if(d(j))return!0}})}}},this.$rangeFromMatch=function(a,b,c){return new f(a,b,a,b+c)},this.$assembleRegExp=function(){if(this.$options.regExp)var a=this.$options.needle;else a=d.escapeRegExp(this.$options.needle);this.$options.wholeWord&&(a="\\b"+a+"\\b");var b="g";this.$options.caseSensitive||(b+="i");var c=new RegExp(a,b);return c},this.$forwardLineIterator=function(a){function k(e){var f=a.getLine(e);b&&e==c.end.row&&(f=f.substring(0,c.end.column)),j&&e==d.row&&(f=f.substring(0,d.column));return f}var b=this.$options.scope==g.SELECTION,c=a.getSelection().getRange(),d=a.getSelection().getCursor(),e=b?c.start.row:0,f=b?c.start.column:0,h=b?c.end.row:a.getLength()-1,i=this.$options.wrap,j=!1;return{forEach:function(a){var b=d.row,c=k(b),g=d.column,l=!1;j=!1;while(!a(c,g,b)){if(l)return;b++,g=0;if(b>h)if(i)b=e,g=f,j=!0;else return;b==d.row&&(l=!0),c=k(b)}}}},this.$backwardLineIterator=function(a){var b=this.$options.scope==g.SELECTION,c=a.getSelection().getRange(),d=b?c.end:c.start,e=b?c.start.row:0,f=b?c.start.column:0,h=b?c.end.row:a.getLength()-1,i=this.$options.wrap;return{forEach:function(g){var j=d.row,k=a.getLine(j).substring(0,d.column),l=0,m=!1,n=!1;while(!g(k,l,j)){if(m)return;j--,l=0;if(j<e)if(i)j=h,n=!0;else return;j==d.row&&(m=!0),k=a.getLine(j),b&&(j==e?l=f:j==h&&(k=k.substring(0,c.end.column))),n&&j==d.row&&(l=d.column)}}}}}.call(g.prototype),b.Search=g}),define("ace/undomanager",["require","exports","module"],function(a,b,c){var d=function(){this.reset()};(function(){this.execute=function(a){var b=a.args[0];this.$doc=a.args[1],this.$undoStack.push(b),this.$redoStack=[]},this.undo=function(a){var b=this.$undoStack.pop(),c=null;b&&(c=this.$doc.undoChanges(b,a),this.$redoStack.push(b));return c},this.redo=function(a){var b=this.$redoStack.pop(),c=null;b&&(c=this.$doc.redoChanges(b,a),this.$undoStack.push(b));return c},this.reset=function(){this.$undoStack=[],this.$redoStack=[]},this.hasUndo=function(){return this.$undoStack.length>0},this.hasRedo=function(){return this.$redoStack.length>0}}).call(d.prototype),b.UndoManager=d}),define("ace/virtual_renderer",["require","exports","module","pilot/oop","pilot/dom","pilot/event","pilot/useragent","ace/layer/gutter","ace/layer/marker","ace/layer/text","ace/layer/cursor","ace/scrollbar","ace/renderloop","pilot/event_emitter","text/ace/css/editor.css"],function(a,b,c){var d=a("pilot/oop"),e=a("pilot/dom"),f=a("pilot/event"),g=a("pilot/useragent"),h=a("ace/layer/gutter").Gutter,i=a("ace/layer/marker").Marker,j=a("ace/layer/text").Text,k=a("ace/layer/cursor").Cursor,l=a("ace/scrollbar").ScrollBar,m=a("ace/renderloop").RenderLoop,n=a("pilot/event_emitter").EventEmitter,o=a("text/ace/css/editor.css");e.importCssString(o);var p=function(a,b){this.container=a,e.addCssClass(this.container,"ace_editor"),this.setTheme(b),this.$gutter=e.createElement("div"),this.$gutter.className="ace_gutter",this.container.appendChild(this.$gutter),this.scroller=e.createElement("div"),this.scroller.className="ace_scroller",this.container.appendChild(this.scroller),this.content=e.createElement("div"),this.content.className="ace_content",this.scroller.appendChild(this.content),this.$gutterLayer=new h(this.$gutter),this.$markerBack=new i(this.content);var c=this.$textLayer=new j(this.content);this.canvas=c.element,this.$markerFront=new i(this.content),this.characterWidth=c.getCharacterWidth(),this.lineHeight=c.getLineHeight(),this.$cursorLayer=new k(this.content),this.$cursorPadding=8,this.$horizScroll=!0,this.$horizScrollAlwaysVisible=!0,this.scrollBar=new l(a),this.scrollBar.addEventListener("scroll",this.onScroll.bind(this)),this.scrollTop=0,this.cursorPos={row:0,column:0};var d=this;this.$textLayer.addEventListener("changeCharaterSize",function(){d.characterWidth=c.getCharacterWidth(),d.lineHeight=c.getLineHeight(),d.$updatePrintMargin(),d.onResize(!0),d.$loop.schedule(d.CHANGE_FULL)}),f.addListener(this.$gutter,"click",this.$onGutterClick.bind(this)),f.addListener(this.$gutter,"dblclick",this.$onGutterClick.bind(this)),this.$size={width:0,height:0,scrollerHeight:0,scrollerWidth:0},this.$loop=new m(this.$renderChanges.bind(this)),this.$loop.schedule(this.CHANGE_FULL),this.setPadding(4),this.$updatePrintMargin()};(function(){this.showGutter=!0,this.CHANGE_CURSOR=1,this.CHANGE_MARKER=2,this.CHANGE_GUTTER=4,this.CHANGE_SCROLL=8,this.CHANGE_LINES=16,this.CHANGE_TEXT=32,this.CHANGE_SIZE=64,this.CHANGE_MARKER_BACK=128,this.CHANGE_MARKER_FRONT=256,this.CHANGE_FULL=512,d.implement(this,n),this.setSession=function(a){this.session=a,this.$cursorLayer.setSession(a),this.$markerBack.setSession(a),this.$markerFront.setSession(a),this.$gutterLayer.setSession(a),this.$textLayer.setSession(a),this.$loop.schedule(this.CHANGE_FULL)},this.updateLines=function(a,b){b===undefined&&(b=Infinity),this.$changedLines?(this.$changedLines.firstRow>a&&(this.$changedLines.firstRow=a),this.$changedLines.lastRow<b&&(this.$changedLines.lastRow=b)):this.$changedLines={firstRow:a,lastRow:b},this.$loop.schedule(this.CHANGE_LINES)},this.updateText=function(){this.$loop.schedule(this.CHANGE_TEXT)},this.updateFull=function(){this.$loop.schedule(this.CHANGE_FULL)},this.updateFontSize=function(){this.$textLayer.checkForSizeChanges()},this.onResize=function(a){var b=this.CHANGE_SIZE,c=e.getInnerHeight(this.container);if(a||this.$size.height!=c)this.$size.height=c,this.scroller.style.height=c+"px",this.scrollBar.setHeight(this.scroller.clientHeight),this.session&&(this.scrollToY(this.getScrollTop()),b=b|this.CHANGE_FULL);var d=e.getInnerWidth(this.container);if(a||this.$size.width!=d){this.$size.width=d;var f=this.showGutter?this.$gutter.offsetWidth:0;this.scroller.style.left=f+"px",this.scroller.style.width=Math.max(0,d-f-this.scrollBar.getWidth())+"px";if(this.session.getUseWrapMode()){var g=this.scroller.clientWidth-this.$padding*2,h=Math.floor(g/this.characterWidth)-1;if(this.session.adjustWrapLimit(h)||a)b=b|this.CHANGE_FULL}}this.$size.scrollerWidth=this.scroller.clientWidth,this.$size.scrollerHeight=this.scroller.clientHeight,this.$loop.schedule(b)},this.$onGutterClick=function(a){var b=f.getDocumentX(a),c=f.getDocumentY(a);this._dispatchEvent("gutter"+a.type,{row:this.screenToTextCoordinates(b,c).row,htmlEvent:a})},this.setShowInvisibles=function(a){this.$textLayer.setShowInvisibles(a)&&this.$loop.schedule(this.CHANGE_TEXT)},this.getShowInvisibles=function(){return this.$textLayer.showInvisibles},this.$showPrintMargin=!0,this.setShowPrintMargin=function(a){this.$showPrintMargin=a,this.$updatePrintMargin()},this.getShowPrintMargin=function(){return this.$showPrintMargin},this.$printMarginColumn=80,this.setPrintMarginColumn=function(a){this.$printMarginColumn=a,this.$updatePrintMargin()},this.getPrintMarginColumn=function(){return this.$printMarginColumn},this.getShowGutter=function(){return this.showGutter},this.setShowGutter=function(a){this.showGutter!==a&&(this.$gutter.style.display=a?"block":"none",this.showGutter=a,this.onResize(!0))},this.$updatePrintMargin=function(){var a;if(this.$showPrintMargin||this.$printMarginEl){this.$printMarginEl||(a=e.createElement("div"),a.className="ace_print_margin_layer",this.$printMarginEl=e.createElement("div"),this.$printMarginEl.className="ace_print_margin",a.appendChild(this.$printMarginEl),this.content.insertBefore(a,this.$textLayer.element));var b=this.$printMarginEl.style;b.left=this.characterWidth*this.$printMarginColumn+this.$padding*2+"px",b.visibility=this.$showPrintMargin?"visible":"hidden"}},this.getContainerElement=function(){return this.container},this.getMouseEventTarget=function(){return this.content},this.getTextAreaContainer=function(){return this.container},this.moveTextAreaToCursor=function(a){if(!g.isIE){var b=this.$cursorLayer.getPixelPosition();if(!b)return;var c=this.content.getBoundingClientRect(),d=this.layerConfig&&this.layerConfig.offset||0;a.style.left=c.left+b.left+this.$padding+"px",a.style.top=c.top+b.top-this.scrollTop+d+"px"}},this.getFirstVisibleRow=function(){return(this.layerConfig||{}).firstRow||0},this.getFirstFullyVisibleRow=function(){if(!this.layerConfig)return 0;return this.layerConfig.firstRow+(this.layerConfig.offset===0?0:1)},this.getLastFullyVisibleRow=function(){if(!this.layerConfig)return 0;var a=Math.floor((this.layerConfig.height+this.layerConfig.offset)/this.layerConfig.lineHeight);return this.layerConfig.firstRow-1+a},this.getLastVisibleRow=function(){return(this.layerConfig||{}).lastRow||0},this.$padding=null,this.setPadding=function(a){this.$padding=a,this.content.style.padding="0 "+a+"px",this.$loop.schedule(this.CHANGE_FULL),this.$updatePrintMargin()},this.getHScrollBarAlwaysVisible=function(){return this.$horizScrollAlwaysVisible},this.setHScrollBarAlwaysVisible=function(a){this.$horizScrollAlwaysVisible!=a&&(this.$horizScrollAlwaysVisible=a,(!this.$horizScrollAlwaysVisible||!this.$horizScroll)&&this.$loop.schedule(this.CHANGE_SCROLL))},this.onScroll=function(a){this.scrollToY(a.data)},this.$updateScrollBar=function(){this.scrollBar.setInnerHeight(this.layerConfig.maxHeight),this.scrollBar.setScrollTop(this.scrollTop)},this.$renderChanges=function(a){if(a&&this.session){(!this.layerConfig||a&this.CHANGE_FULL||a&this.CHANGE_SIZE||a&this.CHANGE_TEXT||a&this.CHANGE_LINES||a&this.CHANGE_SCROLL)&&this.$computeLayerConfig();if(a&this.CHANGE_FULL){this.$textLayer.update(this.layerConfig),this.showGutter&&this.$gutterLayer.update(this.layerConfig),this.$markerBack.update(this.layerConfig),this.$markerFront.update(this.layerConfig),this.$cursorLayer.update(this.layerConfig),this.$updateScrollBar();return}if(a&this.CHANGE_SCROLL){a&this.CHANGE_TEXT||a&this.CHANGE_LINES?this.$textLayer.update(this.layerConfig):this.$textLayer.scrollLines(this.layerConfig),this.showGutter&&this.$gutterLayer.update(this.layerConfig),this.$markerBack.update(this.layerConfig),this.$markerFront.update(this.layerConfig),this.$cursorLayer.update(this.layerConfig),this.$updateScrollBar();return}a&this.CHANGE_TEXT?(this.$textLayer.update(this.layerConfig),this.showGutter&&this.$gutterLayer.update(this.layerConfig)):a&this.CHANGE_LINES?(this.$updateLines(),this.$updateScrollBar(),this.showGutter&&this.$gutterLayer.update(this.layerConfig)):a&this.CHANGE_GUTTER&&(this.showGutter&&this.$gutterLayer.update(this.layerConfig)),a&this.CHANGE_CURSOR&&this.$cursorLayer.update(this.layerConfig),a&(this.CHANGE_MARKER|this.CHANGE_MARKER_FRONT)&&this.$markerFront.update(this.layerConfig),a&(this.CHANGE_MARKER|this.CHANGE_MARKER_BACK)&&this.$markerBack.update(this.layerConfig),a&this.CHANGE_SIZE&&this.$updateScrollBar()}},this.$computeLayerConfig=function(){var a=this.session,b=this.scrollTop%this.lineHeight,c=this.$size.scrollerHeight+this.lineHeight,d=this.$getLongestLine(),e=this.layerConfig?this.layerConfig.width!=d:!0,f=this.$horizScrollAlwaysVisible||this.$size.scrollerWidth-d<0,g=this.$horizScroll!==f;this.$horizScroll=f,g&&(this.scroller.style.overflowX=f?"scroll":"hidden");var h=this.session.getScreenLength()*this.lineHeight;this.scrollTop=Math.max(0,Math.min(this.scrollTop,h-this.$size.scrollerHeight));var i=Math.ceil(c/this.lineHeight)-1,j=Math.max(0,Math.round((this.scrollTop-b)/this.lineHeight)),k=j+i,l,m,n={lineHeight:this.lineHeight};j=a.screenToDocumentRow(j,0);var o=a.getFoldLine(j);o&&(j=o.start.row),l=a.documentToScreenRow(j,0),m=a.getRowHeight(n,j),k=Math.min(a.screenToDocumentRow(k,0),a.getLength()-1),c=this.$size.scrollerHeight+a.getRowHeight(n,k)+m,b=this.scrollTop-l*this.lineHeight,this.layerConfig={width:d,padding:this.$padding,firstRow:j,firstRowScreen:l,lastRow:k,lineHeight:this.lineHeight,characterWidth:this.characterWidth,minHeight:c,maxHeight:h,offset:b,height:this.$size.scrollerHeight},this.$gutterLayer.element.style.marginTop=-b+"px",this.content.style.marginTop=-b+"px",this.content.style.width=d+"px",this.content.style.height=c+"px",this.$desiredScrollLeft&&(this.scrollToX(this.$desiredScrollLeft),this.$desiredScrollLeft=0),g&&this.onResize(!0)},this.$updateLines=function(){var a=this.$changedLines.firstRow,b=this.$changedLines.lastRow;this.$changedLines=null;var c=this.layerConfig;if(c.width!=this.$getLongestLine())return this.$textLayer.update(c);if(a<=c.lastRow+1){if(b<c.firstRow)return;if(b===Infinity){this.showGutter&&this.$gutterLayer.update(c),this.$textLayer.update(c);return}this.$textLayer.updateLines(c,a,b)}},this.$getLongestLine=function(){var a=this.session.getScreenWidth()+1;this.$textLayer.showInvisibles&&(a+=1);return Math.max(this.$size.scrollerWidth-this.$padding*2,Math.round(a*this.characterWidth))},this.updateFrontMarkers=function(){this.$markerFront.setMarkers(this.session.getMarkers(!0)),this.$loop.schedule(this.CHANGE_MARKER_FRONT)},this.updateBackMarkers=function(){this.$markerBack.setMarkers(this.session.getMarkers()),this.$loop.schedule(this.CHANGE_MARKER_BACK)},this.addGutterDecoration=function(a,b){this.$gutterLayer.addGutterDecoration(a,b),this.$loop.schedule(this.CHANGE_GUTTER)},this.removeGutterDecoration=function(a,b){this.$gutterLayer.removeGutterDecoration(a,b),this.$loop.schedule(this.CHANGE_GUTTER)},this.setBreakpoints=function(a){this.$gutterLayer.setBreakpoints(a),this.$loop.schedule(this.CHANGE_GUTTER)},this.setAnnotations=function(a){this.$gutterLayer.setAnnotations(a),this.$loop.schedule(this.CHANGE_GUTTER)},this.updateCursor=function(){this.$loop.schedule(this.CHANGE_CURSOR)},this.hideCursor=function(){this.$cursorLayer.hideCursor()},this.showCursor=function(){this.$cursorLayer.showCursor()},this.scrollCursorIntoView=function(){if(this.$size.scrollerHeight!==0){var a=this.$cursorLayer.getPixelPosition(),b=a.left+this.$padding,c=a.top;this.scrollTop>c&&this.scrollToY(c),this.scrollTop+this.$size.scrollerHeight<c+this.lineHeight&&this.scrollToY(c+this.lineHeight-this.$size.scrollerHeight);var d=this.scroller.scrollLeft;d>b&&this.scrollToX(b),d+this.$size.scrollerWidth<b+this.characterWidth&&(b>this.layerConfig.width?this.$desiredScrollLeft=b+2*this.characterWidth:this.scrollToX(Math.round(b+this.characterWidth-this.$size.scrollerWidth)))}},this.getScrollTop=function(){return this.scrollTop},this.getScrollLeft=function(){return this.scroller.scrollLeft},this.getScrollTopRow=function(){return this.scrollTop/this.lineHeight},this.getScrollBottomRow=function(){return Math.max(0,Math.floor((this.scrollTop+this.$size.scrollerHeight)/this.lineHeight)-1)},this.scrollToRow=function(a){this.scrollToY(a*this.lineHeight)},this.scrollToLine=function(a,b){var c={lineHeight:this.lineHeight},d=0;for(var e=1;e<a;e++)d+=this.session.getRowHeight(c,e-1);b&&(d-=this.$size.scrollerHeight/2),this.scrollToY(d)},this.scrollToY=function(a){a=Math.max(0,a),this.scrollTop!==a&&(this.$loop.schedule(this.CHANGE_SCROLL),this.scrollTop=a)},this.scrollToX=function(a){a<=this.$padding&&(a=0),this.scroller.scrollLeft=a},this.scrollBy=function(a,b){b&&this.scrollToY(this.scrollTop+b),a&&this.scrollToX(this.scroller.scrollLeft+a)},this.screenToTextCoordinates=function(a,b){var c=this.scroller.getBoundingClientRect(),d=Math.round((a+this.scroller.scrollLeft-c.left-this.$padding-e.getPageScrollLeft())/this.characterWidth),f=Math.floor((b+this.scrollTop-c.top-e.getPageScrollTop())/this.lineHeight);return this.session.screenToDocumentPosition(f,Math.max(d,0))},this.textToScreenCoordinates=function(a,b){var c=this.scroller.getBoundingClientRect(),d=this.session.documentToScreenPosition(a,b),e=this.$padding+Math.round(d.column*this.characterWidth),f=d.row*this.lineHeight;return{pageX:c.left+e-this.getScrollLeft(),pageY:c.top+f-this.getScrollTop()}},this.visualizeFocus=function(){e.addCssClass(this.container,"ace_focus")},this.visualizeBlur=function(){e.removeCssClass(this.container,"ace_focus")},this.showComposition=function(a){this.$composition||(this.$composition=e.createElement("div"),this.$composition.className="ace_composition",this.content.appendChild(this.$composition)),this.$composition.innerHTML="&#160;";var b=this.$cursorLayer.getPixelPosition(),c=this.$composition.style;c.top=b.top+"px",c.left=b.left+this.$padding+"px",c.height=this.lineHeight+"px",this.hideCursor()},this.setCompositionText=function(a){e.setInnerText(this.$composition,a)},this.hideComposition=function(){this.showCursor();if(this.$composition){var a=this.$composition.style;a.top="-10000px",a.left="-10000px"}},this.setTheme=function(b){function d(a){c.$theme&&e.removeCssClass(c.container,c.$theme),c.$theme=a?a.cssClass:null,c.$theme&&e.addCssClass(c.container,c.$theme),c.$size&&(c.$size.width=0,c.onResize())}var c=this;this.$themeValue=b,b&&typeof b!="string"?d(b):(b=b||"ace/theme/textmate",a([b],function(a){d(a)}))},this.getTheme=function(){return this.$themeValue},this.setStyle=function b(a){e.addCssClass(this.container,a)},this.unsetStyle=function c(a){e.removeCssClass(this.container,a)},this.destroy=function(){this.$textLayer.destroy(),this.$cursorLayer.destroy()}}).call(p.prototype),b.VirtualRenderer=p}),define("ace/layer/gutter",["require","exports","module","pilot/dom"],function(a,b,c){var d=a("pilot/dom"),e=function(a){this.element=d.createElement("div"),this.element.className="ace_layer ace_gutter-layer",a.appendChild(this.element),this.$breakpoints=[],this.$annotations=[],this.$decorations=[]};(function(){this.setSession=function(a){this.session=a},this.addGutterDecoration=function(a,b){this.$decorations[a]||(this.$decorations[a]=""),this.$decorations[a]+=" ace_"+b},this.removeGutterDecoration=function(a,b){this.$decorations[a]=this.$decorations[a].replace(" ace_"+b,"")},this.setBreakpoints=function(a){this.$breakpoints=a.concat()},this.setAnnotations=function(a){this.$annotations=[];for(var b in a)if(a.hasOwnProperty(b)){var c=a[b];if(!c)continue;var d=this.$annotations[b]={text:[]};for(var e=0;e<c.length;e++){var f=c[e];d.text.push(f.text.replace(/"/g,"&quot;").replace(/'/g,"&#8217;").replace(/</,"&lt;"));var g=f.type;g=="error"?d.className="ace_error":g=="warning"&&d.className!="ace_error"?d.className="ace_warning":g=="info"&&!d.className&&(d.className="ace_info")}}},this.update=function(a){this.$config=a;var b={className:"",text:[]},c=[],e=a.firstRow,f=a.lastRow,g=this.session.getNextFold(e),h=g?g.start.row:Infinity;while(!0){e>h&&(e=g.end.row+1,g=this.session.getNextFold(e),h=g?g.start.row:Infinity);if(e>f)break;var i=this.$annotations[e]||b;c.push("<div class='ace_gutter-cell",this.$decorations[e]||"",this.$breakpoints[e]?" ace_breakpoint ":" ",i.className,"' title='",i.text.join("\n"),"' style='height:",a.lineHeight,"px;'>",e+1);var j=this.session.getRowLength(e)-1;while(j--)c.push("</div><div class='ace_gutter-cell' style='height:",a.lineHeight,"px'>&brvbar;</div>");c.push("</div>"),e++}this.element=d.setInnerHtml(this.element,c.join("")),this.element.style.height=a.minHeight+"px"}}).call(e.prototype),b.Gutter=e}),define("ace/layer/marker",["require","exports","module","ace/range","pilot/dom"],function(a,b,c){var d=a("ace/range").Range,e=a("pilot/dom"),f=function(a){this.element=e.createElement("div"),this.element.className="ace_layer ace_marker-layer",a.appendChild(this.element)};(function(){this.setSession=function(a){this.session=a},this.setMarkers=function(a){this.markers=a},this.update=function(a){var a=a||this.config;if(a){this.config=a;var b=[];for(var c in this.markers){var d=this.markers[c],f=d.range.clipRows(a.firstRow,a.lastRow);if(f.isEmpty())continue;f=f.toScreenRange(this.session);if(d.renderer){var g=this.$getTop(f.start.row,a),h=Math.round(f.start.column*a.characterWidth);d.renderer(b,f,h,g,a)}else f.isMultiLine()?d.type=="text"?this.drawTextMarker(b,f,d.clazz,a):this.drawMultiLineMarker(b,f,d.clazz,a):this.drawSingleLineMarker(b,f,d.clazz,a)}this.element=e.setInnerHtml(this.element,b.join(""))}},this.$getTop=function(a,b){return(a-b.firstRowScreen)*b.lineHeight},this.drawTextMarker=function(a,b,c,e){var f=b.start.row,g=new d(f,b.start.column,f,this.session.getScreenLastRowColumn(f));this.drawSingleLineMarker(a,g,c,e,1);var f=b.end.row,g=new d(f,0,f,b.end.column);this.drawSingleLineMarker(a,g,c,e);for(var f=b.start.row+1;f<b.end.row;f++)g.start.row=f,g.end.row=f,g.end.column=this.session.getScreenLastRowColumn(f),this.drawSingleLineMarker(a,g,c,e,1)},this.drawMultiLineMarker=function(a,b,c,d){var e=d.lineHeight,f=Math.round(d.width-b.start.column*d.characterWidth),g=this.$getTop(b.start.row,d),h=Math.round(b.start.column*d.characterWidth);a.push("<div class='",c,"' style='","height:",e,"px;","width:",f,"px;","top:",g,"px;","left:",h,"px;'></div>");var g=this.$getTop(b.end.row,d),f=Math.round(b.end.column*d.characterWidth);a.push("<div class='",c,"' style='","height:",e,"px;","top:",g,"px;","width:",f,"px;'></div>");var e=(b.end.row-b.start.row-1)*d.lineHeight;if(e>=0){var g=this.$getTop(b.start.row+1,d);a.push("<div class='",c,"' style='","height:",e,"px;","width:",d.width,"px;","top:",g,"px;'></div>")}},this.drawSingleLineMarker=function(a,b,c,d,e){var f=d.lineHeight,g=Math.round((b.end.column+(e||0)-b.start.column)*d.characterWidth),h=this.$getTop(b.start.row,d),i=Math.round(b.start.column*d.characterWidth);a.push("<div class='",c,"' style='","height:",f,"px;","width:",g,"px;","top:",h,"px;","left:",i,"px;'></div>")}}).call(f.prototype),b.Marker=f}),define("ace/layer/text",["require","exports","module","pilot/oop","pilot/dom","pilot/lang","pilot/useragent","pilot/event_emitter"],function(a,b,c){var d=a("pilot/oop"),e=a("pilot/dom"),f=a("pilot/lang"),g=a("pilot/useragent"),h=a("pilot/event_emitter").EventEmitter,i=function(a){this.element=e.createElement("div"),this.element.className="ace_layer ace_text-layer",a.appendChild(this.element),this.$characterSize=this.$measureSizes()||{width:0,height:0},this.$pollSizeChanges()};(function(){d.implement(this,h),this.EOF_CHAR="&para;",this.EOL_CHAR="&not;",this.TAB_CHAR="&rarr;",this.SPACE_CHAR="&middot;",this.getLineHeight=function(){return this.$characterSize.height||1},this.getCharacterWidth=function(){return this.$characterSize.width||1},this.checkForSizeChanges=function(){var a=this.$measureSizes();a&&(this.$characterSize.width!==a.width||this.$characterSize.height!==a.height)&&(this.$characterSize=a,this._dispatchEvent("changeCharaterSize",{data:a}))},this.$pollSizeChanges=function(){var a=this;this.$pollSizeChangesTimer=setInterval(function(){a.checkForSizeChanges()},500)},this.$fontStyles={fontFamily:1,fontSize:1,fontWeight:1,fontStyle:1,lineHeight:1},this.$measureSizes=function(){var a=1e3;if(!this.$measureNode){var b=this.$measureNode=e.createElement("div"),c=b.style;c.width=c.height="auto",c.left=c.top=-a*40+"px",c.visibility="hidden",c.position="absolute",c.overflow="visible",c.whiteSpace="nowrap",b.innerHTML=f.stringRepeat("Xy",a);if(document.body)document.body.appendChild(b);else{var d=this.element.parentNode;while(!e.hasCssClass(d,"ace_editor"))d=d.parentNode;d.appendChild(b)}}var c=this.$measureNode.style,g=e.computedStyle(this.element);for(var h in this.$fontStyles)c[h]=g[h];var i={height:this.$measureNode.offsetHeight,width:this.$measureNode.offsetWidth/(a*2)};if(i.width==0&&i.height==0)return null;return i},this.setSession=function(a){this.session=a},this.showInvisibles=!1,this.setShowInvisibles=function(a){if(this.showInvisibles==a)return!1;this.showInvisibles=a;return!0},this.$tabStrings=[],this.$computeTabString=function(){var a=this.session.getTabSize(),b=this.$tabStrings=[0];for(var c=1;c<a+1;c++)this.showInvisibles?b.push("<span class='ace_invisible'>"+this.TAB_CHAR+Array(c).join("&#160;")+"</span>"):b.push(Array(c+1).join("&#160;"))},this.updateLines=function(a,b,c){this.$computeTabString(),(this.config.lastRow!=a.lastRow||this.config.firstRow!=a.firstRow)&&this.scrollLines(a),this.config=a;var d=Math.max(b,a.firstRow),f=Math.min(c,a.lastRow),g=this.element.childNodes,h=0;for(var i=a.firstRow;i<d;i++){var j=this.session.getFoldLine(i);if(j){if(j.containsRow(d))break;i=j.end.row}h++}for(var k=d;k<=f;k++){var l=g[h++];if(!l)continue;var m=[],n=this.session.getTokens(k,k);this.$renderLine(m,k,n[0].tokens),l=e.setInnerHtml(l,m.join("")),k=this.session.getRowFoldEnd(k)}},this.scrollLines=function(a){this.$computeTabString();var b=this.config;this.config=a;if(!b||b.lastRow<a.firstRow)return this.update(a);if(a.lastRow<b.firstRow)return this.update(a);var c=this.element;if(b.firstRow<a.firstRow)for(var d=this.session.getFoldedRowCount(b.firstRow,a.firstRow-1);d>0;d--)c.removeChild(c.firstChild);if(b.lastRow>a.lastRow)for(var d=this.session.getFoldedRowCount(a.lastRow+1,b.lastRow);d>0;d--)c.removeChild(c.lastChild);if(a.firstRow<b.firstRow){var e=this.$renderLinesFragment(a,a.firstRow,b.firstRow-1);c.firstChild?c.insertBefore(e,c.firstChild):c.appendChild(e)}if(a.lastRow>b.lastRow){var e=this.$renderLinesFragment(a,b.lastRow+1,a.lastRow);c.appendChild(e)}},this.$renderLinesFragment=function(a,b,c){var d=document.createDocumentFragment(),f=b,g=this.session.getNextFold(f),h=g?g.start.row:Infinity;while(!0){f>h&&(f=g.end.row+1,g=this.session.getNextFold(f),h=g?g.start.row:Infinity);if(f>c)break;var i=e.createElement("div");i.className="ace_line";var j=[],k=this.session.getTokens(f,f);k.length==1&&this.$renderLine(j,f,k[0].tokens),i.innerHTML=j.join(""),d.appendChild(i),f++}return d},this.update=function(a){this.$computeTabString(),this.config=a;var b=[],c=a.firstRow,d=a.lastRow,f=c,g=this.session.getNextFold(f),h=g?g.start.row:Infinity;while(!0){f>h&&(f=g.end.row+1,g=this.session.getNextFold(f),h=g?g.start.row:Infinity);if(f>d)break;b.push("<div class='ace_line'>");var i=this.session.getTokens(f,f);i.length==1&&this.$renderLine(b,f,i[0].tokens),b.push("</div>"),f++}this.element=e.setInnerHtml(this.element,b.join(""))},this.$textToken={text:!0,rparen:!0,lparen:!0},this.$renderToken=function(a,b,c,d){var e=this,f=/\t|&|<|( +)|([\v\f \u00a0\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u200b\u2028\u2029\u3000])|[\u1100-\u115F]|[\u11A3-\u11A7]|[\u11FA-\u11FF]|[\u2329-\u232A]|[\u2E80-\u2E99]|[\u2E9B-\u2EF3]|[\u2F00-\u2FD5]|[\u2FF0-\u2FFB]|[\u3000-\u303E]|[\u3041-\u3096]|[\u3099-\u30FF]|[\u3105-\u312D]|[\u3131-\u318E]|[\u3190-\u31BA]|[\u31C0-\u31E3]|[\u31F0-\u321E]|[\u3220-\u3247]|[\u3250-\u32FE]|[\u3300-\u4DBF]|[\u4E00-\uA48C]|[\uA490-\uA4C6]|[\uA960-\uA97C]|[\uAC00-\uD7A3]|[\uD7B0-\uD7C6]|[\uD7CB-\uD7FB]|[\uF900-\uFAFF]|[\uFE10-\uFE19]|[\uFE30-\uFE52]|[\uFE54-\uFE66]|[\uFE68-\uFE6B]|[\uFF01-\uFF60]|[\uFFE0-\uFFE6]/g,h=function(a,c,d,f,h){if(a.charCodeAt(0)==32)return Array(a.length+1).join("&#160;");if(a=="\t"){var i=e.session.getScreenTabSize(b+f);b+=i-1;return e.$tabStrings[i]}if(a=="&")return g.isOldGecko?"&":"&amp;";if(a=="<")return"&lt;";if(a.match(/[\v\f \u00a0\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u200b\u2028\u2029\u3000]/)){if(e.showInvisibles){var j=Array(a.length+1).join(e.SPACE_CHAR);return"<span class='ace_invisible'>"+j+"</span>"}return"&#160;"}b+=1;return"<span class='ace_cjk' style='width:"+e.config.characterWidth*2+"px'>"+a+"</span>"},i=d.replace(f,h);if(this.$textToken[c.type])a.push(i);else{var j="ace_"+c.type.replace(/\./g," ace_");a.push("<span class='",j,"'>",i,"</span>")}return d.length},this.$renderLineCore=function(a,b,c,d){function k(b,c){i+=j.$renderToken(a,i,b,c)}var e=0,f=0,g,h=this.config.characterWidth,i=0,j=this;d&&d.length!=0?g=d[0]:g=Number.MAX_VALUE,a.push("<div style='height:",this.config.lineHeight,"px","'>");for(var l=0;l<c.length;l++){var m=c[l],n=m.value;if(e+n.length<g)k(m,n),e+=n.length;else{while(e+n.length>=g)k(m,n.substring(0,g-e)),n=n.substring(g-e),e=g,a.push("</div>","<div style='height:",this.config.lineHeight,"px","'>"),f++,i=0,g=d[f]||Number.MAX_VALUE;n.length!=0&&(e+=n.length,k(m,n))}}this.showInvisibles&&(b!==this.session.getLength()-1?a.push("<span class='ace_invisible'>"+this.EOL_CHAR+"</span>"):a.push("<span class='ace_invisible'>"+this.EOF_CHAR+"</span>")),a.push("</div>")},this.$renderLine=function(a,b,c){if(this.session.isRowFolded(b))this.$renderFoldLine(a,b,c);else{var d=this.session.getRowSplitData(b);this.$renderLineCore(a,b,c,d)}},this.$renderFoldLine=function(a,b,c){function g(a,b,c){var d=0,e=0;while(e+a[d].value.length<b){e+=a[d].value.length,d++;if(d==a.length)return}if(e!=b){var g=a[d].value.substring(b-e);g.length>c-b&&(g=g.substring(0,c-b)),f.push({type:a[d].type,value:g}),e=b+g.length,d+=1}while(e<c){var g=a[d].value;g.length+e>c&&(g=g.substring(0,c-e)),f.push({type:a[d].type,value:g}),e+=g.length,d+=1}}var d=this.session,e=d.getFoldLine(b),f=[];e.walk(function(a,b,d,e,h){a?f.push({type:"fold",value:a}):(h&&(c=this.session.getTokens(b,b)[0].tokens),c.length!=0&&g(c,e,d))}.bind(this),e.end.row,this.session.getLine(e.end.row).length);var h=this.session.$useWrapMode?this.session.$wrapData[b]:null;this.$renderLineCore(a,b,f,h)},this.destroy=function(){clearInterval(this.$pollSizeChangesTimer)}}).call(i.prototype),b.Text=i}),define("ace/layer/cursor",["require","exports","module","pilot/dom"],function(a,b,c){var d=a("pilot/dom"),e=function(a){this.element=d.createElement("div"),this.element.className="ace_layer ace_cursor-layer",a.appendChild(this.element),this.cursor=d.createElement("div"),this.cursor.className="ace_cursor ace_hidden",this.element.appendChild(this.cursor),this.isVisible=!1};(function(){this.setSession=function(a){this.session=a},this.hideCursor=function(){this.isVisible=!1,d.addCssClass(this.cursor,"ace_hidden"),clearInterval(this.blinkId)},this.showCursor=function(){this.isVisible=!0,d.removeCssClass(this.cursor,"ace_hidden"),this.cursor.style.visibility="visible",this.restartTimer()},this.restartTimer=function(){clearInterval(this.blinkId);if(this.isVisible){var a=this.cursor;this.blinkId=setInterval(function(){a.style.visibility="hidden",setNativeTimeout(function(){a.style.visibility="visible"},400)},1e3)}},this.getPixelPosition=function(a){if(!this.config||!this.session)return{left:0,top:0};var b=this.session.selection.getCursor(),c=this.session.documentToScreenPosition(b),d=Math.round(c.column*this.config.characterWidth),e=(c.row-(a?this.config.firstRowScreen:0))*this.config.lineHeight;return{left:d,top:e}},this.update=function(a){this.config=a,this.pixelPos=this.getPixelPosition(!0),this.cursor.style.left=this.pixelPos.left+"px",this.cursor.style.top=this.pixelPos.top+"px",this.cursor.style.width=a.characterWidth+"px",this.cursor.style.height=a.lineHeight+"px";var b=this.session.getOverwrite();b!=this.overwrite&&(this.overwrite=b,b?d.addCssClass(this.cursor,"ace_overwrite"):d.removeCssClass(this.cursor,"ace_overwrite")),this.restartTimer()},this.destroy=function(){clearInterval(this.blinkId)}}).call(e.prototype),b.Cursor=e}),define("ace/scrollbar",["require","exports","module","pilot/oop","pilot/dom","pilot/event","pilot/event_emitter"],function(a,b,c){var d=a("pilot/oop"),e=a("pilot/dom"),f=a("pilot/event"),g=a("pilot/event_emitter").EventEmitter,h=function(a){this.element=e.createElement("div"),this.element.className="ace_sb",this.inner=e.createElement("div"),this.element.appendChild(this.inner),a.appendChild(this.element),this.width=e.scrollbarWidth(),this.element.style.width=this.width+"px",f.addListener(this.element,"scroll",this.onScroll.bind(this))};(function(){d.implement(this,g),this.onScroll=function(){this._dispatchEvent("scroll",{data:this.element.scrollTop})},this.getWidth=function(){return this.width},this.setHeight=function(a){this.element.style.height=a+"px"},this.setInnerHeight=function(a){this.inner.style.height=a+"px"},this.setScrollTop=function(a){this.element.scrollTop=a}}).call(h.prototype),b.ScrollBar=h}),define("ace/renderloop",["require","exports","module","pilot/event"],function(a,b,c){var d=a("pilot/event"),e=function(a){this.onRender=a,this.pending=!1,this.changes=0};(function(){this.schedule=function(a){this.changes=this.changes|a;if(!this.pending){this.pending=!0;var b=this;this.setNativeTimeoutZero(function(){b.pending=!1;var a=b.changes;b.changes=0,b.onRender(a)})}},this.setNativeTimeoutZero=window.requestAnimationFrame||window.webkitRequestAnimationFrame||window.mozRequestAnimationFrame||window.oRequestAnimationFrame||window.msRequestAnimationFrame,this.setNativeTimeoutZero?this.setNativeTimeoutZero=this.setNativeTimeoutZero.bind(window):window.postMessage?(this.messageName="zero-timeout-message",this.setNativeTimeoutZero=function(a){if(!this.attached){var b=this;d.addListener(window,"message",function(a){b.callback&&a.data==b.messageName&&(d.stopPropagation(a),b.callback())}),this.attached=!0}this.callback=a,window.postMessage(this.messageName,"*")}):this.setNativeTimeoutZero=function(a){setNativeTimeout(a,0)}}).call(e.prototype),b.RenderLoop=e}),define("ace/theme/textmate",["require","exports","module","pilot/dom"],function(a,b,c){var d=a("pilot/dom"),e=".ace-tm .ace_editor {\n  border: 2px solid rgb(159, 159, 159);\n}\n\n.ace-tm .ace_editor.ace_focus {\n  border: 2px solid #327fbd;\n}\n\n.ace-tm .ace_gutter {\n  width: 50px;\n  background: #e8e8e8;\n  color: #333;\n  overflow : hidden;\n}\n\n.ace-tm .ace_gutter-layer {\n  width: 100%;\n  text-align: right;\n}\n\n.ace-tm .ace_gutter-layer .ace_gutter-cell {\n  padding-right: 6px;\n}\n\n.ace-tm .ace_print_margin {\n  width: 1px;\n  background: #e8e8e8;\n}\n\n.ace-tm .ace_text-layer {\n  cursor: text;\n}\n\n.ace-tm .ace_cursor {\n  border-left: 2px solid black;\n}\n\n.ace-tm .ace_cursor.ace_overwrite {\n  border-left: 0px;\n  border-bottom: 1px solid black;\n}\n        \n.ace-tm .ace_line .ace_invisible {\n  color: rgb(191, 191, 191);\n}\n\n.ace-tm .ace_line .ace_keyword {\n  color: blue;\n}\n\n.ace-tm .ace_line .ace_constant.ace_buildin {\n  color: rgb(88, 72, 246);\n}\n\n.ace-tm .ace_line .ace_constant.ace_language {\n  color: rgb(88, 92, 246);\n}\n\n.ace-tm .ace_line .ace_constant.ace_library {\n  color: rgb(6, 150, 14);\n}\n\n.ace-tm .ace_line .ace_invalid {\n  background-color: rgb(153, 0, 0);\n  color: white;\n}\n\n.ace-tm .ace_line .ace_fold {\n    background-color: #E4E4E4;\n    border-radius: 3px;\n}\n\n.ace-tm .ace_line .ace_support.ace_function {\n  color: rgb(60, 76, 114);\n}\n\n.ace-tm .ace_line .ace_support.ace_constant {\n  color: rgb(6, 150, 14);\n}\n\n.ace-tm .ace_line .ace_support.ace_type,\n.ace-tm .ace_line .ace_support.ace_class {\n  color: rgb(109, 121, 222);\n}\n\n.ace-tm .ace_line .ace_keyword.ace_operator {\n  color: rgb(104, 118, 135);\n}\n\n.ace-tm .ace_line .ace_string {\n  color: rgb(3, 106, 7);\n}\n\n.ace-tm .ace_line .ace_comment {\n  color: rgb(76, 136, 107);\n}\n\n.ace-tm .ace_line .ace_comment.ace_doc {\n  color: rgb(0, 102, 255);\n}\n\n.ace-tm .ace_line .ace_comment.ace_doc.ace_tag {\n  color: rgb(128, 159, 191);\n}\n\n.ace-tm .ace_line .ace_constant.ace_numeric {\n  color: rgb(0, 0, 205);\n}\n\n.ace-tm .ace_line .ace_variable {\n  color: rgb(49, 132, 149);\n}\n\n.ace-tm .ace_line .ace_xml_pe {\n  color: rgb(104, 104, 91);\n}\n\n.ace-tm .ace_marker-layer .ace_selection {\n  background: rgb(181, 213, 255);\n}\n\n.ace-tm .ace_marker-layer .ace_step {\n  background: rgb(252, 255, 0);\n}\n\n.ace-tm .ace_marker-layer .ace_stack {\n  background: rgb(164, 229, 101);\n}\n\n.ace-tm .ace_marker-layer .ace_bracket {\n  margin: -1px 0 0 -1px;\n  border: 1px solid rgb(192, 192, 192);\n}\n\n.ace-tm .ace_marker-layer .ace_active_line {\n  background: rgb(232, 242, 254);\n}\n\n.ace-tm .ace_marker-layer .ace_selected_word {\n  background: rgb(250, 250, 255);\n  border: 1px solid rgb(200, 200, 250);\n}\n\n.ace-tm .ace_string.ace_regex {\n  color: rgb(255, 0, 0)\n}";d.importCssString(e),b.cssClass="ace-tm"}),define("pilot/environment",["require","exports","module","pilot/settings"],function(a,b,c){function e(){return{settings:d}}var d=a("pilot/settings").settings;b.create=e}),define("text/ace/css/editor.css",[],'.ace_editor {    position: absolute;    overflow: hidden;    font-family: "Menlo", "Monaco", "Courier New", monospace;    font-size: 12px;}.ace_scroller {    position: absolute;    overflow-x: scroll;    overflow-y: hidden;}.ace_content {    position: absolute;    box-sizing: border-box;    -moz-box-sizing: border-box;    -webkit-box-sizing: border-box;}.ace_composition {    position: absolute;    background: #555;    color: #DDD;    z-index: 4;}.ace_gutter {    position: absolute;    overflow-x: hidden;    overflow-y: hidden;    height: 100%;}.ace_gutter-cell.ace_error {    background-image: url("data:image/gif,GIF89a%10%00%10%00%D5%00%00%F5or%F5%87%88%F5nr%F4ns%EBmq%F5z%7F%DDJT%DEKS%DFOW%F1Yc%F2ah%CE(7%CE)8%D18E%DD%40M%F2KZ%EBU%60%F4%60m%DCir%C8%16(%C8%19*%CE%255%F1%3FR%F1%3FS%E6%AB%B5%CA%5DI%CEn%5E%F7%A2%9A%C9G%3E%E0a%5B%F7%89%85%F5yy%F6%82%80%ED%82%80%FF%BF%BF%E3%C4%C4%FF%FF%FF%FF%FF%FF%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00!%F9%04%01%00%00%25%00%2C%00%00%00%00%10%00%10%00%00%06p%C0%92pH%2C%1A%8F%C8%D2H%93%E1d4%23%E4%88%D3%09mB%1DN%B48%F5%90%40%60%92G%5B%94%20%3E%22%D2%87%24%FA%20%24%C5%06A%00%20%B1%07%02B%A38%89X.v%17%82%11%13q%10%0Fi%24%0F%8B%10%7BD%12%0Ei%09%92%09%0EpD%18%15%24%0A%9Ci%05%0C%18F%18%0B%07%04%01%04%06%A0H%18%12%0D%14%0D%12%A1I%B3%B4%B5IA%00%3B");    background-repeat: no-repeat;    background-position: 4px center;}.ace_gutter-cell.ace_warning {    background-image: url("data:image/gif,GIF89a%10%00%10%00%D5%00%00%FF%DBr%FF%DE%81%FF%E2%8D%FF%E2%8F%FF%E4%96%FF%E3%97%FF%E5%9D%FF%E6%9E%FF%EE%C1%FF%C8Z%FF%CDk%FF%D0s%FF%D4%81%FF%D5%82%FF%D5%83%FF%DC%97%FF%DE%9D%FF%E7%B8%FF%CCl%7BQ%13%80U%15%82W%16%81U%16%89%5B%18%87%5B%18%8C%5E%1A%94d%1D%C5%83-%C9%87%2F%C6%84.%C6%85.%CD%8B2%C9%871%CB%8A3%CD%8B5%DC%98%3F%DF%9BB%E0%9CC%E1%A5U%CB%871%CF%8B5%D1%8D6%DB%97%40%DF%9AB%DD%99B%E3%B0p%E7%CC%AE%FF%FF%FF%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00!%F9%04%01%00%00%2F%00%2C%00%00%00%00%10%00%10%00%00%06a%C0%97pH%2C%1A%8FH%A1%ABTr%25%87%2B%04%82%F4%7C%B9X%91%08%CB%99%1C!%26%13%84*iJ9(%15G%CA%84%14%01%1A%97%0C%03%80%3A%9A%3E%81%84%3E%11%08%B1%8B%20%02%12%0F%18%1A%0F%0A%03\'F%1C%04%0B%10%16%18%10%0B%05%1CF%1D-%06%07%9A%9A-%1EG%1B%A0%A1%A0U%A4%A5%A6BA%00%3B");    background-repeat: no-repeat;    background-position: 4px center;}.ace_editor .ace_sb {    position: absolute;    overflow-x: hidden;    overflow-y: scroll;    right: 0;}.ace_editor .ace_sb div {    position: absolute;    width: 1px;    left: 0;}.ace_editor .ace_print_margin_layer {    z-index: 0;    position: absolute;    overflow: hidden;    margin: 0;    left: 0;    height: 100%;    width: 100%;}.ace_editor .ace_print_margin {    position: absolute;    height: 100%;}.ace_editor textarea {    position: fixed;    z-index: -1;    width: 10px;    height: 30px;    opacity: 0;    background: transparent;    appearance: none;    border: none;    resize: none;    outline: none;    overflow: hidden;}.ace_layer {    z-index: 1;    position: absolute;    overflow: hidden;    white-space: nowrap;    height: 100%;    width: 100%;}.ace_text-layer {    font-family: Monaco, "Courier New", monospace;    color: black;}.ace_cjk {    display: inline-block;    text-align: center;}.ace_cursor-layer {    z-index: 4;    cursor: text;    pointer-events: none;}.ace_cursor {    z-index: 4;    position: absolute;}.ace_cursor.ace_hidden {    opacity: 0.2;}.ace_line {    white-space: nowrap;}.ace_marker-layer {    cursor: text;    pointer-events: none;}.ace_marker-layer .ace_step {    position: absolute;    z-index: 3;}.ace_marker-layer .ace_selection {    position: absolute;    z-index: 4;}.ace_marker-layer .ace_bracket {    position: absolute;    z-index: 5;}.ace_marker-layer .ace_active_line {    position: absolute;    z-index: 2;}.ace_marker-layer .ace_selected_word {    position: absolute;    z-index: 6;    box-sizing: border-box;    -moz-box-sizing: border-box;    -webkit-box-sizing: border-box;}.ace_line .ace_fold {    cursor: pointer;}.ace_dragging .ace_marker-layer, .ace_dragging .ace_text-layer {  cursor: move;}'),define("text/styles.css",[],"html {    height: 100%;    width: 100%;    overflow: hidden;}body {    overflow: hidden;    margin: 0;    padding: 0;    height: 100%;    width: 100%;    font-family: Arial, Helvetica, sans-serif, Tahoma, Verdana, sans-serif;    font-size: 12px;    background: rgb(14, 98, 165);    color: white;}#logo {    padding: 15px;    margin-left: 65px;}#editor {    position: absolute;    top:  0px;    left: 280px;    bottom: 0px;    right: 0px;    background: white;}#controls {    padding: 5px;}#controls td {    text-align: right;}#controls td + td {    text-align: left;}#cockpitInput {    position: absolute;    left: 280px;    right: 0px;    bottom: 0;    border: none; outline: none;    font-family: consolas, courier, monospace;    font-size: 120%;}#cockpitOutput {    padding: 10px;    margin: 0 15px;    border: 1px solid #AAA;    -moz-border-radius-topleft: 10px;    -moz-border-radius-topright: 10px;    border-top-left-radius: 4px; border-top-right-radius: 4px;    background: #DDD; color: #000;}"),require(["ace/ace"],function(a){window.ace=a})p;28;_Ace/cockpit-uncompressed.jst;113605;/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Mozilla Skywriter.
 *
 * The Initial Developer of the Original Code is
 * Mozilla.
 * Portions created by the Initial Developer are Copyright (C) 2009
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *      Kevin Dangoor (kdangoor@mozilla.com)
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('cockpit/index', ['require', 'exports', 'module' , 'pilot/index', 'cockpit/cli', 'cockpit/ui/settings', 'cockpit/ui/cli_view', 'cockpit/commands/basic'], function(require, exports, module) {


exports.startup = function(data, reason) {
  require('pilot/index');
  require('cockpit/cli').startup(data, reason);
  // window.testCli = require('cockpit/test/testCli');

  require('cockpit/ui/settings').startup(data, reason);
  require('cockpit/ui/cli_view').startup(data, reason);
  require('cockpit/commands/basic').startup(data, reason);
};

/*
exports.shutdown(data, reason) {
};
*/


});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Skywriter.
 *
 * The Initial Developer of the Original Code is
 * Mozilla.
 * Portions created by the Initial Developer are Copyright (C) 2009
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Joe Walker (jwalker@mozilla.com)
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('cockpit/cli', ['require', 'exports', 'module' , 'pilot/console', 'pilot/lang', 'pilot/oop', 'pilot/event_emitter', 'pilot/types', 'pilot/canon'], function(require, exports, module) {


var console = require('pilot/console');
var lang = require('pilot/lang');
var oop = require('pilot/oop');
var EventEmitter = require('pilot/event_emitter').EventEmitter;

//var keyboard = require('keyboard/keyboard');
var types = require('pilot/types');
var Status = require('pilot/types').Status;
var Conversion = require('pilot/types').Conversion;
var canon = require('pilot/canon');

/**
 * Normally type upgrade is done when the owning command is registered, but
 * out commandParam isn't part of a command, so it misses out.
 */
exports.startup = function(data, reason) {
    canon.upgradeType('command', commandParam);
};

/**
 * The information required to tell the user there is a problem with their
 * input.
 * TODO: There a several places where {start,end} crop up. Perhaps we should
 * have a Cursor object.
 */
function Hint(status, message, start, end, predictions) {
    this.status = status;
    this.message = message;

    if (typeof start === 'number') {
        this.start = start;
        this.end = end;
        this.predictions = predictions;
    }
    else {
        var arg = start;
        this.start = arg.start;
        this.end = arg.end;
        this.predictions = arg.predictions;
    }
}
Hint.prototype = {
};
/**
 * Loop over the array of hints finding the one we should display.
 * @param hints array of hints
 */
Hint.sort = function(hints, cursor) {
    // Calculate 'distance from cursor'
    if (cursor !== undefined) {
        hints.forEach(function(hint) {
            if (hint.start === Argument.AT_CURSOR) {
                hint.distance = 0;
            }
            else if (cursor < hint.start) {
                hint.distance = hint.start - cursor;
            }
            else if (cursor > hint.end) {
                hint.distance = cursor - hint.end;
            }
            else {
                hint.distance = 0;
            }
        }, this);
    }
    // Sort
    hints.sort(function(hint1, hint2) {
        // Compare first based on distance from cursor
        if (cursor !== undefined) {
            var diff = hint1.distance - hint2.distance;
            if (diff != 0) {
                return diff;
            }
        }
        // otherwise go with hint severity
        return hint2.status - hint1.status;
    });
    // tidy-up
    if (cursor !== undefined) {
        hints.forEach(function(hint) {
            delete hint.distance;
        }, this);
    }
    return hints;
};
exports.Hint = Hint;

/**
 * A Hint that arose as a result of a Conversion
 */
function ConversionHint(conversion, arg) {
    this.status = conversion.status;
    this.message = conversion.message;
    if (arg) {
        this.start = arg.start;
        this.end = arg.end;
    }
    else {
        this.start = 0;
        this.end = 0;
    }
    this.predictions = conversion.predictions;
};
oop.inherits(ConversionHint, Hint);


/**
 * We record where in the input string an argument comes so we can report errors
 * against those string positions.
 * We publish a 'change' event when-ever the text changes
 * @param emitter Arguments use something else to pass on change events.
 * Currently this will be the creating Requisition. This prevents dependency
 * loops and prevents us from needing to merge listener lists.
 * @param text The string (trimmed) that contains the argument
 * @param start The position of the text in the original input string
 * @param end See start
 * @param prefix Knowledge of quotation marks and whitespace used prior to the
 * text in the input string allows us to re-generate the original input from
 * the arguments.
 * @param suffix Any quotation marks and whitespace used after the text.
 * Whitespace is normally placed in the prefix to the succeeding argument, but
 * can be used here when this is the last argument.
 * @constructor
 */
function Argument(emitter, text, start, end, prefix, suffix) {
    this.emitter = emitter;
    this.setText(text);
    this.start = start;
    this.end = end;
    this.prefix = prefix;
    this.suffix = suffix;
}
Argument.prototype = {
    /**
     * Return the result of merging these arguments.
     * TODO: What happens when we're merging arguments for the single string
     * case and some of the arguments are in quotation marks?
     */
    merge: function(following) {
        if (following.emitter != this.emitter) {
            throw new Error('Can\'t merge Arguments from different EventEmitters');
        }
        return new Argument(
            this.emitter,
            this.text + this.suffix + following.prefix + following.text,
            this.start, following.end,
            this.prefix,
            following.suffix);
    },

    /**
     * See notes on events in Assignment. We might need to hook changes here
     * into a CliRequisition so they appear of the command line.
     */
    setText: function(text) {
        if (text == null) {
            throw new Error('Illegal text for Argument: ' + text);
        }
        var ev = { argument: this, oldText: this.text, text: text };
        this.text = text;
        this.emitter._dispatchEvent('argumentChange', ev);
    },

    /**
     * Helper when we're putting arguments back together
     */
    toString: function() {
        // TODO: There is a bug here - we should re-escape escaped characters
        // But can we do that reliably?
        return this.prefix + this.text + this.suffix;
    }
};

/**
 * Merge an array of arguments into a single argument.
 * All Arguments in the array are expected to have the same emitter
 */
Argument.merge = function(argArray, start, end) {
    start = (start === undefined) ? 0 : start;
    end = (end === undefined) ? argArray.length : end;

    var joined;
    for (var i = start; i < end; i++) {
        var arg = argArray[i];
        if (!joined) {
            joined = arg;
        }
        else {
            joined = joined.merge(arg);
        }
    }
    return joined;
};

/**
 * We sometimes need a way to say 'this error occurs where ever the cursor is'
 */
Argument.AT_CURSOR = -1;


/**
 * A link between a parameter and the data for that parameter.
 * The data for the parameter is available as in the preferred type and as
 * an Argument for the CLI.
 * <p>We also record validity information where applicable.
 * <p>For values, null and undefined have distinct definitions. null means
 * that a value has been provided, undefined means that it has not.
 * Thus, null is a valid default value, and common because it identifies an
 * parameter that is optional. undefined means there is no value from
 * the command line.
 * @constructor
 */
function Assignment(param, requisition) {
    this.param = param;
    this.requisition = requisition;
    this.setValue(param.defaultValue);
};
Assignment.prototype = {
    /**
     * The parameter that we are assigning to
     * @readonly
     */
    param: undefined,

    /**
     * Report on the status of the last parse() conversion.
     * @see types.Conversion
     */
    conversion: undefined,

    /**
     * The current value in a type as specified by param.type
     */
    value: undefined,

    /**
     * The string version of the current value
     */
    arg: undefined,

    /**
     * The current value (i.e. not the string representation)
     * Use setValue() to mutate
     */
    value: undefined,
    setValue: function(value) {
        if (this.value === value) {
            return;
        }

        if (value === undefined) {
            this.value = this.param.defaultValue;
            this.conversion = this.param.getDefault ?
                    this.param.getDefault() :
                    this.param.type.getDefault();
            this.arg = undefined;
        } else {
            this.value = value;
            this.conversion = undefined;
            var text = (value == null) ? '' : this.param.type.stringify(value);
            if (this.arg) {
                this.arg.setText(text);
            }
        }

        this.requisition._assignmentChanged(this);
    },

    /**
     * The textual representation of the current value
     * Use setValue() to mutate
     */
    arg: undefined,
    setArgument: function(arg) {
        if (this.arg === arg) {
            return;
        }
        this.arg = arg;
        this.conversion = this.param.type.parse(arg.text);
        this.conversion.arg = arg; // TODO: make this automatic?
        this.value = this.conversion.value;
        this.requisition._assignmentChanged(this);
    },

    /**
     * Create a list of the hints associated with this parameter assignment.
     * Generally there will be only one hint generated because we're currently
     * only displaying one hint at a time, ordering by distance from cursor
     * and severity. Since distance from cursor will be the same for all hints
     * from this assignment all but the most severe will ever be used. It might
     * make sense with more experience to alter this to function to be getHint()
     */
    getHint: function() {
        // Allow the parameter to provide documentation
        if (this.param.getCustomHint && this.value && this.arg) {
            var hint = this.param.getCustomHint(this.value, this.arg);
            if (hint) {
                return hint;
            }
        }

        // If there is no argument, use the cursor position
        var message = '<strong>' + this.param.name + '</strong>: ';
        if (this.param.description) {
            // TODO: This should be a short description - do we need to trim?
            message += this.param.description.trim();

            // Ensure the help text ends with '. '
            if (message.charAt(message.length - 1) !== '.') {
                message += '.';
            }
            if (message.charAt(message.length - 1) !== ' ') {
                message += ' ';
            }
        }
        var status = Status.VALID;
        var start = this.arg ? this.arg.start : Argument.AT_CURSOR;
        var end = this.arg ? this.arg.end : Argument.AT_CURSOR;
        var predictions;

        // Non-valid conversions will have useful information to pass on
        if (this.conversion) {
            status = this.conversion.status;
            if (this.conversion.message) {
                message += this.conversion.message;
            }
            predictions = this.conversion.predictions;
        }

        // Hint if the param is required, but not provided
        var argProvided = this.arg && this.arg.text !== '';
        var dataProvided = this.value !== undefined || argProvided;
        if (this.param.defaultValue === undefined && !dataProvided) {
            status = Status.INVALID;
            message += '<strong>Required<\strong>';
        }

        return new Hint(status, message, start, end, predictions);
    },

    /**
     * Basically <tt>setValue(conversion.predictions[0])</tt> done in a safe
     * way.
     */
    complete: function() {
        if (this.conversion && this.conversion.predictions &&
                this.conversion.predictions.length > 0) {
            this.setValue(this.conversion.predictions[0]);
        }
    },

    /**
     * If the cursor is at 'position', do we have sufficient data to start
     * displaying the next hint. This is both complex and important.
     * For example, if the user has just typed:<ul>
     * <li>'set tabstop ' then they clearly want to know about the valid
     *     values for the tabstop setting, so the hint is based on the next
     *     parameter.
     * <li>'set tabstop' (without trailing space) - they will probably still
     *     want to know about the valid values for the tabstop setting because
     *     there is no confusion about the setting in question.
     * <li>'set tabsto' they've not finished typing a setting name so the hint
     *     should be based on the current parameter.
     * <li>'set tabstop' (when there is an additional tabstopstyle setting) we
     *     can't make assumptions about the setting - we're not finished.
     * </ul>
     * <p>Note that the input for 2 and 4 is identical, only the configuration
     * has changed, so hint display is environmental.
     *
     * <p>This function works out if the cursor is before the end of this
     * assignment (assuming that we've asked the same thing of the previous
     * assignment) and then attempts to work out if we should use the hint from
     * the next assignment even though technically the cursor is still inside
     * this one due to the rules above.
     */
    isPositionCaptured: function(position) {
        if (!this.arg) {
            return false;
        }

        // Note we don't check if position >= this.arg.start because that's
        // implied by the fact that we're asking the assignments in turn, and
        // we want to avoid thing falling between the cracks, but we do need
        // to check that the argument does have a position
        if (this.arg.start === -1) {
            return false;
        }

        // We're clearly done if the position is past the end of the text
        if (position > this.arg.end) {
            return false;
        }

        // If we're AT the end, the position is captured if either the status
        // is not valid or if there are other valid options including current
        if (position === this.arg.end) {
            return this.conversion.status !== Status.VALID ||
                    this.conversion.predictions.length !== 0;
        }

        // Otherwise we're clearly inside
        return true;
    },

    /**
     * Replace the current value with the lower value if such a concept
     * exists.
     */
    decrement: function() {
        var replacement = this.param.type.decrement(this.value);
        if (replacement != null) {
            this.setValue(replacement);
        }
    },

    /**
     * Replace the current value with the higher value if such a concept
     * exists.
     */
    increment: function() {
        var replacement = this.param.type.increment(this.value);
        if (replacement != null) {
            this.setValue(replacement);
        }
    },

    /**
     * Helper when we're rebuilding command lines.
     */
    toString: function() {
        return this.arg ? this.arg.toString() : '';
    }
};
exports.Assignment = Assignment;


/**
 * This is a special parameter to reflect the command itself.
 */
var commandParam = {
    name: '__command',
    type: 'command',
    description: 'The command to execute',

    /**
     * Provide some documentation for a command.
     */
    getCustomHint: function(command, arg) {
        var docs = [];
        docs.push('<strong><tt> &gt; ');
        docs.push(command.name);
        if (command.params && command.params.length > 0) {
            command.params.forEach(function(param) {
                if (param.defaultValue === undefined) {
                    docs.push(' [' + param.name + ']');
                }
                else {
                    docs.push(' <em>[' + param.name + ']</em>');
                }
            }, this);
        }
        docs.push('</tt></strong><br/>');

        docs.push(command.description ? command.description : '(No description)');
        docs.push('<br/>');

        if (command.params && command.params.length > 0) {
            docs.push('<ul>');
            command.params.forEach(function(param) {
                docs.push('<li>');
                docs.push('<strong><tt>' + param.name + '</tt></strong>: ');
                docs.push(param.description ? param.description : '(No description)');
                if (param.defaultValue === undefined) {
                    docs.push(' <em>[Required]</em>');
                }
                else if (param.defaultValue === null) {
                    docs.push(' <em>[Optional]</em>');
                }
                else {
                    docs.push(' <em>[Default: ' + param.defaultValue + ']</em>');
                }
                docs.push('</li>');
            }, this);
            docs.push('</ul>');
        }

        return new Hint(Status.VALID, docs.join(''), arg);
    }
};

/**
 * A Requisition collects the information needed to execute a command.
 * There is no point in a requisition for parameter-less commands because there
 * is no information to collect. A Requisition is a collection of assignments
 * of values to parameters, each handled by an instance of Assignment.
 * CliRequisition adds functions for parsing input from a command line to this
 * class.
 * <h2>Events<h2>
 * We publish the following events:<ul>
 * <li>argumentChange: The text of some argument has changed. It is likely that
 * any UI component displaying this argument will need to be updated. (Note that
 * this event is actually published by the Argument itself - see the docs for
 * Argument for more details)
 * The event object looks like: { argument: A, oldText: B, text: B }
 * <li>commandChange: The command has changed. It is likely that a UI
 * structure will need updating to match the parameters of the new command.
 * The event object looks like { command: A }
 * @constructor
 */
function Requisition(env) {
    this.env = env;
    this.commandAssignment = new Assignment(commandParam, this);
}

Requisition.prototype = {
    /**
     * The command that we are about to execute.
     * @see setCommandConversion()
     * @readonly
     */
    commandAssignment: undefined,

    /**
     * The count of assignments. Excludes the commandAssignment
     * @readonly
     */
    assignmentCount: undefined,

    /**
     * The object that stores of Assignment objects that we are filling out.
     * The Assignment objects are stored under their param.name for named
     * lookup. Note: We make use of the property of Javascript objects that
     * they are not just hashmaps, but linked-list hashmaps which iterate in
     * insertion order.
     * Excludes the commandAssignment.
     */
    _assignments: undefined,

    /**
     * The store of hints generated by the assignments. We are trying to prevent
     * the UI from needing to access this in broad form, but instead use
     * methods that query part of this structure.
     */
    _hints: undefined,

    /**
     * When the command changes, we need to keep a bunch of stuff in sync
     */
    _assignmentChanged: function(assignment) {
        // This is all about re-creating Assignments
        if (assignment.param.name !== '__command') {
            return;
        }

        this._assignments = {};

        if (assignment.value) {
            assignment.value.params.forEach(function(param) {
                this._assignments[param.name] = new Assignment(param, this);
            }, this);
        }

        this.assignmentCount = Object.keys(this._assignments).length;
        this._dispatchEvent('commandChange', { command: assignment.value });
    },

    /**
     * Assignments have an order, so we need to store them in an array.
     * But we also need named access ...
     */
    getAssignment: function(nameOrNumber) {
        var name = (typeof nameOrNumber === 'string') ?
            nameOrNumber :
            Object.keys(this._assignments)[nameOrNumber];
        return this._assignments[name];
    },

    /**
     * Where parameter name == assignment names - they are the same.
     */
    getParameterNames: function() {
        return Object.keys(this._assignments);
    },

    /**
     * A *shallow* clone of the assignments.
     * This is useful for systems that wish to go over all the assignments
     * finding values one way or another and wish to trim an array as they go.
     */
    cloneAssignments: function() {
        return Object.keys(this._assignments).map(function(name) {
            return this._assignments[name];
        }, this);
    },

    /**
     * Collect the statuses from the Assignments.
     * The hints returned are sorted by severity
     */
    _updateHints: function() {
        // TODO: work out when to clear this out for the plain Requisition case
        // this._hints = [];
        this.getAssignments(true).forEach(function(assignment) {
            this._hints.push(assignment.getHint());
        }, this);
        Hint.sort(this._hints);

        // We would like to put some initial help here, but for anyone but
        // a complete novice a 'type help' message is very annoying, so we
        // need to find a way to only display this message once, or for
        // until the user click a 'close' button or similar
        // TODO: Add special case for '' input
    },

    /**
     * Returns the most severe status
     */
    getWorstHint: function() {
        return this._hints[0];
    },

    /**
     * Extract the names and values of all the assignments, and return as
     * an object.
     */
    getArgsObject: function() {
        var args = {};
        this.getAssignments().forEach(function(assignment) {
            args[assignment.param.name] = assignment.value;
        }, this);
        return args;
    },

    /**
     * Access the arguments as an array.
     * @param includeCommand By default only the parameter arguments are
     * returned unless (includeCommand === true), in which case the list is
     * prepended with commandAssignment.arg
     */
    getAssignments: function(includeCommand) {
        var args = [];
        if (includeCommand === true) {
            args.push(this.commandAssignment);
        }
        Object.keys(this._assignments).forEach(function(name) {
            args.push(this.getAssignment(name));
        }, this);
        return args;
    },

    /**
     * Reset all the assignments to their default values
     */
    setDefaultValues: function() {
        this.getAssignments().forEach(function(assignment) {
            assignment.setValue(undefined);
        }, this);
    },

    /**
     * Helper to call canon.exec
     */
    exec: function() {
        canon.exec(this.commandAssignment.value,
              this.env,
              "cli",
              this.getArgsObject(),
              this.toCanonicalString());
    },

    /**
     * Extract a canonical version of the input
     */
    toCanonicalString: function() {
        var line = [];
        line.push(this.commandAssignment.value.name);
        Object.keys(this._assignments).forEach(function(name) {
            var assignment = this._assignments[name];
            var type = assignment.param.type;
            // TODO: This will cause problems if there is a non-default value
            // after a default value. Also we need to decide when to use
            // named parameters in place of positional params. Both can wait.
            if (assignment.value !== assignment.param.defaultValue) {
                line.push(' ');
                line.push(type.stringify(assignment.value));
            }
        }, this);
        return line.join('');
    }
};
oop.implement(Requisition.prototype, EventEmitter);
exports.Requisition = Requisition;


/**
 * An object used during command line parsing to hold the various intermediate
 * data steps.
 * <p>The 'output' of the update is held in 2 objects: input.hints which is an
 * array of hints to display to the user. In the future this will become a
 * single value.
 * <p>The other output value is input.requisition which gives access to an
 * args object for use in executing the final command.
 *
 * <p>The majority of the functions in this class are called in sequence by the
 * constructor. Their task is to add to <tt>hints</tt> fill out the requisition.
 * <p>The general sequence is:<ul>
 * <li>_tokenize(): convert _typed into _parts
 * <li>_split(): convert _parts into _command and _unparsedArgs
 * <li>_assign(): convert _unparsedArgs into requisition
 * </ul>
 *
 * @param typed {string} The instruction as typed by the user so far
 * @param options {object} A list of optional named parameters. Can be any of:
 * <b>flags</b>: Flags for us to check against the predicates specified with the
 * commands. Defaulted to <tt>keyboard.buildFlags({ });</tt>
 * if not specified.
 * @constructor
 */
function CliRequisition(env, options) {
    Requisition.call(this, env);

    if (options && options.flags) {
        /**
         * TODO: We were using a default of keyboard.buildFlags({ });
         * This allowed us to have commands that only existed in certain contexts
         * - i.e. Javascript specific commands.
         */
        this.flags = options.flags;
    }
}
oop.inherits(CliRequisition, Requisition);
(function() {
    /**
     * Called by the UI when ever the user interacts with a command line input
     * @param input A structure that details the state of the input field.
     * It should look something like: { typed:a, cursor: { start:b, end:c } }
     * Where a is the contents of the input field, and b and c are the start
     * and end of the cursor/selection respectively.
     */
    CliRequisition.prototype.update = function(input) {
        this.input = input;
        this._hints = [];

        var args = this._tokenize(input.typed);
        this._split(args);

        if (this.commandAssignment.value) {
            this._assign(args);
        }

        this._updateHints();
    };

    /**
     * Return an array of Status scores so we can create a marked up
     * version of the command line input.
     */
    CliRequisition.prototype.getInputStatusMarkup = function() {
        // 'scores' is an array which tells us what chars are errors
        // Initialize with everything VALID
        var scores = this.toString().split('').map(function(ch) {
            return Status.VALID;
        });
        // For all chars in all hints, check and upgrade the score
        this._hints.forEach(function(hint) {
            for (var i = hint.start; i <= hint.end; i++) {
                if (hint.status > scores[i]) {
                    scores[i] = hint.status;
                }
            }
        }, this);
        return scores;
    };

    /**
     * Reconstitute the input from the args
     */
    CliRequisition.prototype.toString = function() {
        return this.getAssignments(true).map(function(assignment) {
            return assignment.toString();
        }, this).join('');
    };

    var superUpdateHints = CliRequisition.prototype._updateHints;
    /**
     * Marks up hints in a number of ways:
     * - Makes INCOMPLETE hints that are not near the cursor INVALID since
     *   they can't be completed by typing
     * - Finds the most severe hint, and annotates the array with it
     * - Finds the hint to display, and also annotates the array with it
     * TODO: I'm wondering if array annotation is evil and we should replace
     * this with an object. Need to find out more.
     */
    CliRequisition.prototype._updateHints = function() {
        superUpdateHints.call(this);

        // Not knowing about cursor positioning, the requisition and assignments
        // can't know this, but anything they mark as INCOMPLETE is actually
        // INVALID unless the cursor is actually inside that argument.
        var c = this.input.cursor;
        this._hints.forEach(function(hint) {
            var startInHint = c.start >= hint.start && c.start <= hint.end;
            var endInHint = c.end >= hint.start && c.end <= hint.end;
            var inHint = startInHint || endInHint;
            if (!inHint && hint.status === Status.INCOMPLETE) {
                 hint.status = Status.INVALID;
            }
        }, this);

        Hint.sort(this._hints);
    };

    /**
     * Accessor for the hints array.
     * While we could just use the hints property, using getHints() is
     * preferred for symmetry with Requisition where it needs a function due to
     * lack of an atomic update system.
     */
    CliRequisition.prototype.getHints = function() {
        return this._hints;
    };

    /**
     * Look through the arguments attached to our assignments for the assignment
     * at the given position.
     */
    CliRequisition.prototype.getAssignmentAt = function(position) {
        var assignments = this.getAssignments(true);
        for (var i = 0; i < assignments.length; i++) {
            var assignment = assignments[i];
            if (!assignment.arg) {
                // There is no argument in this assignment, we've fallen off
                // the end of the obvious answers - it must be this one.
                return assignment;
            }
            if (assignment.isPositionCaptured(position)) {
                return assignment;
            }
        }

        return assignment;
    };

    /**
     * Split up the input taking into account ' and "
     */
    CliRequisition.prototype._tokenize = function(typed) {
        // For blank input, place a dummy empty argument into the list
        if (typed == null || typed.length === 0) {
            return [ new Argument(this, '', 0, 0, '', '') ];
        }

        var OUTSIDE = 1;     // The last character was whitespace
        var IN_SIMPLE = 2;   // The last character was part of a parameter
        var IN_SINGLE_Q = 3; // We're inside a single quote: '
        var IN_DOUBLE_Q = 4; // We're inside double quotes: "

        var mode = OUTSIDE;

        // First we un-escape. This list was taken from:
        // https://developer.mozilla.org/en/Core_JavaScript_1.5_Guide/Core_Language_Features#Unicode
        // We are generally converting to their real values except for \', \"
        // and '\ ' which we are converting to unicode private characters so we
        // can distinguish them from ', " and ' ', which have special meaning.
        // They need swapping back post-split - see unescape2()
        typed = typed
                .replace(/\\\\/g, '\\')
                .replace(/\\b/g, '\b')
                .replace(/\\f/g, '\f')
                .replace(/\\n/g, '\n')
                .replace(/\\r/g, '\r')
                .replace(/\\t/g, '\t')
                .replace(/\\v/g, '\v')
                .replace(/\\n/g, '\n')
                .replace(/\\r/g, '\r')
                .replace(/\\ /g, '\uF000')
                .replace(/\\'/g, '\uF001')
                .replace(/\\"/g, '\uF002');

        function unescape2(str) {
            return str
                .replace(/\uF000/g, ' ')
                .replace(/\uF001/g, '\'')
                .replace(/\uF002/g, '"');
        }

        var i = 0;
        var start = 0; // Where did this section start?
        var prefix = '';
        var args = [];

        while (true) {
            if (i >= typed.length) {
                // There is nothing else to read - tidy up
                if (mode !== OUTSIDE) {
                    var str = unescape2(typed.substring(start, i));
                    args.push(new Argument(this, str, start, i, prefix, ''));
                }
                else {
                    if (i !== start) {
                        // There's a bunch of whitespace at the end of the
                        // command add it to the last argument's suffix,
                        // creating an empty argument if needed.
                        var extra = typed.substring(start, i);
                        var lastArg = args[args.length - 1];
                        if (!lastArg) {
                            lastArg = new Argument(this, '', i, i, extra, '');
                            args.push(lastArg);
                        }
                        else {
                            lastArg.suffix += extra;
                        }
                    }
                }
                break;
            }

            var c = typed[i];
            switch (mode) {
                case OUTSIDE:
                    if (c === '\'') {
                        prefix = typed.substring(start, i + 1);
                        mode = IN_SINGLE_Q;
                        start = i + 1;
                    }
                    else if (c === '"') {
                        prefix = typed.substring(start, i + 1);
                        mode = IN_DOUBLE_Q;
                        start = i + 1;
                    }
                    else if (/ /.test(c)) {
                        // Still whitespace, do nothing
                    }
                    else {
                        prefix = typed.substring(start, i);
                        mode = IN_SIMPLE;
                        start = i;
                    }
                    break;

                case IN_SIMPLE:
                    // There is an edge case of xx'xx which we are assuming to
                    // be a single parameter (and same with ")
                    if (c === ' ') {
                        var str = unescape2(typed.substring(start, i));
                        args.push(new Argument(this, str,
                                start, i, prefix, ''));
                        mode = OUTSIDE;
                        start = i;
                        prefix = '';
                    }
                    break;

                case IN_SINGLE_Q:
                    if (c === '\'') {
                        var str = unescape2(typed.substring(start, i));
                        args.push(new Argument(this, str,
                                start - 1, i + 1, prefix, c));
                        mode = OUTSIDE;
                        start = i + 1;
                        prefix = '';
                    }
                    break;

                case IN_DOUBLE_Q:
                    if (c === '"') {
                        var str = unescape2(typed.substring(start, i));
                        args.push(new Argument(this, str,
                                start - 1, i + 1, prefix, c));
                        mode = OUTSIDE;
                        start = i + 1;
                        prefix = '';
                    }
                    break;
            }

            i++;
        }

        return args;
    };

    /**
     * Looks in the canon for a command extension that matches what has been
     * typed at the command line.
     */
    CliRequisition.prototype._split = function(args) {
        var argsUsed = 1;
        var arg;

        while (argsUsed <= args.length) {
            var arg = Argument.merge(args, 0, argsUsed);
            this.commandAssignment.setArgument(arg);

            if (!this.commandAssignment.value) {
                // Not found. break with value == null
                break;
            }

            /*
            // Previously we needed a way to hide commands depending context.
            // We have not resurrected that feature yet.
            if (!keyboard.flagsMatch(command.predicates, this.flags)) {
                // If the predicates say 'no match' then go LA LA LA
                command = null;
                break;
            }
            */

            if (this.commandAssignment.value.exec) {
                // Valid command, break with command valid
                for (var i = 0; i < argsUsed; i++) {
                    args.shift();
                }
                break;
            }

            argsUsed++;
        }
    };

    /**
     * Work out which arguments are applicable to which parameters.
     * <p>This takes #_command.params and #_unparsedArgs and creates a map of
     * param names to 'assignment' objects, which have the following properties:
     * <ul>
     * <li>param - The matching parameter.
     * <li>index - Zero based index into where the match came from on the input
     * <li>value - The matching input
     * </ul>
     */
    CliRequisition.prototype._assign = function(args) {
        if (args.length === 0) {
            this.setDefaultValues();
            return;
        }

        // Create an error if the command does not take parameters, but we have
        // been given them ...
        if (this.assignmentCount === 0) {
            // TODO: previously we were doing some extra work to avoid this if
            // we determined that we had args that were all whitespace, but
            // probably given our tighter tokenize() this won't be an issue?
            this._hints.push(new Hint(Status.INVALID,
                    this.commandAssignment.value.name +
                    ' does not take any parameters',
                    Argument.merge(args)));
            return;
        }

        // Special case: if there is only 1 parameter, and that's of type
        // text we put all the params into the first param
        if (this.assignmentCount === 1) {
            var assignment = this.getAssignment(0);
            if (assignment.param.type.name === 'text') {
                assignment.setArgument(Argument.merge(args));
                return;
            }
        }

        var assignments = this.cloneAssignments();
        var names = this.getParameterNames();

        // Extract all the named parameters
        var used = [];
        assignments.forEach(function(assignment) {
            var namedArgText = '--' + assignment.name;

            var i = 0;
            while (true) {
                var arg = args[i];
                if (namedArgText !== arg.text) {
                    i++;
                    if (i >= args.length) {
                        break;
                    }
                    continue;
                }

                // boolean parameters don't have values, default to false
                if (assignment.param.type.name === 'boolean') {
                    assignment.setValue(true);
                }
                else {
                    if (i + 1 < args.length) {
                        // Missing value portion of this named param
                        this._hints.push(new Hint(Status.INCOMPLETE,
                                'Missing value for: ' + namedArgText,
                                args[i]));
                    }
                    else {
                        args.splice(i + 1, 1);
                        assignment.setArgument(args[i + 1]);
                    }
                }

                lang.arrayRemove(names, assignment.name);
                args.splice(i, 1);
                // We don't need to i++ if we splice
            }
        }, this);

        // What's left are positional parameters assign in order
        names.forEach(function(name) {
            var assignment = this.getAssignment(name);
            if (args.length === 0) {
                // No more values
                assignment.setValue(undefined); // i.e. default
            }
            else {
                var arg = args[0];
                args.splice(0, 1);
                assignment.setArgument(arg);
            }
        }, this);

        if (args.length > 0) {
            var remaining = Argument.merge(args);
            this._hints.push(new Hint(Status.INVALID,
                    'Input \'' + remaining.text + '\' makes no sense.',
                    remaining));
        }
    };

})();
exports.CliRequisition = CliRequisition;


});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Mozilla Skywriter.
 *
 * The Initial Developer of the Original Code is
 * Mozilla.
 * Portions created by the Initial Developer are Copyright (C) 2009
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Joe Walker (jwalker@mozilla.com)
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('cockpit/ui/settings', ['require', 'exports', 'module' , 'pilot/types', 'pilot/types/basic'], function(require, exports, module) {


var types = require("pilot/types");
var SelectionType = require('pilot/types/basic').SelectionType;

var direction = new SelectionType({
    name: 'direction',
    data: [ 'above', 'below' ]
});

var hintDirectionSetting = {
    name: "hintDirection",
    description: "Are hints shown above or below the command line?",
    type: "direction",
    defaultValue: "above"
};

var outputDirectionSetting = {
    name: "outputDirection",
    description: "Is the output window shown above or below the command line?",
    type: "direction",
    defaultValue: "above"
};

var outputHeightSetting = {
    name: "outputHeight",
    description: "What height should the output panel be?",
    type: "number",
    defaultValue: 300
};

exports.startup = function(data, reason) {
    types.registerType(direction);
    data.env.settings.addSetting(hintDirectionSetting);
    data.env.settings.addSetting(outputDirectionSetting);
    data.env.settings.addSetting(outputHeightSetting);
};

exports.shutdown = function(data, reason) {
    types.unregisterType(direction);
    data.env.settings.removeSetting(hintDirectionSetting);
    data.env.settings.removeSetting(outputDirectionSetting);
    data.env.settings.removeSetting(outputHeightSetting);
};


});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Skywriter.
 *
 * The Initial Developer of the Original Code is
 * Mozilla.
 * Portions created by the Initial Developer are Copyright (C) 2009
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Joe Walker (jwalker@mozilla.com)
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('cockpit/ui/cli_view', ['require', 'exports', 'module' , 'text!cockpit/ui/cli_view.css', 'pilot/event', 'pilot/dom', 'pilot/keys', 'pilot/canon', 'pilot/types', 'cockpit/cli', 'cockpit/ui/request_view'], function(require, exports, module) {


var editorCss = require("text!cockpit/ui/cli_view.css");
var event = require("pilot/event");
var dom = require("pilot/dom");

dom.importCssString(editorCss);

var event = require("pilot/event");
var keys = require("pilot/keys");
var canon = require("pilot/canon");
var Status = require('pilot/types').Status;

var CliRequisition = require('cockpit/cli').CliRequisition;
var Hint = require('cockpit/cli').Hint;
var RequestView = require('cockpit/ui/request_view').RequestView;

var NO_HINT = new Hint(Status.VALID, '', 0, 0);

/**
 * On startup we need to:
 * 1. Add 3 sets of elements to the DOM for:
 * - command line output
 * - input hints
 * - completion
 * 2. Attach a set of events so the command line works
 */
exports.startup = function(data, reason) {
    var cli = new CliRequisition(data.env);
    var cliView = new CliView(cli, data.env);
    data.env.cli = cli;
};

/**
 * A class to handle the simplest UI implementation
 */
function CliView(cli, env) {
    cli.cliView = this;
    this.cli = cli;
    this.doc = document;
    this.win = dom.getParentWindow(this.doc);
    this.env = env;

    // TODO: we should have a better way to specify command lines???
    this.element = this.doc.getElementById('cockpitInput');
    if (!this.element) {
        // console.log('No element with an id of cockpit. Bailing on cli');
        return;
    }

    this.settings = env.settings;
    this.hintDirection = this.settings.getSetting('hintDirection');
    this.outputDirection = this.settings.getSetting('outputDirection');
    this.outputHeight = this.settings.getSetting('outputHeight');

    // If the requisition tells us something has changed, we use this to know
    // if we should ignore it
    this.isUpdating = false;

    this.createElements();
    this.update();
}
CliView.prototype = {
    /**
     * Create divs for completion, hints and output
     */
    createElements: function() {
        var input = this.element;

        this.element.spellcheck = false;

        this.output = this.doc.getElementById('cockpitOutput');
        this.popupOutput = (this.output == null);
        if (!this.output) {
            this.output = this.doc.createElement('div');
            this.output.id = 'cockpitOutput';
            this.output.className = 'cptOutput';
            input.parentNode.insertBefore(this.output, input.nextSibling);

            var setMaxOutputHeight = function() {
                this.output.style.maxHeight = this.outputHeight.get() + 'px';
            }.bind(this);
            this.outputHeight.addEventListener('change', setMaxOutputHeight);
            setMaxOutputHeight();
        }

        this.completer = this.doc.createElement('div');
        this.completer.className = 'cptCompletion VALID';

        this.completer.style.color = dom.computedStyle(input, "color");
        this.completer.style.fontSize = dom.computedStyle(input, "fontSize");
        this.completer.style.fontFamily = dom.computedStyle(input, "fontFamily");
        this.completer.style.fontWeight = dom.computedStyle(input, "fontWeight");
        this.completer.style.fontStyle = dom.computedStyle(input, "fontStyle");
        input.parentNode.insertBefore(this.completer, input.nextSibling);

        // Transfer background styling to the completer.
        this.completer.style.backgroundColor = input.style.backgroundColor;
        input.style.backgroundColor = 'transparent';

        this.hinter = this.doc.createElement('div');
        this.hinter.className = 'cptHints';
        input.parentNode.insertBefore(this.hinter, input.nextSibling);

        var resizer = this.resizer.bind(this);
        event.addListener(this.win, 'resize', resizer);
        this.hintDirection.addEventListener('change', resizer);
        this.outputDirection.addEventListener('change', resizer);
        resizer();

        canon.addEventListener('output',  function(ev) {
            new RequestView(ev.request, this);
        }.bind(this));
        event.addCommandKeyListener(input, this.onCommandKey.bind(this));
        event.addListener(input, 'keyup', this.onKeyUp.bind(this));

        // cursor position affects hint severity. TODO: shortcuts for speed
        event.addListener(input, 'mouseup', function(ev) {
            this.isUpdating = true;
            this.update();
            this.isUpdating = false;
        }.bind(this));

        this.cli.addEventListener('argumentChange', this.onArgChange.bind(this));

        event.addListener(input, "focus", function() {
            dom.addCssClass(this.output, "cptFocusPopup");
            dom.addCssClass(this.hinter, "cptFocusPopup");
        }.bind(this));

        function hideOutput() {
            dom.removeCssClass(this.output, "cptFocusPopup");
            dom.removeCssClass(this.hinter, "cptFocusPopup");
        };
        event.addListener(input, "blur", hideOutput.bind(this));
        hideOutput.call(this);
    },

    /**
     * We need to see the output of the latest command entered
     */
    scrollOutputToBottom: function() {
        // Certain browsers have a bug such that scrollHeight is too small
        // when content does not fill the client area of the element
        var scrollHeight = Math.max(this.output.scrollHeight, this.output.clientHeight);
        this.output.scrollTop = scrollHeight - this.output.clientHeight;
    },

    /**
     * To be called on window resize or any time we want to align the elements
     * with the input box.
     */
    resizer: function() {
        var rect = this.element.getClientRects()[0];

        this.completer.style.top = rect.top + 'px';
        var height = rect.bottom - rect.top;
        this.completer.style.height = height + 'px';
        this.completer.style.lineHeight = height + 'px';
        this.completer.style.left = rect.left + 'px';
        var width = rect.right - rect.left;
        this.completer.style.width = width + 'px';

        if (this.hintDirection.get() === 'below') {
            this.hinter.style.top = rect.bottom + 'px';
            this.hinter.style.bottom = 'auto';
        }
        else {
            this.hinter.style.top = 'auto';
            this.hinter.style.bottom = (this.doc.documentElement.clientHeight - rect.top) + 'px';
        }
        this.hinter.style.left = (rect.left + 30) + 'px';
        this.hinter.style.maxWidth = (width - 110) + 'px';

        if (this.popupOutput) {
            if (this.outputDirection.get() === 'below') {
                this.output.style.top = rect.bottom + 'px';
                this.output.style.bottom = 'auto';
            }
            else {
                this.output.style.top = 'auto';
                this.output.style.bottom = (this.doc.documentElement.clientHeight - rect.top) + 'px';
            }
            this.output.style.left = rect.left + 'px';
            this.output.style.width = (width - 80) + 'px';
        }
    },

    /**
     * Ensure that TAB isn't handled by the browser
     */
onCommandKey: function(ev, hashId, keyCode) {
        var stopEvent;
        if (keyCode === keys.TAB ||
                keyCode === keys.UP ||
                keyCode === keys.DOWN) {
            stopEvent = true;
        } else if (hashId != 0 || keyCode != 0) {
            stopEvent = canon.execKeyCommand(this.env, 'cli', hashId, keyCode);
        }
        stopEvent && event.stopEvent(ev);
    },

    /**
     * The main keyboard processing loop
     */
    onKeyUp: function(ev) {
        var handled;
        /*
        var handled = keyboardManager.processKeyEvent(ev, this, {
            isCommandLine: true, isKeyUp: true
        });
        */

        // RETURN does a special exec/highlight thing
        if (ev.keyCode === keys.RETURN) {
            var worst = this.cli.getWorstHint();
            // Deny RETURN unless the command might work
            if (worst.status === Status.VALID) {
                this.cli.exec();
                this.element.value = '';
            }
            else {
                // If we've denied RETURN because the command was not VALID,
                // select the part of the command line that is causing problems
                // TODO: if there are 2 errors are we picking the right one?
                dom.setSelectionStart(this.element, worst.start);
                dom.setSelectionEnd(this.element, worst.end);
            }
        }

        this.update();

        // Special actions which delegate to the assignment
        var current = this.cli.getAssignmentAt(dom.getSelectionStart(this.element));
        if (current) {
            // TAB does a special complete thing
            if (ev.keyCode === keys.TAB) {
                current.complete();
                this.update();
            }

            // UP/DOWN look for some history
            if (ev.keyCode === keys.UP) {
                current.increment();
                this.update();
            }
            if (ev.keyCode === keys.DOWN) {
                current.decrement();
                this.update();
            }
        }

        return handled;
    },

    /**
     * Actually parse the input and make sure we're all up to date
     */
    update: function() {
        this.isUpdating = true;
        var input = {
            typed: this.element.value,
            cursor: {
                start: dom.getSelectionStart(this.element),
                end: dom.getSelectionEnd(this.element.selectionEnd)
            }
        };
        this.cli.update(input);

        var display = this.cli.getAssignmentAt(input.cursor.start).getHint();

        // 1. Update the completer with prompt/error marker/TAB info
        dom.removeCssClass(this.completer, Status.VALID.toString());
        dom.removeCssClass(this.completer, Status.INCOMPLETE.toString());
        dom.removeCssClass(this.completer, Status.INVALID.toString());

        var completion = '<span class="cptPrompt">&gt;</span> ';
        if (this.element.value.length > 0) {
            var scores = this.cli.getInputStatusMarkup();
            completion += this.markupStatusScore(scores);
        }

        // Display the "-> prediction" at the end of the completer
        if (this.element.value.length > 0 &&
                display.predictions && display.predictions.length > 0) {
            var tab = display.predictions[0];
            completion += ' &nbsp;&#x21E5; ' + (tab.name ? tab.name : tab);
        }
        this.completer.innerHTML = completion;
        dom.addCssClass(this.completer, this.cli.getWorstHint().status.toString());

        // 2. Update the hint element
        var hint = '';
        if (this.element.value.length !== 0) {
            hint += display.message;
            if (display.predictions && display.predictions.length > 0) {
                hint += ': [ ';
                display.predictions.forEach(function(prediction) {
                    hint += (prediction.name ? prediction.name : prediction);
                    hint += ' | ';
                }, this);
                hint = hint.replace(/\| $/, ']');
            }
        }

        this.hinter.innerHTML = hint;
        if (hint.length === 0) {
            dom.addCssClass(this.hinter, 'cptNoPopup');
        }
        else {
            dom.removeCssClass(this.hinter, 'cptNoPopup');
        }

        this.isUpdating = false;
    },

    /**
     * Markup an array of Status values with spans
     */
    markupStatusScore: function(scores) {
        var completion = '';
        // Create mark-up
        var i = 0;
        var lastStatus = -1;
        while (true) {
            if (lastStatus !== scores[i]) {
                completion += '<span class=' + scores[i].toString() + '>';
                lastStatus = scores[i];
            }
            completion += this.element.value[i];
            i++;
            if (i === this.element.value.length) {
                completion += '</span>';
                break;
            }
            if (lastStatus !== scores[i]) {
                completion += '</span>';
            }
        }

        return completion;
    },

    /**
     * Update the input element to reflect the changed argument
     */
    onArgChange: function(ev) {
        if (this.isUpdating) {
            return;
        }

        var prefix = this.element.value.substring(0, ev.argument.start);
        var suffix = this.element.value.substring(ev.argument.end);
        var insert = typeof ev.text === 'string' ? ev.text : ev.text.name;
        this.element.value = prefix + insert + suffix;
        // Fix the cursor.
        var insertEnd = (prefix + insert).length;
        this.element.selectionStart = insertEnd;
        this.element.selectionEnd = insertEnd;
    }
};
exports.CliView = CliView;


});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Skywriter.
 *
 * The Initial Developer of the Original Code is
 * Mozilla.
 * Portions created by the Initial Developer are Copyright (C) 2009
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Joe Walker (jwalker@mozilla.com)
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('cockpit/ui/request_view', ['require', 'exports', 'module' , 'pilot/dom', 'pilot/event', 'text!cockpit/ui/request_view.html', 'pilot/domtemplate', 'text!cockpit/ui/request_view.css'], function(require, exports, module) {

var dom = require("pilot/dom");
var event = require("pilot/event");
var requestViewHtml = require("text!cockpit/ui/request_view.html");
var Templater = require("pilot/domtemplate").Templater;

var requestViewCss = require("text!cockpit/ui/request_view.css");
dom.importCssString(requestViewCss);

/**
 * Pull the HTML into the DOM, but don't add it to the document
 */
var templates = document.createElement('div');
templates.innerHTML = requestViewHtml;
var row = templates.querySelector('.cptRow');

/**
 * Work out the path for images.
 * TODO: This should probably live in some utility area somewhere
 */
function imageUrl(path) {
    var dataUrl;
    try {
        dataUrl = require('text!cockpit/ui/' + path);
    } catch (e) { }
    if (dataUrl) {
        return dataUrl;
    }

    var filename = module.id.split('/').pop() + '.js';
    var imagePath;

    if (module.uri.substr(-filename.length) !== filename) {
        console.error('Can\'t work out path from module.uri/module.id');
        return path;
    }

    if (module.uri) {
        var end = module.uri.length - filename.length - 1;
        return module.uri.substr(0, end) + "/" + path;
    }

    return filename + path;
}


/**
 * Adds a row to the CLI output display
 */
function RequestView(request, cliView) {
    this.request = request;
    this.cliView = cliView;
    this.imageUrl = imageUrl;

    // Elements attached to this by the templater. For info only
    this.rowin = null;
    this.rowout = null;
    this.output = null;
    this.hide = null;
    this.show = null;
    this.duration = null;
    this.throb = null;

    new Templater().processNode(row.cloneNode(true), this);

    this.cliView.output.appendChild(this.rowin);
    this.cliView.output.appendChild(this.rowout);

    this.request.addEventListener('output', this.onRequestChange.bind(this));
};

RequestView.prototype = {
    /**
     * A single click on an invocation line in the console copies the command to
     * the command line
     */
    copyToInput: function() {
        this.cliView.element.value = this.request.typed;
    },

    /**
     * A double click on an invocation line in the console executes the command
     */
    executeRequest: function(ev) {
        this.cliView.cli.update({
            typed: this.request.typed,
            cursor: { start:0, end:0 }
        });
        this.cliView.cli.exec();
    },

    hideOutput: function(ev) {
        this.output.style.display = 'none';
        dom.addCssClass(this.hide, 'cmd_hidden');
        dom.removeCssClass(this.show, 'cmd_hidden');

        event.stopPropagation(ev);
    },

    showOutput: function(ev) {
        this.output.style.display = 'block';
        dom.removeCssClass(this.hide, 'cmd_hidden');
        dom.addCssClass(this.show, 'cmd_hidden');

        event.stopPropagation(ev);
    },

    remove: function(ev) {
        this.cliView.output.removeChild(this.rowin);
        this.cliView.output.removeChild(this.rowout);
        event.stopPropagation(ev);
    },

    onRequestChange: function(ev) {
        this.duration.innerHTML = this.request.duration ?
            'completed in ' + (this.request.duration / 1000) + ' sec ' :
            '';

        this.output.innerHTML = '';
        this.request.outputs.forEach(function(output) {
            var node;
            if (typeof output == 'string') {
                node = document.createElement('p');
                node.innerHTML = output;
            } else {
                node = output;
            }
            this.output.appendChild(node);
        }, this);
        this.cliView.scrollOutputToBottom();

        dom.setCssClass(this.output, 'cmd_error', this.request.error);

        this.throb.style.display = this.request.completed ? 'none' : 'block';
    }
};
exports.RequestView = RequestView;


});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is DomTemplate.
 *
 * The Initial Developer of the Original Code is Mozilla.
 * Portions created by the Initial Developer are Copyright (C) 2009
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Joe Walker (jwalker@mozilla.com) (original author)
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('pilot/domtemplate', ['require', 'exports', 'module' ], function(require, exports, module) {


// WARNING: do not 'use_strict' without reading the notes in envEval;

/**
 * A templater that allows one to quickly template DOM nodes.
 */
function Templater() {
  this.scope = [];
};

/**
 * Recursive function to walk the tree processing the attributes as it goes.
 * @param node the node to process. If you pass a string in instead of a DOM
 * element, it is assumed to be an id for use with document.getElementById()
 * @param data the data to use for node processing.
 */
Templater.prototype.processNode = function(node, data) {
  if (typeof node === 'string') {
    node = document.getElementById(node);
  }
  if (data === null || data === undefined) {
    data = {};
  }
  this.scope.push(node.nodeName + (node.id ? '#' + node.id : ''));
  try {
    // Process attributes
    if (node.attributes && node.attributes.length) {
      // We need to handle 'foreach' and 'if' first because they might stop
      // some types of processing from happening, and foreach must come first
      // because it defines new data on which 'if' might depend.
      if (node.hasAttribute('foreach')) {
        this.processForEach(node, data);
        return;
      }
      if (node.hasAttribute('if')) {
        if (!this.processIf(node, data)) {
          return;
        }
      }
      // Only make the node available once we know it's not going away
      data.__element = node;
      // It's good to clean up the attributes when we've processed them,
      // but if we do it straight away, we mess up the array index
      var attrs = Array.prototype.slice.call(node.attributes);
      for (var i = 0; i < attrs.length; i++) {
        var value = attrs[i].value;
        var name = attrs[i].name;
        this.scope.push(name);
        try {
          if (name === 'save') {
            // Save attributes are a setter using the node
            value = this.stripBraces(value);
            this.property(value, data, node);
            node.removeAttribute('save');
          } else if (name.substring(0, 2) === 'on') {
            // Event registration relies on property doing a bind
            value = this.stripBraces(value);
            var func = this.property(value, data);
            if (typeof func !== 'function') {
              this.handleError('Expected ' + value +
                ' to resolve to a function, but got ' + typeof func);
            }
            node.removeAttribute(name);
            var capture = node.hasAttribute('capture' + name.substring(2));
            node.addEventListener(name.substring(2), func, capture);
            if (capture) {
              node.removeAttribute('capture' + name.substring(2));
            }
          } else {
            // Replace references in all other attributes
            var self = this;
            var newValue = value.replace(/\$\{[^}]*\}/g, function(path) {
              return self.envEval(path.slice(2, -1), data, value);
            });
            // Remove '_' prefix of attribute names so the DOM won't try
            // to use them before we've processed the template
            if (name.charAt(0) === '_') {
              node.removeAttribute(name);
              node.setAttribute(name.substring(1), newValue);
            } else if (value !== newValue) {
              attrs[i].value = newValue;
            }
          }
        } finally {
          this.scope.pop();
        }
      }
    }

    // Loop through our children calling processNode. First clone them, so the
    // set of nodes that we visit will be unaffected by additions or removals.
    var childNodes = Array.prototype.slice.call(node.childNodes);
    for (var j = 0; j < childNodes.length; j++) {
      this.processNode(childNodes[j], data);
    }

    if (node.nodeType === Node.TEXT_NODE) {
      this.processTextNode(node, data);
    }
  } finally {
    this.scope.pop();
  }
};

/**
 * Handle <x if="${...}">
 * @param node An element with an 'if' attribute
 * @param data The data to use with envEval
 * @returns true if processing should continue, false otherwise
 */
Templater.prototype.processIf = function(node, data) {
  this.scope.push('if');
  try {
    var originalValue = node.getAttribute('if');
    var value = this.stripBraces(originalValue);
    var recurse = true;
    try {
      var reply = this.envEval(value, data, originalValue);
      recurse = !!reply;
    } catch (ex) {
      this.handleError('Error with \'' + value + '\'', ex);
      recurse = false;
    }
    if (!recurse) {
      node.parentNode.removeChild(node);
    }
    node.removeAttribute('if');
    return recurse;
  } finally {
    this.scope.pop();
  }
};

/**
 * Handle <x foreach="param in ${array}"> and the special case of
 * <loop foreach="param in ${array}">
 * @param node An element with a 'foreach' attribute
 * @param data The data to use with envEval
 */
Templater.prototype.processForEach = function(node, data) {
  this.scope.push('foreach');
  try {
    var originalValue = node.getAttribute('foreach');
    var value = originalValue;

    var paramName = 'param';
    if (value.charAt(0) === '$') {
      // No custom loop variable name. Use the default: 'param'
      value = this.stripBraces(value);
    } else {
      // Extract the loop variable name from 'NAME in ${ARRAY}'
      var nameArr = value.split(' in ');
      paramName = nameArr[0].trim();
      value = this.stripBraces(nameArr[1].trim());
    }
    node.removeAttribute('foreach');
    try {
      var self = this;
      // Process a single iteration of a loop
      var processSingle = function(member, clone, ref) {
        ref.parentNode.insertBefore(clone, ref);
        data[paramName] = member;
        self.processNode(clone, data);
        delete data[paramName];
      };

      // processSingle is no good for <loop> nodes where we want to work on
      // the childNodes rather than the node itself
      var processAll = function(scope, member) {
        self.scope.push(scope);
        try {
          if (node.nodeName === 'LOOP') {
            for (var i = 0; i < node.childNodes.length; i++) {
              var clone = node.childNodes[i].cloneNode(true);
              processSingle(member, clone, node);
            }
          } else {
            var clone = node.cloneNode(true);
            clone.removeAttribute('foreach');
            processSingle(member, clone, node);
          }
        } finally {
          self.scope.pop();
        }
      };

      var reply = this.envEval(value, data, originalValue);
      if (Array.isArray(reply)) {
        reply.forEach(function(data, i) {
          processAll('' + i, data);
        }, this);
      } else {
        for (var param in reply) {
          if (reply.hasOwnProperty(param)) {
            processAll(param, param);
          }
        }
      }
      node.parentNode.removeChild(node);
    } catch (ex) {
      this.handleError('Error with \'' + value + '\'', ex);
    }
  } finally {
    this.scope.pop();
  }
};

/**
 * Take a text node and replace it with another text node with the ${...}
 * sections parsed out. We replace the node by altering node.parentNode but
 * we could probably use a DOM Text API to achieve the same thing.
 * @param node The Text node to work on
 * @param data The data to use in calls to envEval
 */
Templater.prototype.processTextNode = function(node, data) {
  // Replace references in other attributes
  var value = node.data;
  // We can't use the string.replace() with function trick (see generic
  // attribute processing in processNode()) because we need to support
  // functions that return DOM nodes, so we can't have the conversion to a
  // string.
  // Instead we process the string as an array of parts. In order to split
  // the string up, we first replace '${' with '\uF001$' and '}' with '\uF002'
  // We can then split using \uF001 or \uF002 to get an array of strings
  // where scripts are prefixed with $.
  // \uF001 and \uF002 are just unicode chars reserved for private use.
  value = value.replace(/\$\{([^}]*)\}/g, '\uF001$$$1\uF002');
  var parts = value.split(/\uF001|\uF002/);
  if (parts.length > 1) {
    parts.forEach(function(part) {
      if (part === null || part === undefined || part === '') {
        return;
      }
      if (part.charAt(0) === '$') {
        part = this.envEval(part.slice(1), data, node.data);
      }
      // It looks like this was done a few lines above but see envEval
      if (part === null) {
        part = "null";
      }
      if (part === undefined) {
        part = "undefined";
      }
      // if (isDOMElement(part)) { ... }
      if (typeof part.cloneNode !== 'function') {
        part = node.ownerDocument.createTextNode(part.toString());
      }
      node.parentNode.insertBefore(part, node);
    }, this);
    node.parentNode.removeChild(node);
  }
};

/**
 * Warn of string does not begin '${' and end '}'
 * @param str the string to check.
 * @return The string stripped of ${ and }, or untouched if it does not match
 */
Templater.prototype.stripBraces = function(str) {
  if (!str.match(/\$\{.*\}/g)) {
    this.handleError('Expected ' + str + ' to match ${...}');
    return str;
  }
  return str.slice(2, -1);
};

/**
 * Combined getter and setter that works with a path through some data set.
 * For example:
 * <ul>
 * <li>property('a.b', { a: { b: 99 }}); // returns 99
 * <li>property('a', { a: { b: 99 }}); // returns { b: 99 }
 * <li>property('a', { a: { b: 99 }}, 42); // returns 99 and alters the
 * input data to be { a: { b: 42 }}
 * </ul>
 * @param path An array of strings indicating the path through the data, or
 * a string to be cut into an array using <tt>split('.')</tt>
 * @param data An object to look in for the <tt>path</tt> argument
 * @param newValue (optional) If defined, this value will replace the
 * original value for the data at the path specified.
 * @return The value pointed to by <tt>path</tt> before any
 * <tt>newValue</tt> is applied.
 */
Templater.prototype.property = function(path, data, newValue) {
  this.scope.push(path);
  try {
    if (typeof path === 'string') {
      path = path.split('.');
    }
    var value = data[path[0]];
    if (path.length === 1) {
      if (newValue !== undefined) {
        data[path[0]] = newValue;
      }
      if (typeof value === 'function') {
        return function() {
          return value.apply(data, arguments);
        };
      }
      return value;
    }
    if (!value) {
      this.handleError('Can\'t find path=' + path);
      return null;
    }
    return this.property(path.slice(1), value, newValue);
  } finally {
    this.scope.pop();
  }
};

/**
 * Like eval, but that creates a context of the variables in <tt>env</tt> in
 * which the script is evaluated.
 * WARNING: This script uses 'with' which is generally regarded to be evil.
 * The alternative is to create a Function at runtime that takes X parameters
 * according to the X keys in the env object, and then call that function using
 * the values in the env object. This is likely to be slow, but workable.
 * @param script The string to be evaluated.
 * @param env The environment in which to eval the script.
 * @param context Optional debugging string in case of failure
 * @return The return value of the script, or the error message if the script
 * execution failed.
 */
Templater.prototype.envEval = function(script, env, context) {
  with (env) {
    try {
      this.scope.push(context);
      return eval(script);
    } catch (ex) {
      this.handleError('Template error evaluating \'' + script + '\'', ex);
      return script;
    } finally {
      this.scope.pop();
    }
  }
};

/**
 * A generic way of reporting errors, for easy overloading in different
 * environments.
 * @param message the error message to report.
 * @param ex optional associated exception.
 */
Templater.prototype.handleError = function(message, ex) {
  this.logError(message);
  this.logError('In: ' + this.scope.join(' > '));
  if (ex) {
    this.logError(ex);
  }
};


/**
 * A generic way of reporting errors, for easy overloading in different
 * environments.
 * @param message the error message to report.
 */
Templater.prototype.logError = function(message) {
  window.console && window.console.log && console.log(message);
};

exports.Templater = Templater;


});
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Skywriter.
 *
 * The Initial Developer of the Original Code is
 * Mozilla.
 * Portions created by the Initial Developer are Copyright (C) 2009
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Skywriter Team (skywriter@mozilla.com)
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

define('cockpit/commands/basic', ['require', 'exports', 'module' , 'pilot/canon'], function(require, exports, module) {


var canon = require('pilot/canon');

/**
 * '!' command
 */
var bangCommandSpec = {
    name: 'sh',
    description: 'Execute a system command (requires server support)',
    params: [
        {
            name: 'command',
            type: 'text',
            description: 'The string to send to the os shell.'
        }
    ],
    exec: function(env, args, request) {
        var req = new XMLHttpRequest();
        req.open('GET', '/exec?args=' + args.command, true);
        req.onreadystatechange = function(ev) {
          if (req.readyState == 4) {
            if (req.status == 200) {
              request.done('<pre>' + req.responseText + '</pre>');
            }
          }
        };
        req.send(null);
    }
};

var canon = require('pilot/canon');

exports.startup = function(data, reason) {
    canon.addCommand(bangCommandSpec);
};

exports.shutdown = function(data, reason) {
    canon.removeCommand(bangCommandSpec);
};


});
define("text!cockpit/ui/cli_view.css", [], "" +
  "#cockpitInput { padding-left: 16px; }" +
  "" +
  ".cptOutput { overflow: auto; position: absolute; z-index: 999; display: none; }" +
  "" +
  ".cptCompletion { padding: 0; position: absolute; z-index: -1000; }" +
  ".cptCompletion.VALID { background: #FFF; }" +
  ".cptCompletion.INCOMPLETE { background: #DDD; }" +
  ".cptCompletion.INVALID { background: #DDD; }" +
  ".cptCompletion span { color: #FFF; }" +
  ".cptCompletion span.INCOMPLETE { color: #DDD; border-bottom: 2px dotted #F80; }" +
  ".cptCompletion span.INVALID { color: #DDD; border-bottom: 2px dotted #F00; }" +
  "span.cptPrompt { color: #66F; font-weight: bold; }" +
  "" +
  "" +
  ".cptHints {" +
  "  color: #000;" +
  "  position: absolute;" +
  "  border: 1px solid rgba(230, 230, 230, 0.8);" +
  "  background: rgba(250, 250, 250, 0.8);" +
  "  -moz-border-radius-topleft: 10px;" +
  "  -moz-border-radius-topright: 10px;" +
  "  border-top-left-radius: 10px; border-top-right-radius: 10px;" +
  "  z-index: 1000;" +
  "  padding: 8px;" +
  "  display: none;" +
  "}" +
  "" +
  ".cptFocusPopup { display: block; }" +
  ".cptFocusPopup.cptNoPopup { display: none; }" +
  "" +
  ".cptHints ul { margin: 0; padding: 0 15px; }" +
  "" +
  ".cptGt { font-weight: bold; font-size: 120%; }" +
  "");

define("text!cockpit/ui/request_view.css", [], "" +
  ".cptRowIn {" +
  "  display: box; display: -moz-box; display: -webkit-box;" +
  "  box-orient: horizontal; -moz-box-orient: horizontal; -webkit-box-orient: horizontal;" +
  "  box-align: center; -moz-box-align: center; -webkit-box-align: center;" +
  "  color: #333;" +
  "  background-color: #EEE;" +
  "  width: 100%;" +
  "  font-family: consolas, courier, monospace;" +
  "}" +
  ".cptRowIn > * { padding-left: 2px; padding-right: 2px; }" +
  ".cptRowIn > img { cursor: pointer; }" +
  ".cptHover { display: none; }" +
  ".cptRowIn:hover > .cptHover { display: block; }" +
  ".cptRowIn:hover > .cptHover.cptHidden { display: none; }" +
  ".cptOutTyped {" +
  "  box-flex: 1; -moz-box-flex: 1; -webkit-box-flex: 1;" +
  "  font-weight: bold; color: #000; font-size: 120%;" +
  "}" +
  ".cptRowOutput { padding-left: 10px; line-height: 1.2em; }" +
  ".cptRowOutput strong," +
  ".cptRowOutput b," +
  ".cptRowOutput th," +
  ".cptRowOutput h1," +
  ".cptRowOutput h2," +
  ".cptRowOutput h3 { color: #000; }" +
  ".cptRowOutput a { font-weight: bold; color: #666; text-decoration: none; }" +
  ".cptRowOutput a: hover { text-decoration: underline; cursor: pointer; }" +
  ".cptRowOutput input[type=password]," +
  ".cptRowOutput input[type=text]," +
  ".cptRowOutput textarea {" +
  "  color: #000; font-size: 120%;" +
  "  background: transparent; padding: 3px;" +
  "  border-radius: 5px; -moz-border-radius: 5px; -webkit-border-radius: 5px;" +
  "}" +
  ".cptRowOutput table," +
  ".cptRowOutput td," +
  ".cptRowOutput th { border: 0; padding: 0 2px; }" +
  ".cptRowOutput .right { text-align: right; }" +
  "");

define("text!cockpit/ui/request_view.html", [], "" +
  "<div class=cptRow>" +
  "  <!-- The div for the input (i.e. what was typed) -->" +
  "  <div class=\"cptRowIn\" save=\"${rowin}\"" +
  "      onclick=\"${copyToInput}\"" +
  "      ondblclick=\"${executeRequest}\">" +
  "" +
  "    <!-- What the user actually typed -->" +
  "    <div class=\"cptGt\">&gt; </div>" +
  "    <div class=\"cptOutTyped\">${request.typed}</div>" +
  "" +
  "    <!-- The extra details that appear on hover -->" +
  "    <div class=cptHover save=\"${duration}\"></div>" +
  "    <img class=cptHover onclick=\"${hideOutput}\" save=\"${hide}\"" +
  "        alt=\"Hide command output\" _src=\"${imageUrl('images/minus.png')}\"/>" +
  "    <img class=\"cptHover cptHidden\" onclick=\"${showOutput}\" save=\"${show}\"" +
  "        alt=\"Show command output\" _src=\"${imageUrl('images/plus.png')}\"/>" +
  "    <img class=cptHover onclick=\"${remove}\"" +
  "        alt=\"Remove this command from the history\"" +
  "        _src=\"${imageUrl('images/closer.png')}\"/>" +
  "" +
  "  </div>" +
  "" +
  "  <!-- The div for the command output -->" +
  "  <div class=\"cptRowOut\" save=\"${rowout}\">" +
  "    <div class=\"cptRowOutput\" save=\"${output}\"></div>" +
  "    <img _src=\"${imageUrl('images/throbber.gif')}\" save=\"${throb}\"/>" +
  "  </div>" +
  "</div>" +
  "");

define("text!cockpit/ui/images/closer.png", [], "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAYAAAAfSC3RAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAj9JREFUeNp0ks+LUlEUx7/vV1o8Z8wUx3IEHcQmiBiQlomjRNCiZpEuEqF/oEUwq/6EhvoHggmRcJUQBM1CRJAW0aLIaGQimZJxJsWxyV/P9/R1zzWlFl04vPvOPZ9z7rnnK5imidmKRCIq+zxgdoPZ1T/ut8xeM3tcKpW6s1hhBkaj0Qj7bDebTX+324WmadxvsVigqipcLleN/d4rFoulORiLxTZY8ItOp8MBCpYkiYPj8Xjus9vtlORWoVB4KcTjcQc732dLpSRXvCZaAws6Q4WDdqsO52kNH+oCRFGEz+f7ydwBKRgMPmTXi49GI1x2D/DsznesB06ws2eDbI7w9HYN6bVjvGss4KAjwDAMq81mM2SW5Wa/3weBbz42UL9uYnVpiO2Nr9ANHSGXib2Wgm9tCYIggGKJEVkvlwgi5/FQRmTLxO6hgJVzI1x0T/fJrBtHJxPeL6tI/fsZLA6ot8lkQi8HRVbw94gkWYI5MaHrOjcCGSNRxZosy9y5cErDzn0Dqx7gcwO8WtBp4PndI35GMYqiUMUvBL5yOBz8yRfFNpbPmqgcCFh/IuHa1nR/YXGM8+oUpFhihEQiwcdRLpfVRqOBtWXWq34Gra6AXq8Hp2piZcmKT4cKnE4nwuHwdByVSmWQz+d32WCTlHG/qaHHREN9kgi0sYQfv0R4PB4EAgESQDKXy72fSy6VSnHJVatVf71eR7vd5n66mtfrRSgU4pLLZrOlf7RKK51Ok8g3/yPyR5lMZi7y3wIMAME4EigHWgKnAAAAAElFTkSuQmCC");

define("text!cockpit/ui/images/dot_clear.gif", [], "data:image/gif;base64,R0lGODlhAQABAID/AMDAwAAAACH5BAEAAAAALAAAAAABAAEAAAEBMgA7");

define("text!cockpit/ui/images/minus.png", [], "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAYAAAAfSC3RAAAAAXNSR0IArs4c6QAAAAZiS0dEANIA0gDS7KbF4AAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9kFGw4xMrIJw5EAAAHcSURBVCjPhZIxSxtxGMZ/976XhJA/RA5EAyJcFksnp64hjUPBoXRyCYLQTyD0UxScu0nFwalCQSgFCVk7dXAwUAiBDA2RO4W7yN1x9+9gcyhU+pteHt4H3pfncay1LOl0OgY4BN4Ar/7KP4BvwNFwOIyWu87S2O12O8DxfD73oygiSRIAarUaxhhWV1fHwMFgMBiWxl6v9y6Koi+3t7ckSUKtVkNVAcjzvNRWVlYwxry9vLz86uzs7HjAZDKZGGstjUaDfxHHMSLC5ubmHdB2VfVwNpuZ5clxHPMcRVFwc3PTXFtbO3RFZHexWJCmabnweAaoVqvlv4vFAhHZdVX1ZZqmOI5DURR8fz/lxbp9Yrz+7bD72SfPcwBU1XdF5N5aWy2KgqIoeBzPEnWVLMseYnAcRERdVR27rrsdxzGqyutP6898+GBsNBqo6i9XVS88z9sOggAR4X94noeqXoiIHPm+H9XrdYIgIAxDwjAkTVPCMESzBy3LMprNJr7v34nIkV5dXd2fn59fG2P2siwjSRIqlQrWWlSVJFcqlQqtVot2u40xZu/s7OxnWbl+v98BjkejkT+dTgmCoDxtY2ODra2tMXBweno6fNJVgP39fQN8eKbkH09OTsqS/wHFRdHPfTSfjwAAAABJRU5ErkJggg==");

define("text!cockpit/ui/images/pinaction.png", [], "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAC7mlDQ1BJQ0MgUHJvZmlsZQAAeAGFVM9rE0EU/jZuqdAiCFprDrJ4kCJJWatoRdQ2/RFiawzbH7ZFkGQzSdZuNuvuJrWliOTi0SreRe2hB/+AHnrwZC9KhVpFKN6rKGKhFy3xzW5MtqXqwM5+8943731vdt8ADXLSNPWABOQNx1KiEWlsfEJq/IgAjqIJQTQlVdvsTiQGQYNz+Xvn2HoPgVtWw3v7d7J3rZrStpoHhP1A4Eea2Sqw7xdxClkSAog836Epx3QI3+PY8uyPOU55eMG1Dys9xFkifEA1Lc5/TbhTzSXTQINIOJT1cVI+nNeLlNcdB2luZsbIEL1PkKa7zO6rYqGcTvYOkL2d9H5Os94+wiHCCxmtP0a4jZ71jNU/4mHhpObEhj0cGDX0+GAVtxqp+DXCFF8QTSeiVHHZLg3xmK79VvJKgnCQOMpkYYBzWkhP10xu+LqHBX0m1xOv4ndWUeF5jxNn3tTd70XaAq8wDh0MGgyaDUhQEEUEYZiwUECGPBoxNLJyPyOrBhuTezJ1JGq7dGJEsUF7Ntw9t1Gk3Tz+KCJxlEO1CJL8Qf4qr8lP5Xn5y1yw2Fb3lK2bmrry4DvF5Zm5Gh7X08jjc01efJXUdpNXR5aseXq8muwaP+xXlzHmgjWPxHOw+/EtX5XMlymMFMXjVfPqS4R1WjE3359sfzs94i7PLrXWc62JizdWm5dn/WpI++6qvJPmVflPXvXx/GfNxGPiKTEmdornIYmXxS7xkthLqwviYG3HCJ2VhinSbZH6JNVgYJq89S9dP1t4vUZ/DPVRlBnM0lSJ93/CKmQ0nbkOb/qP28f8F+T3iuefKAIvbODImbptU3HvEKFlpW5zrgIXv9F98LZua6N+OPwEWDyrFq1SNZ8gvAEcdod6HugpmNOWls05Uocsn5O66cpiUsxQ20NSUtcl12VLFrOZVWLpdtiZ0x1uHKE5QvfEp0plk/qv8RGw/bBS+fmsUtl+ThrWgZf6b8C8/UXAeIuJAAAACXBIWXMAAAsTAAALEwEAmpwYAAAClklEQVQ4EX1TXUhUQRQ+Z3Zmd+9uN1q2P3UpZaEwcikKekkqLKggKHJ96MHe9DmLkCDa9U198Id8kErICmIlRAN96UdE6QdBW/tBA5Uic7E0zN297L17p5mb1zYjD3eYc+d83zlnON8g5xzWNUSEdUBkHTJasRWySPP7fw3hfwkk2GoNsc0vOaJRHo1GV/GiMctkTIJRFlpZli8opK+htmf83gXeG63oteOtra0u25e7TYJIJELb26vYCACTgUe1lXV86BTn745l+MsyHqs53S/Aq4VEUa9Y6ko14eYY4u3AyM3HYwdKU35DZyblGR2+qq6W0X2Nnh07xynnVYpHORx/E1/GvvqaAZUayjMjdM2f/Lgr5E+fV93zR4u3zKCLughsZqKwAzAxaz6dPY6JgjLUF+eSP5OpjmAw2E8DvldHSvJMKPg08aRor1tc4BuALu6mOwGWdQC3mKIqRsC8mKd8wYfD78/earzSYzdMDW9QgKb0Is8CBY1mQXOiaXAHEpMDE5XTJqIq4EiyxUqKlpfkF0pyV1OTAoFAhmTmyCCoDsZNZvIkUjELQpipo0sQqYZAswZHwsEEE10M0pq2SSZY9HqNcDicJcNTpBvQJz40UbSOTh1B8bDpuY0w9Hb3kkn9lPAlBLfhfD39XTtX/blFJqiqrjbkTi63Hbofj2uL4GMsmzFgbDJ/vmMgv/lB4syJ0oXO7d3j++vio6GFsYmD6cHJreWc3/jRVVHhsOYvM8iZ36mtjPDBk/xDZE8CoHlbrlAssbTxDdDJvdb536L7I6S7Vy++6Gi4Xi9BsUthJRaLOYSPz4XALKI4j4iObd/e5UtDKUjZzYyYRyGAJv01Zj8kC5cbs5WY83hQnv0DzCXl+r8APElkq0RU6oMAAAAASUVORK5CYII=");

define("text!cockpit/ui/images/pinin.png", [], "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAC7mlDQ1BJQ0MgUHJvZmlsZQAAeAGFVM9rE0EU/jZuqdAiCFprDrJ4kCJJWatoRdQ2/RFiawzbH7ZFkGQzSdZuNuvuJrWliOTi0SreRe2hB/+AHnrwZC9KhVpFKN6rKGKhFy3xzW5MtqXqwM5+8943731vdt8ADXLSNPWABOQNx1KiEWlsfEJq/IgAjqIJQTQlVdvsTiQGQYNz+Xvn2HoPgVtWw3v7d7J3rZrStpoHhP1A4Eea2Sqw7xdxClkSAog836Epx3QI3+PY8uyPOU55eMG1Dys9xFkifEA1Lc5/TbhTzSXTQINIOJT1cVI+nNeLlNcdB2luZsbIEL1PkKa7zO6rYqGcTvYOkL2d9H5Os94+wiHCCxmtP0a4jZ71jNU/4mHhpObEhj0cGDX0+GAVtxqp+DXCFF8QTSeiVHHZLg3xmK79VvJKgnCQOMpkYYBzWkhP10xu+LqHBX0m1xOv4ndWUeF5jxNn3tTd70XaAq8wDh0MGgyaDUhQEEUEYZiwUECGPBoxNLJyPyOrBhuTezJ1JGq7dGJEsUF7Ntw9t1Gk3Tz+KCJxlEO1CJL8Qf4qr8lP5Xn5y1yw2Fb3lK2bmrry4DvF5Zm5Gh7X08jjc01efJXUdpNXR5aseXq8muwaP+xXlzHmgjWPxHOw+/EtX5XMlymMFMXjVfPqS4R1WjE3359sfzs94i7PLrXWc62JizdWm5dn/WpI++6qvJPmVflPXvXx/GfNxGPiKTEmdornIYmXxS7xkthLqwviYG3HCJ2VhinSbZH6JNVgYJq89S9dP1t4vUZ/DPVRlBnM0lSJ93/CKmQ0nbkOb/qP28f8F+T3iuefKAIvbODImbptU3HvEKFlpW5zrgIXv9F98LZua6N+OPwEWDyrFq1SNZ8gvAEcdod6HugpmNOWls05Uocsn5O66cpiUsxQ20NSUtcl12VLFrOZVWLpdtiZ0x1uHKE5QvfEp0plk/qv8RGw/bBS+fmsUtl+ThrWgZf6b8C8/UXAeIuJAAAACXBIWXMAAAsTAAALEwEAmpwYAAABZ0lEQVQ4Ea2TPUsDQRCGZ89Eo4FACkULEQs1CH4Uamfjn7GxEYJFIFXgChFsbPwzNnZioREkaiHBQtEiEEiMRm/dZ8OEGAxR4sBxx877Pju7M2estTJIxLrNuVwuMxQEx0ZkzcFHyRtjXt02559RtB2GYanTYzoryOfz+6l4Nbszf2niwffKmpGRo9sVW22mDgqFwp5C2gDMm+P32a3JB1N+n5JifUGeP9JeNxGryPLYjcwMP8rJ07Q9fZltQzyAstOJ2vVu5sKc1ZZkRBrOcKeb+HexPidvkpCN5JUcllZtpZFc5DgBWc5M2eysZuMuofMBSA4NWjx4PUCsXefMlI0QY3ewRg4NWi4ZTQsgrjYXema+e4VqtEMK6KXvu+4B9Bklt90vVKMeD2BI6DOt4rZ/Gk7WyKFBi4fNPIAJY0joM61SCCZ9tI1o0OIB8D+DBIkYaJRbCBH9mZgNt+bb++ufSSF/eX8BYcDeAzuQJVUAAAAASUVORK5CYII=");

define("text!cockpit/ui/images/pinout.png", [], "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAC7mlDQ1BJQ0MgUHJvZmlsZQAAeAGFVM9rE0EU/jZuqdAiCFprDrJ4kCJJWatoRdQ2/RFiawzbH7ZFkGQzSdZuNuvuJrWliOTi0SreRe2hB/+AHnrwZC9KhVpFKN6rKGKhFy3xzW5MtqXqwM5+8943731vdt8ADXLSNPWABOQNx1KiEWlsfEJq/IgAjqIJQTQlVdvsTiQGQYNz+Xvn2HoPgVtWw3v7d7J3rZrStpoHhP1A4Eea2Sqw7xdxClkSAog836Epx3QI3+PY8uyPOU55eMG1Dys9xFkifEA1Lc5/TbhTzSXTQINIOJT1cVI+nNeLlNcdB2luZsbIEL1PkKa7zO6rYqGcTvYOkL2d9H5Os94+wiHCCxmtP0a4jZ71jNU/4mHhpObEhj0cGDX0+GAVtxqp+DXCFF8QTSeiVHHZLg3xmK79VvJKgnCQOMpkYYBzWkhP10xu+LqHBX0m1xOv4ndWUeF5jxNn3tTd70XaAq8wDh0MGgyaDUhQEEUEYZiwUECGPBoxNLJyPyOrBhuTezJ1JGq7dGJEsUF7Ntw9t1Gk3Tz+KCJxlEO1CJL8Qf4qr8lP5Xn5y1yw2Fb3lK2bmrry4DvF5Zm5Gh7X08jjc01efJXUdpNXR5aseXq8muwaP+xXlzHmgjWPxHOw+/EtX5XMlymMFMXjVfPqS4R1WjE3359sfzs94i7PLrXWc62JizdWm5dn/WpI++6qvJPmVflPXvXx/GfNxGPiKTEmdornIYmXxS7xkthLqwviYG3HCJ2VhinSbZH6JNVgYJq89S9dP1t4vUZ/DPVRlBnM0lSJ93/CKmQ0nbkOb/qP28f8F+T3iuefKAIvbODImbptU3HvEKFlpW5zrgIXv9F98LZua6N+OPwEWDyrFq1SNZ8gvAEcdod6HugpmNOWls05Uocsn5O66cpiUsxQ20NSUtcl12VLFrOZVWLpdtiZ0x1uHKE5QvfEp0plk/qv8RGw/bBS+fmsUtl+ThrWgZf6b8C8/UXAeIuJAAAACXBIWXMAAAsTAAALEwEAmpwYAAACyUlEQVQ4EW1TXUgUURQ+Z3ZmnVV3QV2xJbVSEIowQbAfLQx8McLoYX2qjB58MRSkP3vZppceYhGxgrZaIughlYpE7CHFWiiKyj9II0qxWmwlNh1Xtp2f27mz7GDlZX7uuXO+73zfuXeQMQYIgAyALppgyBtse32stsw86txkHhATn+FbfPfzxnPB+vR3RMJYuTwW6bbB4a6WS5O3Yu2VlXIesDiAamiQNKVlVXfx5I0GJ7DY7p0/+erU4dgeMJIA31WNxZmAgibOreXDqF55sY4SFUURqbi+nkjgwTyAbHhLX8yOLsSM2QRA3JRAAgd4RGPbVhkKEp8qeJ7PFyW3fw++YHtC7CkaD0amqyqihSwlMQQ0wa07IjPVI/vbexreIUrVaQV2D4RMQ/o7m12Mdfx4H3PfB9FNzTR1U2cO0Bi45aV6xNvFBNaoIAfbSiwLlqi9/hR/R3Nrhua+Oqi9TEKiB02C7YXz+Pba4MTDrpbLiMAxNgmXb+HpwVkZdoIrkn9isW7nRw/TZYaagZArAWyhfqsSDL/c9aTx7JUjGZCtYExRqCzAwGblwr6aFQ84nTo6qZ7XCeCVQNckE/KSWolvoQnxeoFFgIh8G/nA+kBAxxuQO5m9eFrwLIGJHgcyM63VFMhRSgNVyJr7og8y1vbTQpH8DIEVgxuYuexw0QECIalq5FYgEmpkgoFYltU/lnrqDz5osirSFpF7lrHAFKSWHYfEs+mY/82UnAStyMlW8sUPsVIciTZgz3jV1ebg0CEOpgPF22s1z1YQYKSXPJ1hbAhR8T26WdLhkuVfAzPR+YO1Ox5n58SmCcF6e3uzAoHA77RkevJdWH/3+f2O9TGf3w3fWQ2Hw5F/13mcsWAT+vv6DK4kFApJ/d3d1k+kJtbCrmxXHS3n8ER6b3CQbAqaEHVra6sGxcXW4SovLx+empxapS//FfwD9kpMJjMMBBAAAAAASUVORK5CYII=");

define("text!cockpit/ui/images/pins.png", [], "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAQCAYAAABQrvyxAAAACXBIWXMAAAsTAAALEwEAmpwYAAAGYklEQVRIDbVWe0yURxCf/R735o6DO0FBe0RFsaL4iLXGIKa2SY3P6JGa2GpjlJjUV9NosbU++tYUbEnaQIrVaKJBG7WiNFQFUWO1UUEsVg2CAgoeHHLewcH32O58cBdQsX9Y5+7LfrszOzO/2ZnZj1BKgTBiIwVGVvKd49OVVYunDlXn6wdBKh+ogXrv+DOz1melIb+3LM5fNv2XPYE5EHY+L3PJljN5zavHpJjsQNsA/JJEgyC2+WTjy3b0GfoJW8O4aoHtDwiHQrj5lw1LLyyb1bp5zAjJTus9klrVpdD6TqH2ngVO+0dsRJnp06cLIYU4fx7NnRI3bu7UIYOeJ/McnuY88q3k62gc0S4Dgf5qhICQtIXS2lqD7BhSduPk3YfyzXaANhBBJDxYdUqCywB2qS4RdyUuSkTF/VJxcbH5j8N7/75RuFrN3Zh8OS8zqf5m4UpPeenOyP42dbtBeuvVnCdkK1e4PfPouX03mo9se+c33M8wqDk5Ofqed8REUTicQhbySUxp9u3KlMSHTtrFU6Kyn03lz15PPpW25vsZeYSIKyiVURcqeZJOH9lTNZLfnxRjU/uwrjbEUBWsapcSO2Hq4k0VfZg9EzxdDNCEjDxgNqRDme9umz/btwlsHRIEePHgAf73RdnHZ6LTuIUBN7OBQ+c1Fdnp6cZ1BQUdeRuWZi97o3ktDQQkVeFFzqJARd1A5a0Vr7ta6Kp6TZjtZ+NTIOoKF6qDrL7e0QQIUCiqMMKk8Z1Q/SCSKvzocf2B6NEN0SQn/kTO6fKJ0zqjZUlQBSpJ0GjR77w0aoc1Pr6S5/kVJrNpakV5hR+LWKN4t7sLX+p0rx2vqSta64olIulUKUgCSXLWE1R4KPPSj+5vhm2hdDOG+CkQBmhhyyKq6SaFYWTn5bB3QJRNz54AuXKn8TJjhu0Wbv+wNEKQjVhnmKopjo4FxXmetCRnC4F7BhCiCUepqAepRh0TM/gjjzOOSK2NgWZPc05qampRWJHb7dbOffep2ednzLzgczlbrQA6gHYF9BYDh9GY+FjddMweHMscmMuep07gXlMQoqw9ALoYu5MJsak9QmJA2IvAgVmoCRciooyPujJtNCv1uHt3TmK9gegFKrG9kh6oXwZiIEAtBIjORGKNTWR/WeW8XVkbjuJepLAyloM8LmTN//njKZPbraATZaLjCHEww9Ei4FFiPg6Ja5gT6gxYgLgnRDHRQwJXbz2GOw0d4A3K4GXlUtMahJjYVxiYbrwOmxIS10bFnIBOSi6Tl9Jgs0zbOEX18wyEwgLPMrxD1Y4aCK8kmTpgYcpAF27Mzs42Hjx4kA8BICUlJfKArR7LcEvTB1xEC9AoEw9OPagWkVU/D1oesmK6U911zEczMVe01oZjiMggg6ux2Qk379qh4rYKet4GjrhhwEteBgBrH8BssoXEtbHzPpSBRRSpqlNpgAiUoxzHKxLRszoVuggIisxaDQWZqkQvQjAoax3NbDbLLGuUEABNGedXqSyLRupXgDT5JfAGZNLio9B0X8Uiwk4w77MDc1D4yejjWtykPS3DX01UDCY/GPQcVDe0QYT0CIxGFvUorfvBxZsRfVrUuWruMBAb/lXCUofoFNZfzGJtowXOX0vwUSFK4BgyMKm6P6s9wQUZld+jrYyMDC0iIQDaJdG4IyZQfL3RfbFcCBIlRgc+u3CjaTApuZ9KsANgG8PNzHlWWD3tCxd6kafNNiFp5HAalAkkJ0SCV2H3CgOD9Nc/FqrXuyb0Eocvfhq171p5eyuJ1omKJEP5rQGe/FOOnXtq335z8YmvYo9cHb2t8spIb3lVSseZW46FlGY/Sk9P50P2w20UlWJUkUHIushfc5PXGAzCo0PlD2pnpCYfCXga3lu+fPlevEhWrVrFyrN/Orfv87FOW9tlqb2Kc9pV8DzioMk3UNUbXM+8B/ATBr8C8CKdvGXWGD/9sqm3dkxtzA4McMjHMB8D2ftheYXo+qzt3pXvz8/PP/vk+v8537V+yYW87Zu+RZ1ZbrexoKAA/SBpaWn4+aL5w5zGk+/jW59JiMkESW5urpiVlWXENRb1H/Yf2I9txIxz5IdkX3TsraukpsbQjz6090yb4XsAvQoRE0YvJdamtIIbOnRoUVlZ2ftsLVQzIdEXHntsaZdimssVfCpFui109+BnWPsXaWLI/zactygAAAAASUVORK5CYII=");

define("text!cockpit/ui/images/plus.png", [], "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAYAAAAfSC3RAAAAAXNSR0IArs4c6QAAAAZiS0dEANIA0gDS7KbF4AAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9kFGw4yFTwuJTkAAAH7SURBVCjPdZKxa1NRFMZ/956XZMgFyyMlCZRA4hBx6lBcQ00GoYi4tEstFPwLAs7iLDi7FWuHThaUggihBDI5OWRoQAmBQFISQgvvpbwX3rsOaR4K+o2H8zvfOZxPWWtZqVarGaAJPAEe3ZW/A1+Bd+1221v1qhW4vb1dA44mk0nZ8zyCIAAgk8lgjGF9fb0PHF5cXLQTsF6vP/c879P19TVBEJDJZBARAKIoSmpra2sYY561Wq3PqtFouMBgMBgYay3ZbJZ/yfd9tNaUSqUboOKISPPq6sqsVvZ9H4AvL34B8PTj/QSO45jpdHovn883Ha31znw+JwzDpCEMQx4UloM8zyOdTif3zudztNY7jog8DMMQpRRxHPPt5TCBAEZvxlyOFTsfykRRBICIlB2t9a21Nh3HMXEc8+d7VhJHWCwWyzcohdZaHBHpO46z6fs+IsLj94XECaD4unCHL8FsNouI/HRE5Nx13c3ZbIbWOnG5HKtl+53TSq7rIiLnand31wUGnU7HjEYjlFLJZN/3yRnL1FMYY8jlcmxtbd0AFel2u7dnZ2eXxpi9xWJBEASkUimstYgIQSSkUimKxSKVSgVjzN7p6emPJHL7+/s14KjX65WHwyGz2SxZbWNjg2q12gcOT05O2n9lFeDg4MAAr/4T8rfHx8dJyH8DvvbYGzKvWukAAAAASUVORK5CYII=");

define("text!cockpit/ui/images/throbber.gif", [], "data:image/gif;base64,R0lGODlh3AATAPQAAP///wAAAL6+vqamppycnLi4uLKyssjIyNjY2MTExNTU1Nzc3ODg4OTk5LCwsLy8vOjo6Ozs7MrKyvLy8vT09M7Ozvb29sbGxtDQ0O7u7tbW1sLCwqqqqvj4+KCgoJaWliH/C05FVFNDQVBFMi4wAwEAAAAh/hpDcmVhdGVkIHdpdGggYWpheGxvYWQuaW5mbwAh+QQJCgAAACwAAAAA3AATAAAF/yAgjmRpnmiqrmzrvnAsz3Rt33iu73zv/8CgcEgECAaEpHLJbDqf0Kh0Sq1ar9isdjoQtAQFg8PwKIMHnLF63N2438f0mv1I2O8buXjvaOPtaHx7fn96goR4hmuId4qDdX95c4+RG4GCBoyAjpmQhZN0YGYFXitdZBIVGAoKoq4CG6Qaswi1CBtkcG6ytrYJubq8vbfAcMK9v7q7D8O1ycrHvsW6zcTKsczNz8HZw9vG3cjTsMIYqQgDLAQGCQoLDA0QCwUHqfYSFw/xEPz88/X38Onr14+Bp4ADCco7eC8hQYMAEe57yNCew4IVBU7EGNDiRn8Z831cGLHhSIgdE/9chIeBgDoB7gjaWUWTlYAFE3LqzDCTlc9WOHfm7PkTqNCh54rePDqB6M+lR536hCpUqs2gVZM+xbrTqtGoWqdy1emValeXKwgcWABB5y1acFNZmEvXwoJ2cGfJrTv3bl69Ffj2xZt3L1+/fw3XRVw4sGDGcR0fJhxZsF3KtBTThZxZ8mLMgC3fRatCLYMIFCzwLEprg84OsDus/tvqdezZf13Hvr2B9Szdu2X3pg18N+68xXn7rh1c+PLksI/Dhe6cuO3ow3NfV92bdArTqC2Ebc3A8vjf5QWf15Bg7Nz17c2fj69+fnq+8N2Lty+fuP78/eV2X13neIcCeBRwxorbZrAxAJoCDHbgoG8RTshahQ9iSKEEzUmYIYfNWViUhheCGJyIP5E4oom7WWjgCeBBAJNv1DVV01MZdJhhjdkplWNzO/5oXI846njjVEIqR2OS2B1pE5PVscajkxhMycqLJgxQCwT40PjfAV4GqNSXYdZXJn5gSkmmmmJu1aZYb14V51do+pTOCmA00AqVB4hG5IJ9PvYnhIFOxmdqhpaI6GeHCtpooisuutmg+Eg62KOMKuqoTaXgicQWoIYq6qiklmoqFV0UoeqqrLbq6quwxirrrLTWauutJ4QAACH5BAkKAAAALAAAAADcABMAAAX/ICCOZGmeaKqubOu+cCzPdG3feK7vfO//wKBwSAQIBoSkcslsOp/QqHRKrVqv2Kx2OhC0BAXHx/EoCzboAcdhcLDdgwJ6nua03YZ8PMFPoBMca215eg98G36IgYNvDgOGh4lqjHd7fXOTjYV9nItvhJaIfYF4jXuIf4CCbHmOBZySdoOtj5eja59wBmYFXitdHhwSFRgKxhobBgUPAmdoyxoI0tPJaM5+u9PaCQZzZ9gP2tPcdM7L4tLVznPn6OQb18nh6NV0fu3i5OvP8/nd1qjwaasHcIPAcf/gBSyAAMMwBANYEAhWYQGDBhAyLihwYJiEjx8fYMxIcsGDAxVA/yYIOZIkBAaGPIK8INJlRpgrPeasaRPmx5QgJfB0abLjz50tSeIM+pFmUo0nQQIV+vRlTJUSnNq0KlXCSq09ozIFexEBAYkeNiwgOaEtn2LFpGEQsKCtXbcSjOmVlqDuhAx3+eg1Jo3u37sZBA9GoMAw4MB5FyMwfLht4sh7G/utPGHlYAV8Nz9OnOBz4c2VFWem/Pivar0aKCP2LFn2XwhnVxBwsPbuBAQbEGiIFg1BggoWkidva5z4cL7IlStfkED48OIYoiufYIH68+cKPkqfnsB58ePjmZd3Dj199/XE20tv6/27XO3S6z9nPCz9BP3FISDefL/Bt192/uWmAv8BFzAQAQUWWFaaBgqA11hbHWTIXWIVXifNhRlq6FqF1sm1QQYhdiAhbNEYc2KKK1pXnAIvhrjhBh0KxxiINlqQAY4UXjdcjSJyeAx2G2BYJJD7NZQkjCPKuCORKnbAIXsuKhlhBxEomAIBBzgIYXIfHfmhAAyMR2ZkHk62gJoWlNlhi33ZJZ2cQiKTJoG05Wjcm3xith9dcOK5X51tLRenoHTuud2iMnaolp3KGXrdBo7eKYF5p/mXgJcogClmcgzAR5gCKymXYqlCgmacdhp2UCqL96mq4nuDBTmgBasaCFp4sHaQHHUsGvNRiiGyep1exyIra2mS7dprrtA5++z/Z8ZKYGuGsy6GqgTIDvupRGE+6CO0x3xI5Y2mOTkBjD4ySeGU79o44mcaSEClhglgsKyJ9S5ZTGY0Bnzrj+3SiKK9Rh5zjAALCywZBk/ayCWO3hYM5Y8Dn6qxxRFsgAGoJwwgDQRtYXAAragyQOmaLKNZKGaEuUlpyiub+ad/KtPqpntypvvnzR30DBtjMhNodK6Eqrl0zU0/GjTUgG43wdN6Ra2pAhGtAAZGE5Ta8TH6wknd2IytNKaiZ+Or79oR/tcvthIcAPe7DGAs9Edwk6r3qWoTaNzY2fb9HuHh2S343Hs1VIHhYtOt+Hh551rh24vP5YvXSGzh+eeghy76GuikU9FFEainrvrqrLfu+uuwxy777LTXfkIIACH5BAkKAAAALAAAAADcABMAAAX/ICCOZGmeaKqubOu+cCzPdG3feK7vfO//wKBwSAQIBoSkcslsOp/QqHRKrVqv2Kx2OhC0BAWHB2l4CDZo9IDjcBja7UEhTV+3DXi3PJFA8xMcbHiDBgMPG31pgHBvg4Z9iYiBjYx7kWocb26OD398mI2EhoiegJlud4UFiZ5sm6Kdn2mBr5t7pJ9rlG0cHg5gXitdaxwFGArIGgoaGwYCZ3QFDwjU1AoIzdCQzdPV1c0bZ9vS3tUJBmjQaGXl1OB0feze1+faiBvk8wjnimn55e/o4OtWjp+4NPIKogsXjaA3g/fiGZBQAcEAFgQGOChgYEEDCCBBLihwQILJkxIe/3wMKfJBSQkJYJpUyRIkgwcVUJq8QLPmTYoyY6ZcyfJmTp08iYZc8MBkhZgxk9aEcPOlzp5FmwI9KdWn1qASurJkClRoWKwhq6IUqpJBAwQEMBYroAHkhLt3+RyzhgCDgAV48Wbgg+waAnoLMgTOm6DwQ8CLBzdGdvjw38V5JTg2lzhyTMeUEwBWHPgzZc4TSOM1bZia6LuqJxCmnOxv7NSsl1mGHHiw5tOuIWeAEHcFATwJME/ApgFBc3MVLEgPvE+Ddb4JokufPmFBAuvPXWu3MIF89wTOmxvOvp179evQtwf2nr6aApPyzVd3jn089e/8xdfeXe/xdZ9/d1ngHf98lbHH3V0LMrgPgsWpcFwBEFBgHmyNXWeYAgLc1UF5sG2wTHjIhNjBiIKZCN81GGyQwYq9uajeMiBOQGOLJ1KjTI40kmfBYNfc2NcGIpI4pI0vyrhjiT1WFqOOLEIZnjVOVpmajYfBiCSNLGbA5YdOkjdihSkQwIEEEWg4nQUmvYhYe+bFKaFodN5lp3rKvJYfnBKAJ+gGDMi3mmbwWYfng7IheuWihu5p32XcSWdSj+stkF95dp64jJ+RBipocHkCCp6PCiRQ6INookCAAwy0yd2CtNET3Yo7RvihBjFZAOaKDHT43DL4BQnsZMo8xx6uI1oQrHXXhHZrB28G62n/YSYxi+uzP2IrgbbHbiaer7hCiOxDFWhrbmGnLVuus5NFexhFuHLX6gkEECorlLpZo0CWJG4pLjIACykmBsp0eSSVeC15TDJeUhlkowlL+SWLNJpW2WEF87urXzNWSZ6JOEb7b8g1brZMjCg3ezBtWKKc4MvyEtwybPeaMAA1ECRoAQYHYLpbeYYCLfQ+mtL5c9CnfQpYpUtHOSejEgT9ogZ/GSqd0f2m+LR5WzOtHqlQX1pYwpC+WbXKqSYtpJ5Mt4a01lGzS3akF60AxkcTaLgAyRBPWCoDgHfJqwRuBuzdw/1ml3iCwTIeLUWJN0v4McMe7uasCTxseNWPSxc5RbvIgD7geZLbGrqCG3jepUmbbze63Y6fvjiOylbwOITPfIHEFsAHL/zwxBdvPBVdFKH88sw37/zz0Ecv/fTUV2/99SeEAAAh+QQJCgAAACwAAAAA3AATAAAF/yAgjmRpnmiqrmzrvnAsz3Rt33iu73zv/8CgcEgECAaEpHLJbDqf0Kh0Sq1ar9isdjoQtAQFh2cw8BQEm3T6yHEYHHD4oKCuD9qGvNsxT6QTgAkcHHmFeX11fm17hXwPG35qgnhxbwMPkXaLhgZ9gWp3bpyegX4DcG+inY+Qn6eclpiZkHh6epetgLSUcBxlD2csXXdvBQrHGgoaGhsGaIkFDwjTCArTzX+QadHU3c1ofpHc3dcGG89/4+TYktvS1NYI7OHu3fEJ5tpqBu/k+HX7+nXDB06SuoHm0KXhR65cQT8P3FRAMIAFgVMPwDCAwLHjggIHJIgceeFBg44eC/+ITCCBZYKSJ1FCWPBgpE2YMmc+qNCypwScMmnaXAkUJYOaFVyKLOqx5tCXJnMelcBzJNSYKIX2ZPkzqsyjPLku9Zr1QciVErYxaICAgEUOBRJIgzChbt0MLOPFwyBggV27eCUcmxZvg9+/dfPGo5bg8N/Ag61ZM4w4seDF1fpWhizZmoa+GSortgcaMWd/fkP/HY0MgWbTipVV++wY8GhvqSG4XUEgoYTKE+Qh0OCvggULiBckWEZ4Ggbjx5HXVc58IPQJ0idQJ66XanTpFraTe348+XLizRNcz658eHMN3rNPT+C+G/nodqk3t6a+fN3j+u0Xn3nVTQPfdRPspkL/b+dEIN8EeMm2GAYbTNABdrbJ1hyFFv5lQYTodSZABhc+loCEyhxTYYkZopdMMiNeiBxyIFajV4wYHpfBBspUl8yKHu6ooV5APsZjQxyyeNeJ3N1IYod38cgdPBUid6GCKfRWgAYU4IccSyHew8B3doGJHmMLkGkZcynKk2Z50Ym0zJzLbDCmfBbI6eIyCdyJmJmoqZmnBAXy9+Z/yOlZDZpwYihnj7IZpuYEevrYJ5mJEuqiof4l+NYDEXQpXQcMnNjZNDx1oGqJ4S2nF3EsqWrhqqVWl6JIslpAK5MaIqDeqjJq56qN1aTaQaPbHTPYr8Be6Gsyyh6Da7OkmmqP/7GyztdrNVQBm5+pgw3X7aoYKhfZosb6hyUKBHCgQKij1rghkOAJuZg1SeYIIY+nIpDvf/sqm4yNG5CY64f87qdAwSXKGqFkhPH1ZHb2EgYtw3bpKGVkPz5pJAav+gukjB1UHE/HLNJobWcSX8jiuicMMBFd2OmKwQFs2tjXpDfnPE1j30V3c7iRHlrzBD2HONzODyZtsQJMI4r0AUNaE3XNHQw95c9GC001MpIxDacFQ+ulTNTZlU3O1eWVHa6vb/pnQUUrgHHSBKIuwG+bCPyEqbAg25gMVV1iOB/IGh5YOKLKIQ6xBAcUHmzjIcIqgajZ+Ro42DcvXl7j0U4WOUd+2IGu7DWjI1pt4DYq8BPm0entuGSQY/4tBi9Ss0HqfwngBQtHbCH88MQXb/zxyFfRRRHMN+/889BHL/301Fdv/fXYZ39CCAAh+QQJCgAAACwAAAAA3AATAAAF/yAgjmRpnmiqrmzrvnAsz3Rt33iu73zv/8CgcEgECAaEpHLJbDqf0Kh0Sq1ar9isdjoQtAQFh2fAKXsKm7R6Q+Y43vABep0mGwwOPH7w2CT+gHZ3d3lyagl+CQNvg4yGh36LcHoGfHR/ZYOElQ9/a4ocmoRygIiRk5p8pYmZjXePaYBujHoOqp5qZHBlHAUFXitddg8PBg8KGsgayxvGkAkFDwgICtPTzX2mftHW3QnOpojG3dbYkNjk1waxsdDS1N7ga9zw1t/aifTk35fu6Qj3numL14fOuHTNECHqU4DDgQEsCCwidiHBAwYQMmpcUOCAhI8gJVzUuLGThAQnP/9abEAyI4MCIVOKZNnyJUqUJxNcGNlywYOQgHZirGkSJ8gHNEky+AkS58qWEJYC/bMzacmbQHkqNdlUJ1KoSz2i9COhmQYCEXtVrCBgwYS3cCf8qTcNQ9u4cFFOq2bPLV65Cf7dxZthbjW+CgbjnWtNgWPFcAsHdoxgWWK/iyV045sAc2S96SDn1exYw17REwpLQEYt2eW/qtPZRQAB7QoC61RW+GsBwYZ/CXb/XRCYLsAKFizEtUAc+G7lcZsjroscOvTmsoUvx15PwccJ0N8yL17N9PG/E7jv9S4hOV7pdIPDdZ+ePDzv2qMXn2b5+wTbKuAWnF3oZbABZY0lVmD/ApQd9thybxno2GGuCVDggaUpoyBsB1bGGgIYbJCBcuFJiOAyGohIInQSmmdeiBnMF2GHfNUlIoc1rncjYRjW6NgGf3VQGILWwNjBfxEZcAFbC7gHXQcfUYOYdwzQNxo5yUhQZXhvRYlMeVSuSOJHKJa5AQMQThBlZWZ6Bp4Fa1qzTAJbijcBlJrtxeaZ4lnnpZwpukWieGQmYx5ATXIplwTL8DdNZ07CtWYybNIJF4Ap4NZHe0920AEDk035kafieQrqXofK5ympn5JHKYjPrfoWcR8WWQGp4Ul32KPVgXdnqxM6OKqspjIYrGPDrlrsZtRIcOuR86nHFwbPvmes/6PH4frrqbvySh+mKGhaAARPzjjdhCramdoGGOhp44i+zogBkSDuWC5KlE4r4pHJkarXrj++Raq5iLmWLlxHBteavjG+6amJrUkJJI4Ro5sBv9AaOK+jAau77sbH7nspCwNIYIACffL7J4JtWQnen421nNzMcB6AqpRa9klonmBSiR4GNi+cJZpvwgX0ejj71W9yR+eIgaVvQgf0l/A8nWjUFhwtZYWC4hVnkZ3p/PJqNQ5NnwUQrQCGBBBMQIGTtL7abK+5JjAv1fi9bS0GLlJHgdjEgYzzARTwC1fgEWdJuKKBZzj331Y23qB3i9v5aY/rSUC4w7PaLeWXmr9NszMFoN79eeiM232o33EJAIzaSGwh++y012777bhT0UURvPfu++/ABy/88MQXb/zxyCd/QggAIfkECQoAAAAsAAAAANwAEwAABf8gII5kaZ5oqq5s675wLM90bd94ru987//AoHBIBAgGhKRyyWw6n9CodEqtWq/YrHY6ELQEBY5nwCk7xIWNer0hO95wziC9Ttg5b4ND/+Y87IBqZAaEe29zGwmJigmDfHoGiImTjXiQhJEPdYyWhXwDmpuVmHwOoHZqjI6kZ3+MqhyemJKAdo6Ge3OKbEd4ZRwFBV4rc4MPrgYPChrMzAgbyZSJBcoI1tfQoYsJydfe2amT3d7W0OGp1OTl0YtqyQrq0Lt11PDk3KGoG+nxBpvTD9QhwCctm0BzbOyMIwdOUwEDEgawIOCB2oMLgB4wgMCx44IHBySIHClBY0ePfyT/JCB5weRJCAwejFw58kGDlzBTqqTZcuPLmCIBiWx58+VHmiRLFj0JVCVLl0xl7qSZwCbOo0lFWv0pdefQrVFDJtr5gMBEYBgxqBWwYILbtxPsqMPAFu7blfa81bUbN4HAvXAzyLWnoDBguHIRFF6m4LBbwQngMYPXuC3fldbyPrMcGLM3w5wRS1iWWUNlvnElKDZtz/EEwaqvYahQoexEfyILi4RrYYKFZwJ3810QWZ2ECrx9Ew+O3K6F5Yq9zXbb+y30a7olJJ+wnLC16W97Py+uwdtx1NcLWzs/3G9e07stVPc9kHJ0BcLtQp+c3ewKAgYkUAFpCaAmmHqKLSYA/18WHEiZPRhsQF1nlLFWmIR8ZbDBYs0YZuCGpGXWmG92aWiPMwhEOOEEHXRwIALlwXjhio+BeE15IzpnInaLbZBBhhti9x2GbnVQo2Y9ZuCfCgBeMCB+DJDIolt4iVhOaNSJdCOBUfIlkmkyMpPAAvKJ59aXzTQzJo0WoJnmQF36Jp6W1qC4gWW9GZladCiyJd+KnsHImgRRVjfnaDEKuiZvbcYWo5htzefbl5LFWNeSKQAo1QXasdhiiwwUl2B21H3aQaghXnPcp1NagCqYslXAqnV+zYWcpNwVp9l5eepJnHqL4SdBi56CGlmw2Zn6aaiZjZqfb8Y2m+Cz1O0n3f+tnvrGbF6kToApCgAWoNWPeh754JA0vmajiAr4iOuOW7abQXVGNriBWoRdOK8FxNqLwX3oluubhv8yluRbegqGb536ykesuoXhyJqPQJIGbLvQhkcwjKs1zBvBwSZIsbcsDCCBAAf4ya+UEhyQoIiEJtfoZ7oxUOafE2BwgMWMqUydfC1LVtiArk0QtGkWEopzlqM9aJrKHfw5c6wKjFkmXDrbhwFockodtMGFLWpXy9JdiXN1ZDNszV4WSLQCGBKoQYHUyonqrHa4ErewAgMmcAAF7f2baIoVzC2p3gUvJtLcvIWqloy6/R04mIpLwDhciI8qLOB5yud44pHPLbA83hFDWPjNbuk9KnySN57Av+TMBvgEAgzzNhJb5K777rz37vvvVHRRxPDEF2/88cgnr/zyzDfv/PPQnxACACH5BAkKAAAALAAAAADcABMAAAX/ICCOZGmeaKqubOu+cCzPdG3feK7vfO//wKBwSAQIBoSkcslsOp/QqHRKrVqv2Kx2OhC0BIUCwcMpO84OT2HDbm8GHLQjnn6wE3g83SA3DB55G3llfHxnfnZ4gglvew6Gf4ySgmYGlpCJknochWiId3kJcZZyDn93i6KPl4eniopwq6SIoZKxhpenbhtHZRxhXisDopwPgHkGDxrLGgjLG8mC0gkFDwjX2AgJ0bXJ2djbgNJsAtbfCNB2oOnn6MmKbeXt226K1fMGi6j359D69ua+QZskjd+3cOvY9XNgp4ABCQNYEDBl7EIeCQkeMIDAseOCBwckiBSZ4ILGjh4B/40kaXIjSggMHmBcifHky5gYE6zM2OAlzGM6Z5rs+fIjTZ0tfcYMSlLCUJ8fL47kCVXmTjwPiKJkUCDnyqc3CxzQmYeAxAEGLGJYiwCDgAUT4sqdgOebArdw507IUNfuW71xdZ7DC5iuhGsKErf9CxhPYgUaEhPWyzfBMgUIJDPW6zhb5M1y+R5GjFkBaLmCM0dOfHqvztXYJnMejaFCBQlmVxAYsEGkYnQV4lqYMNyCtnYSggNekAC58uJxmTufW5w55mwKkg+nLp105uTC53a/nhg88fMTmDfDVl65Xum/IZt/3/zaag3a5W63nll1dvfiWbaaZLmpQIABCVQA2f9lAhTG112PQWYadXE9+FtmEwKWwQYQJrZagxomsOCAGVImInsSbpCBhhwug6KKcXXQQYUcYuDMggrASFmNzjjzzIrh7cUhhhHqONeGpSEW2QYxHsmjhxpgUGAKB16g4IIbMNCkXMlhaJ8GWVJo2I3NyKclYF1GxgyYDEAnXHJrMpNAm/rFBSczPiYAlwXF8ZnmesvoOdyMbx7m4o0S5LWdn4bex2Z4xYmEzaEb5EUcnxbA+WWglqIn6aHPTInCgVbdlZyMqMrIQHMRSiaBBakS1903p04w434n0loBoQFOt1yu2YAnY68RXiNsqh2s2qqxuyKb7Imtmgcrqsp6h8D/fMSpapldx55nwayK/SfqCQd2hcFdAgDp5GMvqhvakF4mZuS710WGIYy30khekRkMu92GNu6bo7r/ttjqwLaua5+HOdrKq5Cl3dcwi+xKiLBwwwom4b0E6xvuYyqOa8IAEghwQAV45VvovpkxBl2mo0W7AKbCZXoAhgMmWnOkEqx2JX5nUufbgJHpXCfMOGu2QAd8eitpW1eaNrNeMGN27mNz0swziYnpSbXN19gYtstzfXrdYjNHtAIYGFVwwAEvR1dfxdjKxVzAP0twAAW/ir2w3nzTd3W4yQWO3t0DfleB4XYnEHCEhffdKgaA29p0eo4fHLng9qoG+OVyXz0gMeWGY7qq3xhiRIEAwayNxBawxy777LTXbjsVXRSh++689+7778AHL/zwxBdv/PEnhAAAIfkECQoAAAAsAAAAANwAEwAABf8gII5kaZ5oqq5s675wLM90bd94ru987//AoHBIBAgGhKRyyWw6n9CodEqtWq/YrHY6ELQEhYLD4BlwHGg0ubBpuzdm9Dk9eCTu+MTZkDb4PXYbeIIcHHxqf4F3gnqGY2kOdQmCjHCGfpCSjHhmh2N+knmEkJmKg3uHfgaaeY2qn6t2i4t7sKAPbwIJD2VhXisDCQZgDrKDBQ8aGgjKyhvDlJMJyAjV1gjCunkP1NfVwpRtk93e2ZVt5NfCk27jD97f0LPP7/Dr4pTp1veLgvrx7AL+Q/BM25uBegoYkDCABYFhEobhkUBRwoMGEDJqXPDgQMUEFC9c1LjxQUUJICX/iMRIEgIDkycrjmzJMSXFlDNJvkwJsmdOjQwKfDz5M+PLoSGLQqgZU6XSoB/voHxawGbFlS2XGktAwKEADB0xiEWAodqGBRPSqp1wx5qCamDRrp2Qoa3bagLkzrULF4GCvHPTglRAmKxZvWsHayBcliDitHUlvGWM97FgCdYWVw4c2e/kw4HZJlCwmDBhwHPrjraGYTHqtaoxVKggoesKAgd2SX5rbUMFCxOAC8cGDwHFwBYWJCgu4XfwtcqZV0grPHj0u2SnqwU+IXph3rK5b1fOu7Bx5+K7L6/2/Xhg8uyXnQ8dvfRiDe7TwyfNuzlybKYpgIFtKhAgwEKkKcOf/wChZbBBgMucRh1so5XH3wbI1WXafRJy9iCErmX4IWHNaIAhZ6uxBxeGHXQA24P3yYfBBhmgSBozESpwongWOBhggn/N1aKG8a1YY2oVAklgCgQUUwGJ8iXAgItrWUARbwpqIOWEal0ZoYJbzmWlZCWSlsAC6VkwZonNbMAAl5cpg+NiZwpnJ0Xylegmlc+tWY1mjnGnZnB4QukMA9UJRxGOf5r4ppqDjjmnfKilh2ejGiyJAgF1XNmYbC2GmhZ5AcJVgajcXecNqM9Rx8B6bingnlotviqdkB3YCg+rtOaapFsUhSrsq6axJ6sEwoZK7I/HWpCsr57FBxJ1w8LqV/81zbkoXK3LfVeNpic0KRQG4NHoIW/XEmZuaiN6tti62/moWbk18uhjqerWS6GFpe2YVotskVssWfBOAHACrZHoWcGQwQhlvmsdXBZ/F9YLMF2jzUuYBP4a7CLCnoEHrgkDSCDAARUILAGaVVqAwQHR8pZXomm9/ONhgjrbgc2lyYxmpIRK9uSNjrXs8gEbTrYyl2ryTJmsLCdKkWzFQl1lWlOXGmifal6p9VnbQfpyY2SZyXKVV7JmZkMrgIFSyrIeUJ2r7YKnXdivUg1kAgdQ8B7IzJjGsd9zKSdwyBL03WpwDGxwuOASEP5vriO2F3nLjQdIrpaRDxqcBdgIHGA74pKrZXiR2ZWuZt49m+o3pKMC3p4Av7SNxBa456777rz37jsVXRQh/PDEF2/88cgnr/zyzDfv/PMnhAAAIfkECQoAAAAsAAAAANwAEwAABf8gII5kaZ5oqq5s675wLM90bd94ru987//AoHBIBAgGhKRyyWw6n9CodEqtWq/YrHY6ELQEhYLDUPAMHGi0weEpbN7wI8cxTzsGj4R+n+DUxwaBeBt7hH1/gYIPhox+Y3Z3iwmGk36BkIN8egOIl3h8hBuOkAaZhQlna4BrpnyWa4mleZOFjrGKcXoFA2ReKwMJBgISDw6abwUPGggazc0bBqG0G8kI1tcIwZp51djW2nC03d7BjG8J49jl4cgP3t/RetLp1+vT6O7v5fKhAvnk0UKFogeP3zmCCIoZkDCABQFhChQYuKBHgkUJkxpA2MhxQYEDFhNcvPBAI8eNCx7/gMQYckPJkxsZPLhIM8FLmDJrYiRp8mTKkCwT8IQJwSPQkENhpgQpEunNkzlpWkwKdSbGihKocowqVSvKWQkIOBSgQOYFDBgQpI0oYMGEt3AzTLKm4BqGtnDjirxW95vbvG/nWlub8G9euRsiqqWLF/AEkRoiprX2wLDeDQgkW9PQGLDgyNc665WguK8C0XAnRY6oGPUEuRLsgk5g+a3cCxUqSBC7gsCBBXcVq6swwULx4hayvctGPK8FCwsSLE9A3Hje6NOrHzeOnW695sffRi/9HfDz7sIVSNB+XXrmugo0rHcM3X388o6jr44ceb51uNjF1xcC8zk3wXiS8aYC/wESaLABBs7ch0ECjr2WAGvLsLZBeHqVFl9kGxooV0T81TVhBo6NiOEyJ4p4IYnNRBQiYCN6x4wCG3ZAY2If8jXjYRcyk2FmG/5nXAY8wqhWAii+1YGOSGLoY4VRfqiAgikwmIeS1gjAgHkWYLQZf9m49V9gDWYWY5nmTYCRM2TS5pxxb8IZGV5nhplmhJyZadxzbrpnZ2d/6rnZgHIid5xIMDaDgJfbLdrgMkKW+Rygz1kEZz1mehabkBpgiQIByVikwGTqVfDkk2/Vxxqiqur4X3fksHccre8xlxerDLiHjQIVUAgXr77yFeyuOvYqXGbMrbrqBMqaFpFFzhL7qv9i1FX7ZLR0LUNdcc4e6Cus263KbV+inkAAHhJg0BeITR6WmHcaxhvXg/AJiKO9R77ILF1FwmVdAu6WBu+ZFua72mkZWMfqBElKu0G8rFZ5n4ATp5jkmvsOq+Nj7u63ZMMPv4bveyYy6fDH+C6brgnACHBABQUrkGirz2FwAHnM4Mmhzq9yijOrOi/MKabH6VwBiYwZdukEQAvILKTWXVq0ZvH5/CfUM7M29Zetthp1eht0eqkFYw8IKXKA6mzXfTeH7fZg9zW0AhgY0TwthUa6Ch9dBeIsbsFrYkRBfgTfiG0FhwMWnbsoq3cABUYOnu/ejU/A6uNeT8u4wMb1WnBCyJJTLjjnr8o3OeJrUcpc5oCiPqAEkz8tXuLkPeDL3Uhs4fvvwAcv/PDEU9FFEcgnr/zyzDfv/PPQRy/99NRXf0IIACH5BAkKAAAALAAAAADcABMAAAX/ICCOZGmeaKqubOu+cCzPdG3feK7vfO//wKBwSAQIBoSkcslsOp/QqHRKrVqv2Kx2OhC0BIWCw/AoDziOtCHt8BQ28PjmzK57Hom8fo42+P8DeAkbeYQcfX9+gYOFg4d1bIGEjQmPbICClI9/YwaLjHAJdJeKmZOViGtpn3qOqZineoeJgG8CeWUbBV4rAwkGAhIVGL97hGACGsrKCAgbBoTRhLvN1c3PepnU1s2/oZO6AtzdBoPf4eMI3tIJyOnF0YwFD+nY8e3z7+Xfefnj9uz8cVsXCh89axgk7BrAggAwBQsYIChwQILFixIeNIDAseOCBwcSXMy2sSPHjxJE/6a0eEGjSY4MQGK86PIlypUJEmYsaTKmyJ8JW/Ls6HMkzaEn8YwMWtPkx4pGd76E4DMPRqFTY860OGhogwYagBFoKEABA46DEGBAoEBB0AUT4sqdIFKBNbcC4M6dkEEk22oYFOTdG9fvWrtsBxM23MytYL17666t9phwXwlum2lIDHmuSA2IGyuOLOHv38qLMbdFjHruZbWgRXeOe1nC2BUEDiyAMMHZuwoTLAQX3nvDOAUW5Vogru434d4JnAsnPmFB9NBshQXfa9104+Rxl8e13rZxN+CEydtVsFkd+vDjE7C/q52wOvb4s7+faz025frbxefWbSoQIAEDEUCwgf9j7bUlwHN9ZVaegxDK1xYzFMJH24L5saXABhlYxiEzHoKoIV8LYqAMaw9aZqFmJUK4YHuNfRjiXhmk+NcyJgaIolvM8BhiBx3IleN8lH1IWAcRgkZgCgYiaBGJojGgHHFTgtagAFYSZhF7/qnTpY+faVlNAnqJN0EHWa6ozAZjBtgmmBokwMB01LW5jAZwbqfmlNips4B4eOqJgDJ2+imXRZpthuigeC6XZTWIxilXmRo8iYKBCwiWmWkJVEAkfB0w8KI1IvlIpKnOkVpqdB5+h96o8d3lFnijrgprjbfGRSt0lH0nAZG5vsprWxYRW6Suq4UWqrLEsspWg8Io6yv/q6EhK0Fw0GLbjKYn5CZYBYht1laPrnEY67kyrhYbuyceiR28Pso7bYwiXjihjWsWuWF5p/H765HmNoiur3RJsGKNG/jq748XMrwmjhwCfO6QD9v7LQsDxPTAMKsFpthyJCdkmgYiw0VdXF/Om9dyv7YMWGXTLYpZg5wNR11C78oW3p8HSGgul4qyrJppgllJHJZHn0Y0yUwDXCXUNquFZNLKyYXBAVZvxtAKYIQEsmPgDacr0tltO1y/DMwYpkgUpJfTasLGzd3cdCN3gN3UWRcY3epIEPevfq+3njBxq/kqBoGBduvea8f393zICS63ivRBTqgFpgaWZEIUULdcK+frIfAAL2AjscXqrLfu+uuwx05FF0XUbvvtuOeu++689+7778AHL/wJIQAAOwAAAAAAAAAAAA==");
