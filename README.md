# Prerequisite

```
pip install -r requirements.txt
```

# Pretraining

You can find our cross-entropy pretrained model on `mini-ImageNet` in `ckpt/ce_miniImageNet_resnet10`

Or, you can train it by:
```python
python main.py system=ce  backbone=resnet10 data.dataset=miniImageNet_train  model_name=ce_miniImageNet_resnet10 
```

# Test

```python
python main.py system=few_shot  data.test_dataset=EuroSAT_test  ckpt=[ckpt]
```
