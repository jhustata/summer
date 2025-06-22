```stata
/**************************************************************************
 🔁 just-click.do – Self-organizing, reproducible lab file
     ▸ OS-agnostic
     ▸ Modular folder structure
     ▸ Canonical symbolic stages: INIT → COMMIT → FORK → BRANCH → MERGE → OUTPUT
**************************************************************************/

clear all
set more off

* 🌐 Set global slash (optional – only needed for shell calls)
if c(os) == "Windows" {
    global SL "\"
}
else {
    global SL "/"
}

* 🌊 INIT: Define root + core folders (relative to current location)
global root = c(pwd)
foreach folder in data output code notes {
    local fpath = "$root/${SL}`folder'"
    capture mkdir "`fpath'"
    global `folder' "`fpath'"
}

* ❤️ COMMIT: Move all .dta files into /data for cleanliness
local dtafiles : dir "$root" files "*.dta"
foreach f of local dtafiles {
    local src  "$root/${SL}`f'"
    local dest "$data/${SL}`f'"
    copy "`src'" "`dest'", replace
    erase "`src'"
}

* 🌀 FORK: Setup logging and clear memory
capture drop _all
log using "$output${SL}lab5_output.log", replace

* 🐬 BRANCH: Load and prep data
use "$data${SL}transplants.dta", clear
merge 1:1 fake_id using "$data${SL}donors_recipients.dta"
drop if _merge != 3

* 🔁 MERGE: Generate variables, set time-to-event
gen over50 = age > 50
gen f_time = end_d - transplant_d
format transplant_d end_d %td
stset f_time, failure(died)

* 📊 OUTPUT: Graph results
sts graph, by(over50)
graph export "$output${SL}survival_over50.png", replace

* ✅ CLOSE: Done
log close
noi di as result "✅ All done. No errors. Outputs created."

```