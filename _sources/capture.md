```stata
//where on your computer is your project directory?
di "what is your globalpath?", _request(globalpath)

//what is the relative path to your data subdirectory?
di "what is your datapath?", _request(filepath)

* At the start of the script use "capture"
cap use "${filepath}transplants.dta", clear

if _rc {
    global datapath = "${globalpath}"
    cap use "${datapath}/transplants.dta", clear
}

if _rc {
    di as error "ERROR: File not found in any path."
    exit 1
}
```
