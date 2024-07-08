# Custom Backend


### To run the new StudyReg UI with the custom backend:

```
clinguin client-server --domain-files new/instance/cogsys.lp new/encoding.lp --ui-files new/ui.lp --custom-classes custom_backend/custom_backend.py --backend CustomBackend -c n=6
```


### To run the test ui:

```
clinguin client-server --domain-files test_set_constant_encoding.lp --ui-files test_set_constant_ui.lp --custom-classes custom_backend.py --backend CustomBackend -c n=4
```


## Usage
### update_constant(name, value)

> `update_constant(name, value)` allows users 
to set a new value for the constant (name) directly from the UI

To ensure the constant is properly updated in the UI, for declaring a dynamic constant use:
```
current_constant(I) :- n(N), I = 1..N.
```


