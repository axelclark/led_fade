defmodule LEDFade.Potentiometer do
  alias GrovePi.Analog

  use GrovePi.Poller, default_trigger: LEDFade.Potentiometer.DefaultTrigger,
  read_type: Analog.adc_level

  def read_value(prefix, pin) do
    Analog.read(prefix, pin)
  end
end
