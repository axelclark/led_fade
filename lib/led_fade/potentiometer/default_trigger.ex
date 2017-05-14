defmodule LEDFade.Potentiometer.DefaultTrigger do
  @behaviour GrovePi.Trigger

  defmodule State do
    @moduledoc false
    defstruct value: 0
  end

  def init(_) do
    {:ok, %State{}}
  end

  def update(value, %{value: value} = state), do: {:ok, state}

  def update(new_value, state) do
    {:new_value, %{state | value: new_value}}
  end
end
