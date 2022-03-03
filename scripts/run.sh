. ./scripts/fn_show.sh

datasets=(
    EuroSAT
    CropDisease
    ChestX
    ISIC
    CUB
    Sketch

    DTD
    Omniglot
    Kaokore
    Resisc45
)

models=(
    resnet50_tv
    moco_official
    byol_official
    byol_official_1000
    densecl
    pixpro_official_400
    # scrl_1000
    # detco_200AA
    # resim_fpn_400
    # soco

    byol_corresp_LARS_imagenet_tau_0.3_ep400
)

nshots=(1 5)

mode="test"
while getopts "m:s:d:l:" opt; do
    case ${opt} in
    m)
        mode="$OPTARG"
        ;;
    s)
        nshots=($OPTARG)
        ;;
    d)
        datasets=($OPTARG)
        ;;
    l)
        models=($OPTARG)
        ;;
    esac
done

for nshot in "${nshots[@]}"; do
    for mod in "${models[@]}"; do
        for dat in "${datasets[@]}"; do
            if [ "$mode" = test ]; then
                ckpt="pretrained/ckpt/${mod}/feature.ckpt"
                if [ ! -f "$ckpt" ]; then
                    echo "Checkpoint $ckpt not found"
                    exit 1
                fi
                cmd="python  main.py system=few_shot  data.test_dataset=${dat}_test \
                pretrained=false n_shot=${nshot} launcher=local \
                ckpt=${ckpt} model_name=${mod}_${dat}_${nshot}"
                echo "$cmd"
                eval "$cmd"
            else
                fn_show ${mod}_${dat}_${nshot} ${dat} ${mod}
            fi
        done
        echo "---------------------------------------"
    done

done
