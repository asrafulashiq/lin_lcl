function fn_show() {
    filename=$1
    val_data=$2
    system=$3
    METRIC='acc_mean'

    mname="${filename}"
    logpath="test_logs/${mname}"
    if [ ! -e $logpath ]; then
        printf "${system},${val_data},,\n"
        return
    fi
    METRIC_std="acc_std"
    fullpath="${logpath}/$(ls -t ${logpath} | head -1)/log.txt"
    val=$(grep -oP "${METRIC}\W+\d*\.\d+" ${fullpath} | tail -1)
    val=$(grep -oP "\d*\.\d+" <<<"${val}")

    val_std=$(grep -oP "${METRIC_std}\W+\d*\.\d+" ${fullpath} | tail -1)
    val_std=$(grep -oP "\d*\.\d+" <<<"${val_std}")
    printf "${system},${val_data},${val_std},${val}\n"
}
