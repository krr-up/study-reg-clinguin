# study-reg-clinguin
Clinguin UI for Study regulations

### Usage

*Encodings from the paper.*

#### Without exams and with info:

`meta.lp` - general encoding

`cogsys.lp` - instance for cogsys

`cogsys_info.lp` - cogsys program information

```
clinguin client-server --domain-files instances/cogsys.lp encodings/meta.lp encodings/cogsys_info.lp --ui-files encodings/ui_main.lp -c n=3
```



## Custom Backend

### ~~custom_download(file_name)~~

~~This function is specific to study regulation formatting. It allows users to download a study plan file with a specified name.~~


### Clinguin version
`Clinguin 2.0.0`