defmodule AppBancoDados.JsonReader do    
    
    def get_json(filename) do
        with {:ok, body} <- File.read(filename),
             {:ok, json} <- Poison.decode(body), do: {:ok, json}
      end

      def extract_body(map) do
        {:ok, body} = map
        body
      end   
end