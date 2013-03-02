Padrino.configure_apps do
  set :session_secret, '68e5bf477bd3f7017ce690ed1e0c768fb86f25ee065214f035df9e76392fbbec'
end

Padrino.mount("Downthemall").to('/')
