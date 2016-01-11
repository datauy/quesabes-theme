module LayoutHelper

  def is_root?
    current_page?("/")
  end

  def header_class
    is_root? ? "dark-ui-header" : "light-ui-header"
  end

  def logo_class
    is_root? ? "logo-blanco" : "logo-color"
  end

  def public_body_follower_count(public_body)
    TrackThing.count(
      :all,
      conditions: ["public_body_id = ?", public_body.id]
    )
  end

  def default_letter
    %{De mi mayor consideración,
Me dirijo a esta Oficina a los efectos de realizar una pedido de
acceso a la información pública, conforme a la ley 18381. Solicito me entregue:

[PEDIDO]

A estos efectos, solicito que se comunique conmigo mediante la
dirección de correo establecida en este pedido, fijando mi
domicilio en [DIRECCION]. A su vez solicito que
la entrega de la información sea preferentemente en formato
electrónico.}
  end
end
