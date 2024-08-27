# study-reg-clinguin
Clinguin UI for Study regulations

### Usage

#### Code from ASPOCP_23:
```
clinguin client-server --domain-files instances/instance_ASPOCP_23.lp encodings/encoding_ASPOCP_23.lp --ui-files encodings/ui.lp --custom-classes custom_backend.py --backend CustomBackend -c n=3
```


## Custom Backend

### custom_download(file_name)

This function is specific to study regulation formatting. It allows users to download a study plan file with a specified name.


### Clinguin version
`Clinguin 1.0.32`