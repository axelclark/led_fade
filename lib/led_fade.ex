defmodule LEDFade do
  @moduledoc false
  use GenServer
  require Logger

  defstruct [:potentiometer, :led]

  def start_link(pins) do
    GenServer.start_link(__MODULE__, pins)
  end

  def init([potentiometer, led]) do
    state = %LEDFade{potentiometer: potentiometer, led: led}

    LEDFade.Potentiometer.subscribe(potentiometer, :new_value)
    {:ok, state}
  end

  def handle_info({_, :new_value, %{value: value}}, state) do
    led_value = calc_led(value)
    GrovePi.Analog.write(state.led, led_value)
    {:noreply, state}
  end

  def handle_info(message, state) do
    Logger.info "Received unexpected message: #{inspect message}"

    {:noreply, state}
  end

  defp calc_led(value) do
    round(value / 5)
  end
end
