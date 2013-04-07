require 'active_support/time_with_zone'

Padrino.after_load do
  Time.zone = 'Rome'
end

