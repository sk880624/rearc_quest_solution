=~=~=~=~=~=~=~=~=~=~=~= PuTTY log 2022.05.15 21:26:25 =~=~=~=~=~=~=~=~=~=~=~=

'use strict';
const express = require('express');
// constants
const PORT = 8080;
const HOST = '0.0.0.0';

// App
const app = express();
app.get('/', (req, res) => {
  const MSG = process.env.SECRET_WORD
  res.send(`Hello to all from --> ${MSG}`);
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);

[root@ip-172-31-15-18 terraform_rearc_project]# 
