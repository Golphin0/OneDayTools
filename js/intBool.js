class intBool {
	constructor(t, ...r) {
		this.value = 0;
		for (let e = 0; e < r.length; e++) {
			this.value |= !!r[e] << t + e
		}
	}
	setBool(t, r) {
		if (typeof r == "number") {
			r = !!r
		}
		let l = this.value;
		if (Array.isArray(t)) {
			for (let e = 0; e < t.length; e++) {
				if (Array.isArray(r)) {
					l = l & ~(1 << t[e]);
					l = l | r[e] << t[e]
				} else {
					l = l & ~(1 << t[e]);
					l = l | r << t[e]
				}
			}
		} else {
			l = l & ~(1 << t);
			l = l | r << t
		}
		this.value = l
	}
	getBool(e) {
		let t = 1 << e;
		if (e < 0 || e >= 32) return;
		return !!(this.value & t)
	}
	getNumber() {
		return this.value
	}
	getArray() {
		let t = [];
		for (let e = 0; e <= 31; e++) {
			t.push(!!(this.value & 2 ** e))
		}
		return t
	}
}

window.intBool = intBool;