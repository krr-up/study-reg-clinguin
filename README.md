# study-reg-clinguin
Clinguin UI for Study regulations

### Usage

#### Code from ASPOCP_23:
```
clinguin client-server --domain-files instances/instance_ASPOCP_23.lp encodings/encoding_ASPOCP_23.lp --ui-files encodings/ui.lp --custom-classes custom_backend.py --backend CustomBackend -c n=6
```


## Custom Backend
### update_constant(name, value)

> `update_constant(name, value)` allows users 
to set a new value for the constant (name) directly from the UI

To ensure the constant is properly updated in the UI, for declaring a dynamic constant use:
```
current_constant(I) :- n(N), I = 1..N.
```

### custom_download(file_name)

This function is specific to study regulation formatting. It allows users to download a study plan file with a specified name.


### Clinguin version
`Clinguin 1.0.16`



![](out.png)

![](out2.png)

![](out3.png)