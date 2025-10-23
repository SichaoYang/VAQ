# Fast Adaptive Similarity Search through Variance‑Aware Quantization

# Build
```bash
conda install conda-build anaconda-client
conda build recipe/ -c conda-forge
anaconda login
anaconda upload ${CONDA_PREFIX}/conda-bld/linux-64/vaq-*
```

# Run
```bash
conda install yangsichao::vaq -c conda-forge
python  # demo
```
```python
>>> from pyvaq import VAQ
>>> import numpy as np
>>> vaq = VAQ("VAQ64m16min1max16var0.95,EA")
>>> X = np.random.randn(10000, 256)
>>> X
array([[ 1.54119606,  0.43732189,  1.90074083, ...,  0.64737285,
         0.20214377,  0.33909709],
       [ 0.50324162, -0.05560392,  0.1581431 , ..., -1.66479705,
        -0.87768703,  0.13928501],
       [-0.30148917, -0.86357773, -1.91462358, ...,  1.73831658,
        -0.63978361, -1.36833192],
       ...,
       [ 1.1141101 , -1.10961137, -0.04584684, ..., -0.3277716 ,
        -1.14397973,  0.47233965],
       [-1.17529518, -0.19905397, -0.88658425, ..., -0.24739819,
        -0.96645757, -0.73793957],
       [ 0.93898928, -0.06047205, -0.42528252, ...,  1.01680324,
         0.26434532, -0.26491637]], shape=(10000, 256))
>>> vaq.train(X)
10000 256
VarExplainedPerSubs: 0.0781842
>>> vaq.encode(X)
array([[508, 134, 200, ...,   0,   0,   1],
       [112, 102, 189, ...,   1,   1,   0],
       [269, 414, 163, ...,   0,   1,   0],
       ...,
       [ 87, 302, 242, ...,   0,   0,   0],
       [170, 476, 148, ...,   1,   0,   1],
       [623, 105, 217, ...,   1,   1,   0]],
      shape=(10000, 14), dtype=uint16)
 
```
