datasets=(
    EuroSAT
    CropDisease
    ChestX
    ISIC
    CUB
    DTD
    Omniglot
    Sketch
)

models=(
    byol_corresp_strong_wolcl_lars_imagenet_ep300
    byol_corresp_optimum_imagenet_ep300
    byol_corresp_optimum_coco_images_ep800
    byol_corresp_strong_wolcl_coco_images_ep800
)

nshots=(1 5)

for nshot in 1 5; do
    for mod in "${models[@]}"; do
        for dat in "${datasets[@]}"; do
            ckpt="pretrained/ckpt/${mod}/feature.ckpt"
            if [ ! -f "$ckpt" ]; then
                echo "Checkpoint $ckpt not found"
                exit 1
            fi
            cmd="python  main.py system=few_shot  data.test_dataset=CropDisease_test \
                pretrained=true n_shot=${nshot} launcher=slurm \
                ckpt=${ckpt} model_name=${mod}_${dat}_${nshot}"

        done
    done

done
