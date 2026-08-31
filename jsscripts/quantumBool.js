class QuantumBool {
    constructor(tpercent) {
        if (!tpercent) {
            tpercent = Math.random();
        }
        if (tpercent > 1) {
            tpercent = 1;
        }

        if (tpercent < 0) {
            tpercent = 0;
        }

        this.tpercent = tpercent;
        this.fpercent = 1 - tpercent;
    }

    observe() {
        let rngnew = Math.random();
        if (rngnew > this.tpercent) {
            this.tpercent = 0;
            this.fpercent = 1;
            return false;
        } else {
            this.tpercent = 1;
            this.fpercent = 0;
            return true;
        }
    }

    observeWithoutCollapse() {
        let rngnew = Math.random();
        if (rngnew > this.tpercent) {
            return false;
        } else {
            return true;
        }
    }

    setPercent(tpercent) {
        this.tpercent = tpercent;
        this.fpercent = 1 - tpercent;
    }

    getPercent() {
        return {"false":this.fpercent, "true":this.tpercent}
    }

    randomizePercent() {
        this.tpercent = Math.random();
        this.fpercent = 1 - this.tpercent
    }
}
