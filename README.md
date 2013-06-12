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

#### Usando os Webhooks ####
A classe Moip::Webhooks foi desenvolvida para ser bem simples de ser usada então veja um exemplo do seu uso:
``` ruby
# como eu costumo usar o rails então
class WebhooksController < ApplicationController
  def moip
    json =  JSON.parse(request.body.read) # hash
    
    # http://moiplabs.github.io/assinaturas-docs/webhooks.html
    # hook.on :model, :event => todo hook enviado pelo moip possui um dado chamado event
    # o valor dele sempre contém model.method, veja a página de webhooks para maiores informações
    # sobre os eventos
    Moip::Webhooks.listen json do |hook|
      # quando o moip envia dado sobre a criação de um plano
      hook.on :plan, :created do
        # quero criar avisar o meu chefe
        # hook.resource pode ser um Plan, Customer, Subscription
        # Invoice ou Payment
        BossMailer.avisa_criacao_de_um_novo_plano(hook.resource).deliver
      end
      
      hook.on :payment, :status_updated do
        # quando o pagamento do meu cliente está confirmado
        if hook.resource.status[:code] == 4
          # vou avisar o meu chefe támbem
          BossMailer.pagamento_do_cliente_confirmado(hook.resource).deliver
          # vou avisar o meu cliente que a assinatura dele está em dia
          ClientMailer.avisa_confirmacao_pagamento(hook.resource).deliver
        end
      end
      
      hook.on :subscription, :created do
        BossMailer.avisa_novo_cliente(hook.resource).deliver
      end
      
    end
    render :text => "done ok"
  end
end
```

### Desenvolvido por: ###
 - Pixxel - http://www.pixxel.net.br
 - Autor - Douglas Rossignolli @xdougx
