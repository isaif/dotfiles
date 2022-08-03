vim.cmd([[
  " remove linewise search
  noremap f f
  noremap F F
  noremap ; ;
  noremap , ,

  " change search mapping from s to ss
  " nmap ss <Plug>Lightspeed_s

  " remove the default s mapping
  " I will be using only bi-directional search
  noremap s s
  noremap S S

  " nmap ,s <Plug>Lightspeed_omni_s
  nmap s <Plug>Lightspeed_omni_s
]])
