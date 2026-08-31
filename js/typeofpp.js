function type(obj, outputType) {
    let ntype = "";
    let stype = "";

    function set(n, s) { ntype = n; stype = s; }
    function cap(str) { return str.charAt(0).toUpperCase() + str.slice(1); }
    function s(s) { stype = s; ntype = cap(typeof obj); }
 
    do {
        if (typeof obj == "number" || typeof obj == "bigint") {
            set("Numeric", cap(typeof obj));
            break;
        }

        if (typeof obj == "object") {
            if (Array.isArray(obj)) {
                s("DirectArray");
                break;
            }

            if (obj == null) {
                s("Null");
                break;
            }

            if (Object.getPrototypeOf(obj) === Object.prototype) {
                s("DirectObject");
                break;
            }

            let builtins = [
                "URLSearchParams", "URL", "FormData", "File", "Blob",
                "Headers", "Request", "Response", "AbortController", "ReadableStream",
                "WritableStream", "TransformStream", "WebSocket", "EventTarget", "Event",
                "CustomEvent", "DOMParser", "XMLSerializer", "DocumentFragment", "Text",
                "Comment", "AggregateError", "TypeError", "RangeError", "ReferenceError",
                "SyntaxError", "URIError", "Error", "Promise",
                "WeakMap", "WeakSet", "Map", "Set", "RegExp",
                "DataView", "ArrayBuffer", "Float64Array", "Float32Array", "Int32Array",
                "Uint32Array", "Int16Array", "Uint16Array", "Int8Array", "Uint8Array",
                "BigInt64Array", "BigUint64Array", "WeakRef", "Date"
            ];

            let found = false;

            for (let name of builtins) {
                if (obj instanceof globalThis[name]) {
                    s(name);
                    found = true;
                    break;
                }
            }
            if (found) {break};

            s("Unknown")
            break;
        }

        if (typeof obj === "function") {
            s("Function");
            break;
        }

        if (obj == undefined) {
            if (arguments.length === 0) {
                s("Undefined.noInput");
                break;
            }

            s("Undefined");
            break;
        }

        if (typeof obj === "string") {
            s("String");
            break;
        }

        if (typeof obj === "symbol") {
            s("Symbol");
            break;
        }

        if (typeof obj === "boolean") {
            s(obj);
            break;
        }

        set("Unknown", "Unknown");
    } while (false);

    if (outputType === 0) {
        return ntype;
    } else {
        return ntype +":"+ stype;
    }
    
}

window.type = type;