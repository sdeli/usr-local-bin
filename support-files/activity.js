var zozo = {
    nevek: ['timcsi', 'sanci', 'dorci'],
    barom: function () {
        var i = Math.floor(Math.random() * this.nevek.length)
        console.log(this.nevek)
        var nev = this.nevek.splice(i, 1)
        return nev
    }
}

var timcsi = {
    nevek: ['sanci', 'dorci', 'zozi'],
    barom: function () {
        var i = Math.floor(Math.random() * this.nevek.length)
        console.log(this.nevek)
        var nev = this.nevek.splice(i, 1)
        return nev
    }
}

var dorci = {
    nevek: ['sanci', 'timcsi', 'zozi'],
    barom: function () {
        var i = Math.floor(Math.random() * this.nevek.length)
        console.log(this.nevek)
        var nev = this.nevek.splice(i, 1)
        return nev
    }
}

var sanci = {
    nevek: ['dorci', 'timcsi', 'zozi'],
    barom: function () {
        var i = Math.floor(Math.random() * this.nevek.length)
        console.log(this.nevek)
        var nev = this.nevek.splice(i, 1)
        return nev
    }
}
