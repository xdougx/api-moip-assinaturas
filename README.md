API MOIP ASSINATURAS
--------------------
### Introdução ###
Gem desenvolvida para consumir a API BETA do Moip Assinaturas Brasil, <br>
a gem segue as **especificações** do MOIP apresentadas neste endereço: <br>
*http://moiplabs.github.io/assinaturas-docs/api.html*

#### Configurando ####

**Instalando a gem**
```bash
$ gem install api-moip-assinaturas
```

**Gemfile**
``` ruby
gem 'api-moip-assinaturas', :git => 'git://github.com/xdougx/api-moip-assinaturas.git', :require => 'moip'
```

**Initializer**
```Ruby
# myapp/config/initializers/moip_assinaturas.rb
require 'moip'
require 'moip/configuration'

Moip.configure do |config|
  config.token = "your secret token"
  config.acount_key = "your secret key"
end 
```

**Planos** <br>
Inicialmente você vai precisar cadastrar os planos de assinaturas
para seus clientes, vamos a um exemplo:

``` ruby
# amount e setup_fee são em centavos
# http://moiplabs.github.io/assinaturas-docs/api.html#criar_plano
params = { code: "plano01", name: "Plano Especial", description: "Descrição do Plano Especial", amount: 990,
           setup_fee: 500, max_qty: 1, interval: { length: 1, unit: "MONTH" }, billing_cycles: 12 }

begin 
  plan = Moip::Plan.build params
  plan.create
rescue Exception => error
  puts error.message
end
```

Para consultar um plano é bem simples:
``` ruby
  plan = Moip::Plan.new
  plan.find "plano01"
  
  puts plan.name
  # => Plano Especial
```

Caso precise atualizar o seu plano
``` ruby
  plan = Moip::Plan.new
  plan.find "plano01"
  
  plan.name = "Plano Muito Especial"
  # => Plano Muito Especial
  
  begin
    plan.update
  rescue Exception => error
    puts error.message
  end
```
Desativar um plano:
``` ruby
  plan = Moip::Plan.new
  plan.find "plano01"
  
  # só será possivel se não haver nenhuma assinatura ativa
  plan.inactivate
  # => true
```

Ativar um plano:
``` ruby
  plan = Moip::Plan.new
  plan.find "plano01"
  
  plan.activate
  # => true
```


### Desenvolvido por: ###
 - Pixxel - http://www.pixxel.net.br
 - Autor - Douglas Rossignolli @xdougx
