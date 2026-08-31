function stringifyDepth(obj, maxDepth) {
    if (maxDepth > 500) {return};
    function convert(value, depth) {
        if (depth >= maxDepth) return "[Max Depth]";

        if (typeof value !== "object" || value === null) {
            return value;
        }

        if (Array.isArray(value)) {
            return value.map(v => convert(v, depth + 1));
        }

        let result = {};

        for (let key in value) {
            result[key] = convert(value[key], depth + 1);
        }

        return result;
    }

    return JSON.stringify(convert(obj, 0), null, 2);
}

window.stringifyDepth = stringifyDepth;